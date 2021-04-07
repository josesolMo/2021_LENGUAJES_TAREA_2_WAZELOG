%%%%%%%% %%%%% %%%%%%%% HECHOS %%%%%%%% %%%%% %%%%%%%%

%%%%% LUGARES %%%%%
lugar(["tamarindo"|S], S).
lugar(["heredia"|S], S).
% lugar(["la sabana"|S], S).
% lugar(["pavas"|S], S).
% lugar(["coronado"|S], S).
% lugar(["santo domingo"|S], S).

%%%%% RESPUESTAS %%%%%
% posibles respuestas negativas.
negativo("no").
negativo("ninguno").
% posibles respuestas afirmativas.
afirmativo("si").
afirmativo("afirmativo").

%%%%% PRONOMBRES %%%%%
%pronombre(Tipo, Numero, Pronombre, Oracion).
pronombre(personal, singular,["yo"|S],S).
pronombre(personal, plural,["nosotras"|S],S).
pronombre(personal, plural,["nosotros"|S],S).
pronombre(reflexivo, singular,["me"|S],S).
pronombre(reflexivo, plural,["nos"|S],S).

%%%%% ARTICULOS %%%%%
articulo(masculino, singular, ["el"|S], S).
articulo(masculino, singular, ["al"|S], S).
articulo(masculino, plural, ["a los"|S], S).
articulo(femenino, singular, ["a la"|S], S).
articulo(femenino, plural, ["a las"|S], S).

%%%%% VERBOS %%%%%
%verbo (Tipo, Numero, Verbo, Oracion).
verbo(copulativo, _, ["estoy"|S], S).

verbo(infinitivo, _, ["ir"|S], S).
verbo(infinitivo, _, ["llegar"|S], S).
verbo(infinitivo, _, ["pasar"|S], S).

verbo(intransitivo, singular, ["viajo"|S], S).
verbo(intransitivo, plural, ["vamos"|S], S).

verbo(reflexivo, singular, ["dirijo"|S], S).
verbo(reflexivo, singular, ["voy"|S], S).
verbo(reflexivo, plural, ["dirigirnos"|S], S).
verbo(reflexivo, singular, ["encuentro"|S], S).
verbo(reflexivo, plural, ["encontramos"|S], S).
verbo(reflexivo, singular, ["ubico"|S], S).

verbo(transitivo, singular, ["quiero"|S], S).
verbo(transitivo, plural, ["queremos"|S], S).

%%%%% PREPOSICIONES %%%%%
preposicion(finalidad, ["a"|S], S).
preposicion(tiempo, ["hoy"|S], S).
% preposicion(tiempo, ["manana"|S], S).
% preposicion(tiempo, ["ahorita"|S], S).
% preposicion(tiempo, ["ahora"|S], S).
preposicion(lugar, ["a"|S], S).
% preposicion(lugar, ["para"|S], S).
preposicion(lugar, ["en"|S], S).
% preposicion(lugar, ["cerca de"|S], S).
% preposicion(lugar, ["alrededor de"|S], S).
% preposicion(lugar, ["enfrente de"|S], S).
% preposicion(lugar, ["junto a"|S], S).


%%%%%%%% %%%%% %%%%%%%% SINTAGMAS %%%%%%%% %%%%% %%%%%%%%

%%%%%% SINTAGMA NOMINAL %%%%%%
% % Sintagma nominal con pronombre personal solamente. (Ej: yo, nosotros)
% sintagma_nominal(N, S0, S):-
%     pronombre(personal, N, S0,S).

% % Sintagma nominal con pronombre personal y pronombre reflexivo. (Ej: yo me, nosotros nos)
% sintagma_nominal(N, S0, S):-
%     pronombre(personal, N, S0,S1),
%     pronombre(reflexivo, N, S1,S).


%%%%%% SINTAGMA VERBAL %%%%%%
% % Verbo solo en infinitivo (Ej: pasar).
% sintagma_verbal(N,S0,S):-
%     verbo(infinitivo, N, S0, S).

% % Verbo intransitivo solo (Ej: viajo).
% sintagma_verbal(N,S0,S):-
%     verbo(intransitivo, N, S0, S).

% % Verbo reflexivo, verbo infinitivo (Ej: quiero ir).
% sintagma_verbal(S0,S):-
%     verbo(transitivo, _, S0, S1),
%     verbo(infinitivo, _, S1, S).

% % Verbo reflexivo, a, verbo infinitivo  (Ej: voy a pasar).
% sintagma_verbal(S0,S):-
%     verbo(reflexivo, _, S0, S1),
%     preposicion(finalidad, S1, S2),
%     verbo(infinitivo, _, S2, S).

%%%%%% SINTAGMA PREPOSICIONAL %%%%%%
% Sintagma preposicional con una preposicion de tiempo sola. (Ej: hoy)
sintagma_preposicional(tiempo, S0, S):- 
	preposicion(tiempo, S0, S).

