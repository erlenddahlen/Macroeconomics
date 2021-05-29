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
r_b_2 = 1/18;
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
r_f_2 = 1/13;
r_g = 0.1; %repayment rate on D_g
r_g_2 = 0.2;
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
out2 = sim('sim_part2', sim_time); %%% MMT
out3 = sim('sim_part3', sim_time); %%% N_f

% PLOTTING  
time = out3.D.time;
length_index = size(time,1);
R_vector = R*ones(1,length_index);

% PLOTS

%%% Main Plots 

%%% Financial stability

% Household stability
figure('rend','painters','pos',[1 200 750 800])
subplot(3,2,1)
hold on;
plot(100*out2.H_2, 'b:', 'LineWidth',2);
plot(100*out3.H_2, 'c', 'LineWidth',2);
title("Household interest to wages");
xlabel("Time [Year]");
ylabel("%   ", 'Rotation', 0);
grid on;
axis([50 sim_time 0 35])
hold off;
legend({"MMT", "Negative fee"}, "Location", "northwest");

subplot(3,2,2)
hold on;
plot(100*out2.H_1, 'b:', 'LineWidth',2);
plot(100*out3.H_1, 'c', 'LineWidth',2);
title("Household interest and repayment to wages");
xlabel("Time [Year]");
ylabel("%   ", 'Rotation', 0);
grid on;
axis([50 sim_time 20 50])
hold off;
legend({"MMT", "Negative fee"}, "Location", "northwest");


% Firm stability
subplot(3,2,3)
hold on;
plot(100*out2.F_2, 'b:', 'LineWidth',2);
plot(100*out3.F_2, 'c', 'LineWidth',2);
title("Firm interest to consumption");
xlabel("Time [Year]");
ylabel("%   ", 'Rotation', 0);
grid on;
axis([50 sim_time 0 20])
hold off;
legend({"MMT", "Negative fee"}, "Location", "northwest");

subplot(3,2,4)
hold on;
plot(100*out2.F_1, 'b:', 'LineWidth',2);
plot(100*out3.F_1, 'c', 'LineWidth',2);
title("Firm interest and repayment to consumption");
xlabel("Time [Year]");
ylabel("%   ", 'Rotation', 0);
grid on;
axis([50 sim_time 20 30])
hold off;
legend({"MMT", "Negative fee"}, "Location", "northwest");

% Government stability
subplot(3,2,5)
hold on;
plot(100*out2.G_2, 'b:', 'LineWidth',2);
plot(100*out3.G_2, 'c', 'LineWidth',2);
title("Government interest to taxes");
xlabel("Time [Year]");
ylabel("%   ", 'Rotation', 0);
grid on;
axis([50 sim_time 0 15])
hold off;
legend({"MMT", "Negative fee"}, "Location", "northwest");

subplot(3,2,6)
hold on;
plot(100*out2.G_1, 'b:', 'LineWidth',2);
plot(100*out3.G_1, 'c', 'LineWidth',2);
title("Government interest and repayment to taxes");
xlabel("Time [Year]");
ylabel("%   ", 'Rotation', 0);
grid on;
axis([50 sim_time 20 60])
hold off;
legend({"MMT", "Negative fee"}, "Location", "northwest");


%%% Financial market

figure('rend','painters','pos',[1 200 750 800])
subplot(3,2,1)
hold on;
plot(out2.Fin, 'b:', 'LineWidth',2);
plot(out3.Fin, 'c', 'LineWidth',2);
title("Money in financial market (F)");
xlabel("Time [Year]");
ylabel("$   ", 'Rotation', 0);
grid on;
axis([50 sim_time 0 300])
hold off;
legend({"MMT", "Negative fee"}, "Location", "northwest");

subplot(3,2,2)
hold on;
plot(100*out2.Fin/out2.Yo, 'b:', 'LineWidth',2);
plot(100*out3.Fin/out3.Yo, 'c', 'LineWidth',2);
title("Money in financial market (F) to GDP ");
xlabel("Time [Year]");
ylabel("%   ", 'Rotation', 0);
grid on;
axis([50 sim_time 30 60])
hold off;
legend({"MMT", "Negative fee"}, "Location", "northwest");

subplot(3,2,3)
hold on;
plot(out2.F_o, 'b:', 'LineWidth',2);
plot(out3.F_o, 'c', 'LineWidth',2);
title("New investments (F_o)");
xlabel("Time [Year]");
ylabel("$/Y   ", 'Rotation', 0);
grid on;
axis([50 sim_time 0 300])
hold off;
legend({"MMT", "Negative fee"}, "Location", "northwest");

subplot(3,2,4)
hold on;
plot(100*out2.F_o/out2.Yo, 'b:', 'LineWidth',2);
plot(100*out3.F_o/out3.Yo, 'c', 'LineWidth',2);
title("New investments (F_o) to GDP");
xlabel("Time [Year]");
ylabel("%   ", 'Rotation', 0);
grid on;
axis([50 sim_time 35 65])
hold off;
legend({"MMT", "Negative fee"}, "Location", "northwest");

subplot(3,2,5)
hold on;
plot(out2.F_e, 'b:', 'LineWidth',2);
plot(out3.F_e, 'c', 'LineWidth',2);
title("Equity investments (F_e)");
xlabel("Time [Year]");
ylabel("$/Y   ", 'Rotation', 0);
grid on;
axis([50 sim_time 0 100])
hold off;
legend({"MMT", "Negative fee"}, "Location", "northwest");

subplot(3,2,6)
hold on;
plot(100*out2.F_e/out2.Yo, 'b:', 'LineWidth',2);
plot(100*out3.F_e/out3.Yo, 'c', 'LineWidth',2);
title("Equity investments (F_e) to GDP");
xlabel("Time [Year]");
ylabel("%   ", 'Rotation', 0);
grid on;
axis([50 sim_time 10 25])
hold off;
legend({"MMT", "Negative fee"}, "Location", "northwest");


