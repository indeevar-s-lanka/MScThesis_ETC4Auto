% Configure the manoeuvre
% cd 'C:\Users\indee\Documents\TU Delft\001 Thesis\001 Lab\RT-DiL\system';
% clear; clc;
%% Sine with Dwell
Ts = 1e-3;          % Sample time SG-Veh
% start_acc = 0           % Accelerate from rest
start_ss = 15/Ts;       % stop accelerating --- coasting
stop_pedal = 20;     % Maintain speed till swd
start_swd = 20/Ts+1;
sim_time = 30;          % Total simulation time in seconds

% Steer input
dr_steer = timeseries(zeros(30/Ts+1,1),(0:Ts:30)');
sine_signal = deg2rad(120)*gensig("sine",1.428,1.428,Ts);
N = ceil(0.75*length(sine_signal));
dwell_signal = sine_signal(N)*ones(0.5/Ts+1,1);
swd = [sine_signal(1:N); dwell_signal; sine_signal(N+1:end)];
swd_time = [0:0.001:1.929]';
swd_profile = timeseries(swd,swd_time);
% plot(swd_profile*180/pi); xline([1.07,1.93]); yline(0)
dr_steer.Data(start_swd:start_swd+length(swd)-1) = swd(1:end);

% Desired speed input

man_speed = timeseries(zeros(sim_time/Ts+1,1),(0:Ts:sim_time)');
man_speed.Data = [30*ones(stop_pedal/Ts,1); zeros(sim_time/Ts-stop_pedal/Ts+1,1)];
