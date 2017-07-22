% trajectory params

% time
dt = 0.001;
tf = 1;
tt = (0:dt:tf)';
N = tf/dt+1;

% magnitude
H = 0.01;
L = 0.06;

% trajectory speed
w0 = pi()/tf;

% bias
ab = [0 0 0];
% ab(1) = 0.5;
% ab(2) = 0.5;
ab(3) = 0.5;

% Acc 
ax =     2 * w0^2 * H * cos (2*w0 * tt)*0;
ay = - 0.5 * w0^2 * L * cos (  w0 * tt);
az =     2 * w0^2 * H * cos (2*w0 * tt);

aa = [ax ay az];

% Acc measurements
aam = aa + repmat([0 0 9.8],N,1) + repmat(ab, N,1);

% gyro measurements
ww = 0*aa;

% data matrix
M = [tt aam ww];

save('imu_dock_simulation.txt', 'M', '-ASCII');

vv = zeros(N,3);
pp = zeros(N,3);

for n = 2 : N
    vv(n,:) = vv(n-1,:) + dt*aa(n,:);
    pp(n,:) = pp(n-1,:) + dt*vv(n,:);
end

figure(2)
subplot(2,1,1)
plot(tt,pp)
grid

subplot(2,1,2)
plot(tt,vv)
grid
