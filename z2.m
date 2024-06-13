% Definicje
A = 4;
B = 1;
K = tf(A, [B 1]);
omega = [1,2,3,5,10,25];
t = 0:0.01:10;

% Zmienne wynikowe
ampli = [];
phi = [];

% Pętla obliczająca odpowiedzi układu dla różnych częstotliwości
for omega0 = omega
    u = sin(omega0 * t);
    y = lsim(K, u, t);
    
    % Znajdowanie amplitudy
    ampli_val = max(abs(y));
    
    % Znajdowanie fazy
    [~, idx_u] = max(u); % Szukamy maksimum sygnału wejściowego
    [~, idx_y] = max(y); % Szukamy maksimum sygnału wyjściowego
    phase_shift = (t(idx_y) - t(idx_u)) * omega0;
    phi_val = mod(phase_shift, 2*pi);
    
    % Zapisanie wyników
    ampli = [ampli ampli_val];
    phi = [phi phi_val];
end

% Obliczanie składowych rzeczywistej i urojonej
xArr = ampli .* cos(phi);
yArr = ampli .* sin(phi);

% Rysowanie wykresów
figure;
plot(xArr, yArr, 'o-');
xlim([-3,3]);
ylim([-3,3]);
xlabel('Re');
ylabel('Im');
grid on;

hold on;
plot(xArr, yArr, 'ro-'); % Nałożenie wartości ręcznych
hold off;
grid on;