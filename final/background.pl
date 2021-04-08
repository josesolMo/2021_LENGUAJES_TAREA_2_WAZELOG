%%%% IMPORTS %%%%%
:-consult(database).
:-consult(gramatica).

%%%% FUNCIONES AUXILIARES %%%%%
%Funcion miembro.
miembro(X, [X|_]):- !.
miembro(X, [_| R]):- miembro(X,R).

%Funcion invertir(lista, lista invertida).
invertir(X,Y):- invertir(X,Y,[]). 
invertir([],Z,Z).
invertir([Head|Tail],Z, Collector):- invertir(Tail,Z,[Head|Collector]).


%%%%%% BUSQUEDA EN LA BASE %%%%%%

% Revisa si es oración según lo estructurado en el BNF
es_oracion(S):-
	oracion(S, []), !.

% Revisa si es una negacion
es_negativo(N):-
	negativo(N), !.

% Revisa si es una afirmacion.
es_afirmativo(Y):-
	afirmativo(Y), !.

% Revisa si es una ciudad.
es_ciudad(C, Ciudad):-
	miembro(Ciudad, C),
	ciudad(C, []), !.

es_ciudad(Ciudad):-
	miembro(Ciudad, C),
	ciudad(C, []), !.

% Revisa si es una local.
es_local(L, Local):-
	miembro(Local, L),
	local(L, []), !.

es_local(Local):-
	miembro(Local, L),
	local(L, []), !.

% Revisa si es una establecimiento.
es_establecimiento(E, Establecimiento):-
	miembro(Establecimiento, E),
	establecimiento(E, []), !.

es_establecimiento(Establecimiento):-
	miembro(Establecimiento, E),
	establecimiento(E, []), !.

% Busca si respuesta es afirmativa.
% Input: lista con cada palabra de la oración ingresada por el usuario.
% Output: true en caso de encontrar respuesta afirmativa.
respuesta_afirmativa(X):-
    parseToList(X,Z),
    es_afirmativo(R),
    miembro(R,Z),!.

% Busca si respuesta es afirmativa.
% Input: lista con cada palabra de la oración ingresada por el usuario.
% Output: true en caso de encontrar respuesta afirmativa.
respuesta_negativa(X):-
    parseToList(X,Z),
    es_negativo(R),
    miembro(R,Z),!.

% Busca si dentro de la oracion hay un local, establecimiento o ciudad existe.
% Input: lista con cada palabra de la oración ingresada por el usuario.
% Output: el lugar encontrado.
lugar(X, Lugar):-
	parseToList(X,Y),
	buscar_lugar(Y, Lugar).

% Buscar local, establecimiento o ciudad en TODA la oración.
% Input: lista con todas las palabras de la oración ingresada por el usuario.
% Output: true en caso de encontrarlo.
buscar_lugar([X|_], Lugar):-
	nth0(0, L, X, []),
	( es_ciudad(L, Lugar); es_local(L, Lugar); es_establecimiento(L, Lugar)), !.

buscar_lugar([_|Y], Lugar):-
	buscar_lugar(Y, Lugar).


%%%%%% PARSEO DE INPUTS %%%%%%
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

% Recibe la entrada y la devuelve parseada a lista de strings.
% Input: un string.
% Output: lista de strings sin signos de puntuacion.
parseToList(X,W):-
    atomo_a_string(X, Y),
	eliminar_puntuacion(Y, Z),
    invertir(Z,W).


%%%%%% VALIDAR INPUT DEL USUARIO %%%%%%
% Mensaje de error.
error:-
    writeln('Lo siento, no entendí').

validacion(Input):-
	validacion_entrada(Input),!.

validacion(Input):-
	error,
	validacion(Input).

% Revisa si la entrada del usuario equivale a una oracion.
validacion_entrada(Input):-
	readln(Ans),
	parseToList(Ans,Input),
    es_oracion(Input).