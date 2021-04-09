%------------GRAFO--------------
%Doblemente dirigido

%union(LugarA,LugarB,Peso).

unions("paraiso","orosi",8).
unions("orosi","paraiso",8).

unions("paraiso","cachi",10).
unions("cachi","paraiso",10).

unions("orosi","cachi",12).
unions("cachi","orosi",12).

unions("cartago","paraiso",10).

unions("cartago","san_jose",20).
unions("san_jose","cartago",20).

unions("cartago","tres_rios",8).

unions("tres_rios","san_jose",8).

unions("tres_rios","pacayas",15).
unions("pacayas","tres_rios",15).

unions("cartago","pacayas",13).
unions("pacayas","cartago",13).

unions("pacayas","cervantes",8).
unions("cervantes","pacayas",8).

unions("paraiso","cervantes",4).

unions("cachi","cervantes",7).
unions("cervantes","cachi",7).

unions("cervantes","juan_vinas",5).

unions("juan_vinas","turrialba",4).

unions("turrialba","pacayas",18).

unions("corralillo","san_jose",22).
unions("san_jose","corralillo",22).

unions("corralillo","musgo_verde",6).
unions("musgo_verde","corralillo",6).

unions("musgo_verde","cartago",10).
unions("cartago","musgo_verde",10).

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

%?- findminpath("cartago","Hatillo",W,P).
%?- findminpath("Coronado","cartago",W,P).
%?- findminpath("Guapiles","San Pedro",W,P).
%
% ?- findminpath_t("turrialba","musgo_verde",W,T,P).
% ?- findminpath_t("turrialba","cartago",W,T,P).

%------------------------------------------------------------------
