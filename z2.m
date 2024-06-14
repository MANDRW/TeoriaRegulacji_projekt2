A = 4;
B = 1;
G1 = tf(A, [B 1]);
omega = [1,2,3,5,10];
t = 0:0.01:10;


for omega0 = omega
    u = sin(omega0 * t);%wejscie
    y = lsim(G1, u, t);%wyjscie

    figure;
    plot(t, u, 'b', t, y, 'r');%przebieg
    title(['\omega = ' num2str(omega0)]);
    legend('u(t)', 'y(t)');
    xlabel('t[s]');
    grid on;
end

Am = [3.02476,2.22121,1.74359,1.21575,0.690483]; %amplituda
phi = [(-0.8)*1,(-0.55)*2,(-0.41)*3,(-0.27)*5,(-0.14)*10];%t_x-t_y*omega

xArr = Am .* cos(phi);%obliczenie x
yArr = Am.* sin(phi);%obliczenie y


figure;
plot(xArr, yArr, 'o-');
nyquist(G1);
xlim([-4, 4]);
ylim([-3, 3]);


hold on;
plot(xArr, yArr, 'ro-'); % Nałożenie wartości ręcznych
hold off;

