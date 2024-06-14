% C = A+B = 5 

syms s k_p k_i;

%Transmitancja obiektu inercyjnego
G_2 = 5 / ((s + 2)*(s + 3)*(s - 1));

%Transmitancja regulatora PI
K_r =  k_p + k_i * (1/s);

% % Transmitancja systemu otwartego
K_s = K_r *G_2;

% Transmitancja systemu zamkniętego
K_z = K_s / (1 + K_s);
disp('Transmitancja systemu zamknietego dla regulatora PI:');
pretty(simplify(K_z));

% Otrzymywanie wielomianu charakterystycznego dla macierzy hurwitza 
% (mianownik transmitancji układu zamkniętego)
 [~, d] = numden(K_z);

% Wydobycie z niego wspolczynnikow; ułożenie ich w odpowiedniej 
% kolejnosci dla funkcji routh_hurwitz()
M = fliplr(coeffs(d, s));

% Tworzenie tabeli Routha - Hurwitza
routh_table = routh_hurwitz(M);
disp('Tabela Routha - Hurwitza:');
disp(routh_table);

% Tak samo, jak w przypadku regulatora P, dwa pierwsze elementy są większe
% od 0, więc obliczenia wykonano jedynie dla pozostalych elementow
inequation_1 = routh_table(3,1) > 0;
inequation_2= routh_table(5,1) > 0;
inequation_3 = routh_table(4,1) > 0;

solution = solve([inequation_3, inequation_2, inequation_1], [k_i, k_p], 'ReturnConditions', true);


disp('Obliczone nierownosci:');
disp(inequation_1);
disp(inequation_2);
disp(inequation_3);

disp('Rozwiązanie (Matlab wykorzystuje dodatkowe parametry x i y):')
disp(solution)


%
% Graficzne rozwiązanie nierówności w oparciu o wynik funkcji solve():
%

% Zakres x i y
x_range = linspace(-0.1, 0.1, 500); % Zakres x od -10 do 0
y_range = linspace(1, 2.4, 500);   % Zakres y od 0 do 2

% Siatka wartosci
[X, Y] = meshgrid(x_range, y_range);

% Wyrażenia warunków oraz ich części wspólnej
condition1 = (5*(Y - 8/5).^2)/2 < 8*X + 2/5;
condition2 = X < 0;
condition3 = Y < 2;

condition = condition1 & condition2 & condition3;

% Rysowanie wykresu
figure;
hold on;

% Rysowanie warunków
h1 = contour(X, Y, condition1, [1 1], 'r', 'LineWidth', 2);
h2 = plot([0 0], [min(y_range) max(y_range)], 'g', 'LineWidth', 2);
h3 = plot([min(x_range) max(x_range)], [2 2], 'b', 'LineWidth', 2);

% Zamalowanie części wspólnej
contourf(X, Y, double(condition), [1 1], 'LineColor', 'none', 'FaceAlpha', 0.5);

xlabel('x');
ylabel('y');
title('Warunki stabilności na wykresie z zamalowaną częścią wspólną');

% Dodanie legendy 
h_fake1 = plot(nan, nan, 'r', 'LineWidth', 2);
h_fake2 = plot(nan, nan, 'g', 'LineWidth', 2);
h_fake3 = plot(nan, nan, 'b', 'LineWidth', 2);

legend([h_fake1, h_fake2, h_fake3], {'(5 (y - 8/5)^2) / 2 < 8 z + 2/5', 'x < 0', 'y < 2'});

% Ustawienia wykresu
xlim([min(x_range) max(x_range)]);
ylim([min(y_range) max(y_range)]);
grid on; 
hold off;

%
% Obliczanie przykładowych par k_p i k_i, dla ktorych uklad jest:
%

% 1) stabilny 
[ks1_p, ks1_i] = calculate_kp_ki(-0.02, 1.6);
[ks2_p, ks2_i] = calculate_kp_ki(-0.01, 1.8);
disp('Dwie pary nastaw, dla których układ jest stabilny:')
disp ('      k_p       k_i')
disp([ks1_p, ks1_i])
disp([ks2_p, ks2_i])

% 2) niestabilny 
[kn1_p, kn1_i] = calculate_kp_ki(-0.02, 2.2);
[kn2_p, kn2_i] = calculate_kp_ki(-0.02, 1);
disp('Dwie pary nastaw, dla których układ jest niestabilny:')
disp ('      k_p       k_i')
disp([kn1_p, kn1_i])
disp([kn2_p, kn2_i])

