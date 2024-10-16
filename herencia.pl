% Relaciones familiares
padre(juan, ana).
padre(juan, pedro).
madre(maria, ana).
madre(maria, pedro).
hermano(ana, pedro).
abuelo(pedro, maria).
abuela(carmen, ana).
tio(pedro, carlos).
tia(susana, pedro).
primo(carlos, ana).
primo(luis, pedro).
primo(maria, carlos).

% consanguinidad 

nivelConsanguinidad(X, Y, 1) :- padre(X, Y).
nivelConsanguinidad(X, Y, 1) :- madre(X, Y).

nivelConsanguinidad(X, Y, 2) :- hermano(X, Y).
nivelConsanguinidad(X, Y, 2) :- abuelo(X, Y).
nivelConsanguinidad(X, Y, 2) :- abuela(X, Y).

nivelConsanguinidad(X, Y, 3) :- tio(X, Y).
nivelConsanguinidad(X, Y, 3) :- tia(X, Y).
nivelConsanguinidad(X, Y, 3) :- primo(X, Y).


% Distribuir la herencia segun nivel de consanguinidad
distribuirHerencia(Total, PrimerNivel, SegundoNivel, TercerNivel, Distribucion) :-
    % Calcula la herencia por nivel de consanguinidad
    HerenciaPrimerNivel is Total * 0.30 * PrimerNivel,
    HerenciaSegundoNivel is Total * 0.20 * SegundoNivel,
    HerenciaTercerNivel is Total * 0.10 * TercerNivel,
    % Sumar las partes calculadas
    Suma is HerenciaPrimerNivel + HerenciaSegundoNivel + HerenciaTercerNivel,
    % ajustar
    (Suma > Total -> 
        Ajuste is Total / Suma,
        HerenciaPrimerNivelAjustada is HerenciaPrimerNivel * Ajuste,
        HerenciaSegundoNivelAjustada is HerenciaSegundoNivel * Ajuste,
        HerenciaTercerNivelAjustada is HerenciaTercerNivel * Ajuste,
        Distribucion = [HerenciaPrimerNivelAjustada, HerenciaSegundoNivelAjustada, HerenciaTercerNivelAjustada]
    ;
    % si es menor redistribuir proporcionalmente
    (Suma < Total ->
        Diferencia is Total - Suma,
        % Redistribuir la diferencia proporcionalmente
        Proporcion is Diferencia / Suma,
        HerenciaPrimerNivelAjustada is HerenciaPrimerNivel + (HerenciaPrimerNivel * Proporcion),
        HerenciaSegundoNivelAjustada is HerenciaSegundoNivel + (HerenciaSegundoNivel * Proporcion),
        HerenciaTercerNivelAjustada is HerenciaTercerNivel + (HerenciaTercerNivel * Proporcion),
        Distribucion = [HerenciaPrimerNivelAjustada, HerenciaSegundoNivelAjustada, HerenciaTercerNivelAjustada]
    ;
        % si la suma ya es igual al total
        Distribucion = [HerenciaPrimerNivel, HerenciaSegundoNivel, HerenciaTercerNivel]
    )).

% Caso de prueba 1: $100,000, 2 hijos, 1 hermano, 1 primo
caso1 :-
    distribuirHerencia(100000, 2, 1, 1, Distribucion),
    write('Distribucion para $100,000: '), write(Distribucion), nl.

% Caso de prueba 2: $250,000, 1 hijo, 2 abuelos, 3 tíos
caso2 :-
    distribuirHerencia(250000, 1, 2, 3, Distribucion),
    write('Distribucion para $250,000: '), write(Distribucion), nl.

% Caso de prueba 3: $150,000, 1 hija, 2 hermanos, 2 primos
caso3 :-
    distribuirHerencia(150000, 1, 2, 2, Distribucion),
    write('Distribucion para $150,000: '), write(Distribucion), nl.