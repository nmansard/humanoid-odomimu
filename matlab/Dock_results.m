clear all;
close all;

traj_beforeOptim = load('./imu_dock_beforeOptim.dat');
traj_afterOptim = load('./imu_dock_afterOptim.dat');

t_before = traj_beforeOptim(:,1);
p_before = traj_beforeOptim(:,2:4);
q_before = traj_beforeOptim(:,5:8);
v_before = traj_beforeOptim(:,9:11);
ab_before = traj_beforeOptim(:,12:14);
wb_before = traj_beforeOptim(:,15:17);

t_after = traj_afterOptim(:,1);
p_after = traj_afterOptim(:,2:4);
q_after = traj_afterOptim(:,5:8);
v_after = traj_afterOptim(:,9:11);
ab_after = traj_afterOptim(:,12:14);
wb_after = traj_afterOptim(:,15:17);

exp_KF0 = [0 0 0 0 0 0 1];
exp_KF1 = [0 -0.06 0 0 0 0 1];

figure('Name','Estimated position and velocity','NumberTitle','off');
subplot(2,2,1);
hold on;
plot(t_before, p_before(:,1), 'b');
plot(t_before, p_before(:,2), 'g');
plot(t_before, p_before(:,3), 'r');
plot(t_before(size(t_before,1)), exp_KF1(1), 'b*');
plot(t_before(size(t_before,1)), exp_KF1(2), 'g*');
plot(t_before(size(t_before,1)), exp_KF1(3), 'r*');
xlabel('time (ms)');
ylabel('Estimated P');
legend('Px before optim', 'Py  before optim', 'Pz  before optim', 'expected PX_{KF1}', 'expected PY_{KF1}', 'expected PZ_{KF1}');
title('position estimation before optimization wrt time');

subplot(2,2,2);
hold on;
plot(t_after, p_after(:,1), 'b');
plot(t_after, p_after(:,2), 'g');
plot(t_after, p_after(:,3), 'r');
plot(t_after(size(t_after,1)), exp_KF1(1), 'b*');
plot(t_after(size(t_after,1)), exp_KF1(2), 'g*');
plot(t_after(size(t_after,1)), exp_KF1(3), 'r*');
xlabel('time (ms)');
ylabel('Estimated P');
legend('Px after optim', 'Py after optim', 'Pz after optim', 'expected PX_{KF1}', 'expected PY_{KF1}', 'expected PZ_{KF1}');
title('position estimation after optimization wrt time');

subplot(2,2,3);
hold on;
plot(t_before, v_before(:,1), 'b');
plot(t_before, v_before(:,2), 'g');
plot(t_before, v_before(:,3), 'r');
xlabel('time (ms)');
ylabel('Estimated P');
legend('Vx before optim', 'Vy  before optim', 'Vz  before optim');
title('Velocity estimation before optimization wrt time');

subplot(2,2,4);
hold on;
plot(t_after, v_after(:,1), 'b');
plot(t_after, v_after(:,2), 'g');
plot(t_after, v_after(:,3), 'r');
xlabel('time (ms)');
ylabel('Estimated P');
legend('Vx after optim', 'Vy  after optim', 'Vz  after optim');
title('Velocity estimation after optimization wrt time');