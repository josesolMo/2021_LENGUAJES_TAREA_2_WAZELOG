%------------GRAFO--------------
%Doblemente dirigido

%union(LugarA,LugarB,Peso).

unions('Paraiso','Orosi',8).
unions('Orosi','Paraiso',8).

unions('Paraiso','Cachi',10).
unions('Cachi','Paraiso',10).

unions('Orosi','Cachi',12).
unions('Cachi','Orosi',12).

unions('Cartago','Paraiso',10).

unions('Cartago','San Jose',20).
unions('San Jose','Cartago',20).

unions('Cartago','Tres Rios',8).

unions('Tres Rios','San Jose',8).

unions('Tres Rios','Pacayas',15).
unions('Pacayas','Tres Rios',15).

unions('Cartago','Pacayas',13).
unions('Pacayas','Cartago',13).

unions('Pacayas','Cervantes',8).
unions('Cervantes','Pacayas',8).

unions('Paraiso','Cervantes',4).

unions('Cachi','Cervantes',7).
unions('Cervantes','Cachi',7).

unions('Cervantes','Juan Vinas',5).

unions('Juan Vinas','Turrialba',4).

unions('Turrialba','Pacayas',18).

unions('Corralillo','San Jose',22).
unions('San Jose','Corralillo',22).

unions('Corralillo','Musgo Verde',6).
unions('Musgo Verde','Corralillo',6).

unions('Musgo Verde','Cartago',10).
unions('Cartago','Musgo Verde',10).

%----------------------------------

%Encuentra un camino entre dos nodos especificados
%findminpath(Inicio,Final,Peso,Camino,Lista)
findapath(X, Y, W, [X,Y], _) :- unions(X, Y, W).
findapath(X, Y, W, [X|P], V) :- \+ member(X, V),
                                 unions(X, Z, W1),
                                 findapath(Z, Y, W2, P, [X|V]),
                                 W is W1 + W2.


:-dynamic(solution/2).

%Encuentra el camino más corto entre dos nodos especificados
%findminpath(Inicio,Final,Peso,Camino)
findminpath(X, Y, W, P) :- \+ solution(_, _),
                           findapath(X, Y, W1, P1, []),
                           assertz(solution(W1, P1)),
                           !,
                           findminpath(X,Y,W,P).

findminpath(X, Y, _, _) :- findapath(X, Y, W1, P1, []),
                           solution(W2, P2),
                           W1 < W2,
                           retract(solution(W2, P2)),
                           asserta(solution(W1, P1)),
                           fail.


findminpath(_, _, W, P) :- solution(W,P), retract(solution(W,P)).

% Encuentra el camino más corto entre dos nodos especificados incluyendo
% el tiempo de duracion.
% findminpath_t(Inicio,Final,Peso,Tiempo,Camino)
findminpath_t(X, Y, W, T, P) :- findminpath(X, Y, W, P), T is W * 2.


%------------------------------------------------------------------

%Preguntas de prueba

%?- findminpath('Cartago','Hatillo',W,P).
%?- findminpath('Coronado','Cartago',W,P).
%?- findminpath('Guapiles','San Pedro',W,P).
%
%?- findminpath_t('Turrialba','Musgo Verde',W,T,P).
%?- findminpath_t('Turrialba','Cartago',W,T,P).

%------------------------------------------------------------------
