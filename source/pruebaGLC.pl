% Hechos definidos para el BNF

%%%%% LUGARES %%%%%
lugar(["tamarindo"|S], S).
lugar(["heredia"|S], S).
% lugar(["la sabana"|S], S).
% lugar(["pavas"|S], S).
% lugar(["coronado"|S], S).
% lugar(["santo domingo"|S], S).


%%%%%%%%%%% Gramática libre de contexto %%%%%%%%%%%

%%%%% ORACIONES %%%%%
% Posibles input de oracion que ingrese el usuario.

% % Oración (Ej: cartago).
% oracion(S0,S):-
% 	lugar(S0,S).

% % Oración (Ej: para heredia.)
% oracion(S0,S):-
%     sintagma_preposicional(lugar, S0, S).

% % Oración (Ej: voy/vamos a Sabanilla.)
% oracion(S0,S):-
%     verbo(_, ir, S0, S1),
%     sintagma_preposicional(lugar, S1, S).

% Oración (Ej: quiero/queremos ir a Limon, voy/vamos a ir a Limon.)
oracion(S0,S):-
    sintagma_verbal(_,S0,S1),
    sintagma_preposicional(lugar, S1, S).



% % Oración (Ej: Yo me debo ir a heredia.)
% oracion(S0,S):-
%     pronombre(singular,S0,S1),
%     determinante(singular,S1,S2),
%     sintagma_verbal(plural,S2,S3),
%     sintagma_preposicional(lugar, S3, S).

% % Oración (Ej: Vosotras vamos me quiero ir a heredia.)
% oracion(S0,S):-
%     pronombre(singular,S0,S1),
%     determinante(singular,S1,S2),
%     verbo_conjugado(singular, S2, S3),
%     verbo(singular, ir, S3, S4),
%     sintagma_preposicional(lugar, S4, S).



%%%%%% SINTAGMAS %%%%%%

%%%%%% SINTAGMA NOMINAL %%%%%%
% Definicion de sintagma nominal con solo nombres. (Ej: Cartago)
% sintagma_nominal(S0, S):-
%     lugar(S0, S).


%%%%%% SINTAGMA VERBAL %%%%%%
% % Verbo en singular con lugar (Ej: ir a).
% sintagma_verbal(singular, S0,S):-
%     verbo(singular, ir, S0, S),
% % Verbo en plural con lugar (Ej: dirigimos por tamarindo).
% sintagma_verbal(plural, S0,S):-
%     verbo(plural, ir, S0, S1),

% % Verbo conjugado y otro verbo en singular (Ej: quiero ir)
% sintagma_verbal(singular, S0,S):-
% 	verbo_conjugado(singular, S0, S1),
% 	verbo(singular, ir, S1, S).

% % Verbo conjugado y otro verbo en plural (Ej: deseamos llegar)
% sintagma_verbal(plural, S0,S):-
% 	verbo_conjugado(plural, S0, S1),
% 	verbo(plural, ir, S1, S2).

% Verbo conjugado, preposicion a y otro verbo en singular (Ej: voy a ir)
sintagma_verbal(singular, S0,S):-
	verbo_conjugado(singular, S0, S1),
    preposicion(finalidad, S1, S2),
	verbo(singular, ir, S2, S).

% Verbo conjugado, preposicion a y otro verbo en singular (Ej: voy a ir)
sintagma_verbal(plural, S0,S):-
	verbo_conjugado(plural, S0, S1),
    preposicion(finalidad, S1, S),
    verbo(plural, ir, S2, S).



%%%%%% SINTAGMA PREPOSICIONAL %%%%%%
% Sintagma preposicional con una preposicion de tiempo sola. (Ej: hoy)
sintagma_preposicional(tiempo, S0, S):- 
	preposicion(tiempo, S0, S).
% Sintagma preposicional con una preposicion y un lugar (Ej: a heredia)
sintagma_preposicional(lugar, S0, S):-
	preposicion(lugar, S0, S1),
	lugar(S1, S).




%%%%% VERBOS %%%%%
% Verbo de composicion conjugados (queremos)
verbo_conjugado(singular, ["quiero"|S], S).
% verbo_conjugado(singular, ["debo"|S], S).
verbo_conjugado(singular, ["voy"|S], S).
verbo_conjugado(plural, ["vamos"|S], S).
verbo_conjugado(plural, ["debemos"|S], S).


%%% Verbos importantes relacionados a lugares %%%
verbo(_, ir, ["ir"|S], S).
verbo(_, ir, ["llegar"|S], S).
verbo(_,ir, ["pasar"|S], S).
verbo(plural, ir, ["dirigimos"|S], S).

%%%%% PRONOMBRES %%%%%
%pronombre(Numero, Pronombre, Oracion).
pronombre(singular,[yo|S],S).
pronombre(plural,[nosotras|S],S).
% pronombre(plural,[vosotras|S],S).
% pronombre(plural,[nosotros|S],S).
% pronombre(plural,[vosotros|S],S).

%%%%% DETERMINANTES %%%%%
%determinante(Genero, Numero, Pronombre, Oracion).
determinante(singular, ["me"|S], S).
determinante(plural, ["nos"|S], S).

%%%%% PREPOSICIONES %%%%%
preposicion(finalidad, ["a"|S], S).
preposicion(tiempo, ["hoy"|S], S).
preposicion(lugar, ["a"|S], S).
preposicion(lugar, ["para"|S], S).
preposicion(lugar, ["hacia"|S], S).
% preposicion(lugar, ["cerca de"|S], S).
% preposicion(lugar, ["alrededor de"|S], S).
% preposicion(lugar, ["enfrente de"|S], S).
% preposicion(lugar, ["junto a"|S], S).

% preposicion(tiempo, ["manana"|S], S).
% preposicion(tiempo, ["ahorita"|S], S).
% preposicion(tiempo, ["ahora"|S], S).



