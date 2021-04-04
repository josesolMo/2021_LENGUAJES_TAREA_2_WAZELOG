%------------GRAFO--------------
%Doblemente dirigido

%union(LugarA,LugarB,Peso).

union('Coronado','Paracito',3).
union('Paracito','Coronado',3).

union('Paracito','Guapiles',8).
union('Guapiles','Paracito',8).

union('Guapiles','Siquirres',8).
union('Siquirres','Guapiles',8).

union('Siquirres','Turrialba',8).
union('Turrialba','Siquirres',8).

union('Turrialba','Cartago',8).
union('Cartago','Turrialba',8).

union('Cartago','Orosi',4).
union('Orosi','Cartago',4).

union('Cartago','Taras',1).
union('Taras','Cartago',1).

union('Taras','Tres Rios',2).
union('Tres Rios','Taras',2).

union('Tres Rios','San Pedro',4).
union('San Pedro','Tres Rios',4).

union('Tres Rios','Curridabat',3).
union('Curridabat','Tres Rios',3).

union('Curridabat','Zapote',2).
union('Zapote','Curridabat',2).

union('Zapote','San Pedro',1).
union('San Pedro','Zapote',1).

union('Zapote','Desamparados',3).
union('Desamparados','Zapote',3).

union('Zapote','San Sebastian',2).
union('San Sebastian','Zapote',2).

union('Desamparados','San Sebastian',3).
union('San Sebastian','Desamparados',3).

union('San Sebastian','Hatillo',2).
union('Hatillo','San Sebastian',2).

union('Hatillo','Pavas',4).
union('Pavas','Hatillo',4).

union('Hatillo','San Jose',2).
union('San Jose','Hatillo',2).

union('Pavas','San Jose',2).
union('San Jose','Pavas',2).

union('San Jose','San Pedro',2).
union('San Pedro','San Jose',2).

union('San Jose','Guadalupe',3).
union('Guadalupe','San Jose',3).

union('Guadalupe','San Pedro',2).
union('San Pedro','Guadalupe',2).

union('Coronado','Guadalupe',2).
union('Guadalupe','Coronado',2).


%----------------------------------

%Encuentra un camino entre dos nodos especificados
%findminpath(Inicio,Final,Peso,Camino,Lista)
findapath(X, Y, W, [X,Y], _) :- union(X, Y, W).
findapath(X, Y, W, [X|P], V) :- \+ member(X, V),
                                 union(X, Z, W1),
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

%------------------------------------------------------------------

%Preguntas de prueba

%?- findminpath('Cartago','Hatillo',W,P).
%?- findminpath('Coronado','Cartago',W,P).
%?- findminpath('Guapiles','San Pedro',W,P).

%------------------------------------------------------------------