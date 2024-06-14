A = 4; % parametry G1(s)
B = 1;

G1 = tf(A, [B 1]); % definicja G1(s)

nyquist(G1);% charakterystyka amplitudowo-fazowa



