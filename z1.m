% Parametry transmitancji
A = 4;
B = 1;

% Definicja transmitancji
G1 = tf(A, [B 1]);

% Charakterystyka Nyquista
nyquist(G1);
title('Charakterystyka Nyquista dla G1(s) = 4 / (s + 1)');
grid on;