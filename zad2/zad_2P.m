% C = A+B = 5 

syms s k_p;

%Transmitancja obiektu inercyjnego
G_2 = 5 / ((s + 2)*(s + 3)*(s - 1));

% transmitancja systemu zamkniętego: 
disp('Transmitancja systemu zamkniętego dla regulatora P: ');
K_z = (k_p *G_2) / (1 + k_p * G_2);
pretty(simplify(K_z))

% Otrzymywanie wielomianu charakterystycznego dla macierzy hurwitza 
% (mianownik transmitancji układu zamkniętego)
  [~, d] = numden(K_z); 

% Wydobycie z niego wspolczynnikow; ułożenie ich w odpowiedniej 
% kolejnosci dla napisanej uprzednio funkcji routh_hurwitz()
M = fliplr(coeffs(d, s));

% Stworzenie tabeli Routha - Hurwitza
routh_table = routh_hurwitz(M);
disp('Tabela Routha - Hurwitza:');
disp(routh_table);

% Pierwsze dwa elementy w pierwszej kolumnie są stałymi większymi od zera, 
% wiec nierownosci mozna policzyc tylko dla dwoch ostatnich elementow

inequation_1= routh_table(3,1) > 0;
inequation_2= routh_table(4,1) > 0;
solution = solve([inequation_2, inequation_1], [k_p], 'ReturnConditions', true);

disp('Obliczone nierowności:');
disp(inequation_1);
disp(inequation_2);
disp('Rozwiązanie:');
disp(solution)





   