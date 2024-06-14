%Funkcja tworzy tabele Routha na podstawie zadanych na wejsciu
%wspolczynnkikow
function routh_table = routh_hurwitz(coeff)

    % Sprawdzanie, czy we wspolczynnikach wystepuja parametry
    if ~isa(coeff, 'sym')
        coeff = sym(coeff);
    end

    % Zmienna potrzebna do okreslenia wielkosci tabeli 
    n = length(coeff); 

    % Inicjalizacja tabeli (domyslnie z samymi zerami)
    routh_table = sym(zeros(n, ceil(n/2)));  

    % Wypełnienie pierwszego rzedu
    routh_table(1, :) = coeff(1:2:end);
    
    % Wypełnienie durgiego rzedu 
    if mod(n, 2) == 0
        routh_table(2, :) = coeff(2:2:end);
    else
        routh_table(2, 1:end-1) = coeff(2:2:end);
    end

    % Petla wypelniajaca pozostale rzedy tabeli
    for i = 3:n
        for j = 1:ceil((n-i+1)/2)
            % Sprawdzenie, czy element, ktory w tabeli jest powyzej tego,
            % ktorego chcemy obliczyc jest rowny zero
            if routh_table(i-1, 1) == 0
                %Zastepuje sie zero bardzo małym elementem, zeby uniknac
                %dzielenia przez zero
                routh_table(i-1, 1) = eps;  
            end
            % Wypelnianie elementow poprzez obliczanie wyznaczników
            % macierzy
            routh_table(i, j) = (routh_table(i-1, 1) * routh_table(i-2, j+1) ...
            - routh_table(i-2, 1) * routh_table(i-1, j+1)) / routh_table(i-1, 1);
        end
    end
end