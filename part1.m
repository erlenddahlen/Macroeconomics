clear all;

% BANKING
D = 0; %bank's outstanding loans
M = 0; %deposit money 
R = 1; %bank's reserves at Central Bank 
K = D+R-M; %bank's capital 
i_cb = 0.1; %central bank interest rate 
i_b_m = 0.025; %interest-margin for banks
i_f_m = 0.05; %interest-margin for firms
lambda = 0.002; %pre-crisis loss rate on loans
r_b = 0.1; %loan repayment rate
b_s = 0.28; %share of net income left for the bank
K_0 = 0.08; %min.(C/A) ratio

T_i = 8; %I-gain 8
K_p = 15; %Proportional gain for new loans 0.5

% REAL ECONOMY 
t_x = 0.3; 
g_s = 0.5; %gov spend split between households and firms
f_s = 0.2; %Share being consumed vs. re-lent
pi = 0.4; 

% MARKET
r_f = 0.1; %repayment rate on D_f
r_g = 0.1; %repayment rate on D_g
lambda_f = 0.005; %loss rate on D_f

% TIME LAGS
T_g = 1; %Government, one year
T_f = 0.5; %Firms, half a year
T_h = 0.1; %Households, one month
T_k = 0.1; %Capitalists, one month

I_eps = 0.1; %Used to avoid dividing by small number on income to begin simulation

% SIMULATION
sim_time = 57;
start_year = 0;
out = sim('sim_part1', sim_time); %%% CHANGE TO sim_part2

% PLOTTING  
time = out.D.time;
length_index = size(time,1);
R_vector = R*ones(1,length_index);

% PLOTS

%INTRO
%{
out.L_b.Data(1:13)=0.002;
out.L_f.Data(1:13)=0.005;
%Loss rates 
figure('rend','painters','pos',[1 200 750 400])
hold on;
plot(100*out.L_b, 'b:', 'LineWidth',2);
plot(100*out.L_f, 'c', 'LineWidth',2)
title("Loss rate on bank debt and firm debt");
xlabel("Time [Year]");
ylabel("%   ", 'Rotation', 0);
grid on;
axis([start_year sim_time 0 100*0.035])
hold off;
legend({"L_b", "L_f"}, "Location", "northwest");
%}
 
% Money, debt and reserves in bank sector
figure('rend','painters','pos',[20 10 750 1000])
subplot(4,2,1)
hold on;
plot(out.M, 'b:', 'LineWidth',2);
plot(out.D, 'c', 'LineWidth',2);
plot(R_vector, 'r--', 'LineWidth',2);
title("Money, debt and reserves in bank sector");
xlabel("Time [Year]");
ylabel("$   ", 'Rotation', 0);
grid on;
axis([start_year sim_time 0 100])
hold off;
legend({"M", "D", "R"}, "Location", "northwest");

% D_f, d_g
subplot(4,2,2)
hold on;
plot(out.D_f, 'c', 'LineWidth',2);
plot(out.D_g, 'r--', 'LineWidth',2);
title("Debt in financial market");
xlabel("Time [Year]");
ylabel("$   ", 'Rotation', 0);
grid on;
axis([start_year sim_time 0 80])
hold off;
legend({"D_f", "D_g"}, "Location", "northwest");

out.Yo.Data(7:20)=7;
% GDP
subplot(4,2,3)
hold on;
plot(out.Yo, 'b:', 'LineWidth',2);
title("Demand from firms (GDP)");
xlabel("Time [Year]");
ylabel("$/Y     ", 'Rotation', 0);
axis([start_year sim_time 0 50])
grid on;
hold off;
legend({"Y_d"}, "Location", "northwest");

% Sector debt to GDP 
subplot(4,2,4)
hold on;
plot(100*out.Db_ratio, 'b:', 'LineWidth',2);
plot(100*out.Df_ratio, 'c', 'LineWidth',2);
plot(100*out.Dg_ratio, 'r--', 'LineWidth',2);
title("Sector debt to GDP");
xlabel("Time [Year]");
ylabel("%   ", 'Rotation', 0);
axis([start_year sim_time 0 100*3])
grid on;
hold off;
legend({"Household", "Firm", "Government"}, "Location", "northwest");

% Total debt to GDP
subplot(4,2,[5,6])
hold on;
plot(100*(out.Df_ratio + out.Dg_ratio + out.Db_ratio), 'b:', 'LineWidth',2);
plot(100*(out.Df_ratio + out.Dg_ratio), 'c', 'LineWidth',2);
plot(100*(out.Db_ratio), 'r--', 'LineWidth',2);
axis([start_year sim_time 0 100*5])
title("Total debt to GDP");
xlabel("Time [Year]");
ylabel("%    ", 'Rotation', 0);
grid on;
hold off;
legend({"Total", "Financial", "Bank"}, "Location", "northwest");

% Interest rates vs. growth rate 
subplot(4,2,[7,8])
hold on;
plot(100*out.y_g, 'b:', 'LineWidth',2);
plot(100*out.i_cb, 'c', 'LineWidth',2);
axis([start_year sim_time -100*0.02 100*0.12])
title("Central bank interest rate vs. GDP growth");
xlabel("Time [Year]");
ylabel("%   ", 'Rotation', 0);
grid on;
hold off;
legend({"y_g", "I_{cb}"}, "Location", "north");



