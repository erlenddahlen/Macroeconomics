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
loss_eq = 2; %loss rate multiplier from corporate debt to equity market 
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
sim_time = 100;
start_year = 0;
out = sim('sim_part2', sim_time); %%% CHANGE TO sim_part2

% PLOTTING  
eps = 0.00001; %Used to avoid diving by zero in some instances
time = out.D.time;
length_index = size(time,1);
R_vector = R*ones(1,length_index);

% PLOTS

%INTRO

% Money, debt and reserves in bank sector
figure('rend','painters','pos',[1 200 750 800])
subplot(3,2,1)
hold on;
plot(out.M, 'b:', 'LineWidth',2);
plot(out.D, 'c', 'LineWidth',2);
plot(1+out.D_gr, 'r--', 'LineWidth',2);
title("Money, debt and reserves in bank sector");
xlabel("Time [Year]");
ylabel("");
grid on;
axis([start_year sim_time 0 800])
hold off;
legend({"Money", "Debt", "Reserves"}, "Location", "northwest");

% D_f, d_g
subplot(3,2,2)
hold on;
plot(out.D_f, 'c', 'LineWidth',2);
plot(out.D_g, 'r--', 'LineWidth',2);
title("Debt in financial market");
xlabel("Time [Year]");
ylabel("");
grid on;
axis([start_year sim_time 0 700])
hold off;
legend({"Firm", "Government"}, "Location", "northwest");

out.Yo.Data(7:20)=7;
% GDP
subplot(3,2,3)
hold on;
plot(out.Yo, 'b:', 'LineWidth',2);
title("GDP");
xlabel("Time [Year]");
ylabel("");
axis([start_year sim_time 0 500])
grid on;
hold off;

% Specific debt to GDP 
subplot(3,2,4)
hold on;
plot(out.Db_ratio, 'b:', 'LineWidth',2);
plot(out.Df_ratio, 'c', 'LineWidth',2);
plot(out.Dg_ratio + out.Dgr_ratio, 'r--', 'LineWidth',2);
title("Debt to GDP");
xlabel("Time [Year]");
ylabel("");
axis([start_year sim_time 0 2])
grid on;
hold off;
legend({"Household", "Firm", "Government"}, "Location", "southeast");

% Total debt to GDP 
subplot(3,2,[5:6])
hold on;
plot(out.Df_ratio + out.Dg_ratio + out.Db_ratio + out.Dgr_ratio, 'b:', 'LineWidth',2);
plot(out.Df_ratio + out.Dg_ratio, 'c', 'LineWidth',2);
plot(out.Db_ratio + out.Dgr_ratio, 'r--', 'LineWidth',2);
axis([start_year sim_time 0 5])
title("Debt to GDP");
xlabel("Time [Year]");
ylabel("");
grid on;
hold off;
legend({"Total", "Financial", "Bank"}, "Location", "northwest");


% PLOT 2

% Interest rates vs. growth rate 
figure('rend','painters','pos',[1 200 750 800])
subplot(3,2,[1:2])
hold on;
plot(out.y_g, 'b:', 'LineWidth',2);
plot(out.i_cb, 'c', 'LineWidth',2);
axis([start_year sim_time -0.02 0.12])
title("Central bank interest rate vs. GDP growth");
xlabel("Time [Year]");
ylabel("");
grid on;
hold off;
legend({"g_{GDP}", "I_{cb}"}, "Location", "northeast");

%Interest rates
subplot(3,2,3)
hold on
plot(out.i_f, 'c', 'LineWidth',2);
plot(out.i_b, 'b:', 'LineWidth',2);
plot(out.i_cb, 'r--', 'LineWidth',2);
title("Interest rates");
xlabel("Time [Year]");
ylabel("");
grid on;
axis([start_year sim_time 0 0.17])
hold off;
legend({"Firm", "Household", "Government"}, "Location", "north");


% Specific debt service flow to GDP
subplot(3,2,4)
hold on
plot(out.DS_b/out.Yo, 'b:', 'LineWidth',2);
plot(out.DS_f/out.Yo, 'c', 'LineWidth',2);
plot((out.DS_gr+out.DS_g)/out.Yo, 'r--', 'LineWidth',2);
title("Debt service to GDP");
xlabel("Time [Year]");
ylabel("");
grid on;
axis([start_year sim_time 0 0.5])
hold off;
legend({"Household", "Firm", "Government"}, "Location", "north");


% Debt service flow to GDP
subplot(3,2,[5:6])
hold on
plot((out.DS_f+out.DS_b+out.DS_g+out.DS_gr)/out.Yo, 'b:', 'LineWidth',2);
plot((out.DS_f+out.DS_g)/out.Yo, 'c', 'LineWidth',2);
plot((out.DS_gr+out.DS_b)/out.Yo, 'r--', 'LineWidth',2);
axis([start_year sim_time 0 0.9])
title("Debt service to GDP");
xlabel("Time [Year]");
ylabel("");
grid on;
hold off;
legend({"Total", "Financial", "Bank"}, "Location", "north");




%{

% Unused Plots

% Debt service flow
subplot(3,2,4)
hold on
plot(out.DS_f+out.DS_b+out.DS_g+out.DS_gr, 'b:', 'LineWidth',2);
plot(out.DS_f+out.DS_g, 'c', 'LineWidth',2);
plot(out.DS_gr+out.DS_b, 'r--', 'LineWidth',2);
title("Total, financial and bank debt service flow");
xlabel("Time [Year]");
ylabel("");
grid on;
axis([start_year sim_time 0 300])
hold off;
legend({"Total", "Fin", "Bank"}, "Location", "northwest");

% Loss rates 
figure('rend','painters','pos',[1 600 750 400])
hold on;
plot(out.loss_b, 'b:', 'LineWidth',2);
plot(out.loss_f, 'c', 'LineWidth',2);
axis([0 sim_time 0 0.05])
title("Loss rates");
xlabel("Time [Year]");
ylabel("");
grid on;
hold off;
legend({"l_b", "l_f"}, "Location", "northeast");

% Capitalist flows 
subplot(3,2,[5:6])
hold on;
plot(out.flow_eq.time,smoothdata(out.flow_eq.data), 'b:', 'LineWidth',2);
%plot(out.Flow, 'b:', 'LineWidth',2);
plot(out.flow_dc.time,smoothdata(out.flow_dc.data), 'c', 'LineWidth',2);
plot(out.flow_dg, 'r--', 'LineWidth',2);
%axis([0 sim_time -0.02 0.12])
title("Flow of money into respective markets");
xlabel("Time [Year]");
ylabel("");
axis([0 sim_time 0 10])
grid on;
hold off;
legend({"Eq", "D_c", "D_g"}, "Location", "northwest");


% DSL 
figure('rend','painters','pos',[1 600 750 400])
hold on;
plot(out.DSL_b, 'b:', 'LineWidth',2); %Removed from Simulink 
plot(out.DSL_f, 'c', 'LineWidth',2);
%axis([0 sim_time -0.04 0.12])
title("Debt service levels");
xlabel("Time [Year]");
ylabel("");
grid on;
hold off;
legend({"housing", "firms"}, "Location", "northeast");

%}