% Sintagma preposicional con una preposicion y un lugar (Ej: a heredia)
sintagma_preposicional(lugar, S0, S):-
	preposicion(lugar, S0, S1),
	lugar(S1, S).

% Sintagma preposicional con un articulo y un lugar (Ej: al supermercado)
sintagma_preposicional(N, S0, S):-
    articulo(_,N,S0,S1),
	lugar(S1, S).


%%%%%%%% %%%%% %%%%%%%% ORACIÓN %%%%%%%% %%%%% %%%%%%%%

% Oración (Ej: Tamarindo.)
oracion(S0,S):-
    lugar(S0,S).

% Oración (Ej: En Tamarindo.)
oracion(S0,S):-
    sintagma_preposicional(lugar,S0,S).

% Oración (Ej: Estoy en Tamarindo.)
oracion(S0,S):-
    verbo(X, _, S0, S1), X\=transitivo, X\=reflexivo, 
    sintagma_preposicional(lugar,S1,S).

%Oración (Ej: Yo estoy en Tamarindo.)
oracion(S0,S):-
    pronombre(personal, N, S0,S1),
    verbo(X, N, S1, S2),  X\=transitivo, X\=reflexivo, 
    sintagma_preposicional(lugar,S2,S).

%Oración (Ej: Yo quiero visitar el establecimiento.)
oracion(S0,S):-
    pronombre(personal, N, S0,S1),
    verbo(transitivo, N, S1, S2),
    verbo(infinitivo, _, S2, S3),
    sintagma_preposicional(N,S3,S).

% Oración (Ej: Me encuentro en Tamarindo.)
oracion(S0,S):-
    pronombre(reflexivo, N, S0,S1),
    verbo(reflexivo, N, S1, S2),
    sintagma_preposicional(lugar,S2,S).

% Oración (Ej: Yo me encuentro en Tamarindo.)
oracion(S0,S):-
    pronombre(personal, N, S0,S1),
    pronombre(reflexivo, N, S1,S2),
    verbo(reflexivo, N, S2, S3),
    sintagma_preposicional(lugar,S3,S).


%%%%%%%%%%% FUNCIONALIDAD %%%%%%%%%%%

% Revisa si es oración según lo estructurado en el BNF
es_oracion(L):-
	oracion(L, []), !.

% Revisa si es un lugar
es_lugar(L, Lugar):-
	miembro(Lugar, L),
	lugar(L, []), !.


% Busca si el lugar existe.
% Input: lista con cada palabra de la oración ingresada por el usuario.
% Output: el lugar encontrado.
destino(X, Lugar):-
	atomo_a_string(X, Y),
	eliminar_puntuacion(Y, Z),
	buscar_lugar(Z, Lugar).

% Buscar lugar en TODA la oración.
% Input: lista con todas las palabras de la oración ingresada por el usuario.
% Output: true en caso de encontrarlo.
buscar_lugar([X|_], Lugar):-
	nth0(0, L, X, []),
	es_lugar(L, Lugar), !.

buscar_lugar([_|Y], Lugar):-
	buscar_lugar(Y, Lugar).

%Funcion miembro.
miembro(X, [X|_]):- !.
miembro(X, [_| R]):- miembro(X,R).

% Convierte cada palabra de un string en un elemento de la lista de salida.
% Input: una lista con átomos 
% Output: lista con los mismos átomos pero en forma de string al revés. Ejemplo: [foo, hola] a ["foo", "hola"]
atomo_a_string(L1, L):-  atomo_a_string(L1,[],L).
atomo_a_string([], L, L).
atomo_a_string([X|L1], L2, L3):-
	downcase_atom(X, Y),
	text_to_string(Y, String),
	atomo_a_string(L1, [String|L2], L3).

% Elimina los signos de puntuacion
% Input: una lista con una oración
% Output: la lista sin signos de puntuación
eliminar_puntuacion(X, S5):-
	delete(X, ",", S1),
	delete(S1, ".", S2),
	delete(S2, "!", S3),
	delete(S3, ";", S4),
	delete(S4, "?", S5).


/** SE */
start :-
    nl,repeat,
    /** Preguntas*/
    writeln('Wazelog - Bienvenido a wazelog! Por Favor indiqueme donde se encuentra.'),
    readln(Start),
    lugar(Start, Lugar),
    %revisa si esta o no, avisa si no esta y pregunta de nuevo.
    display('Place', Lugar).

    writeln('Wazelog - Cual es su destino?'),
    readln(End),
    lugar(End, Lugar),
    %revisa si esta o no, avisa si no esta y pregunta de nuevo.
    display('Place', Lugar).

    writeln('Wazelog - Tiene algun destinointermedio?'),

    writeln('wazelog - Cual establecimiento'),
    
    writeln('wazelog - Donde se encuentrael establecimiento'),

    writeln('Wazelog - ¿Algun destino intermedio?'),

    display('Fin').
    