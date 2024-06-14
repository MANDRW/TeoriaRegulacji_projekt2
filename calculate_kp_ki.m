%Pomocnicza funkcja, sluzaca do obliczania k_p i k_i 
% w oparciu o parametry, których Matlab używa do obliczania nierownosci
function [k1, k2] = calculate_kp_ki(x, y)
    % Obliczanie k2
    k2 = -(y/16 - 1/8)*(5*y + (x - 5*y*(y/16 - 1/8))/(y/16 - 1/8));

    % Obliczanie k1
    k1 = y;
end
