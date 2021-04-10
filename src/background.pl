%%%% IMPoRTS %%%%%
:-consult(database).
:-consult(gramatica).

%%%% FUNCIoNES AUXILIARES %%%%%
%Funcion miembro.
miembro(X, [X|_]):- !.
miembro(X, [_| R]):- miembro(X,R).

%Funcion invertir(lista, lista invertida).
invertir(X,Y):- invertir(X,Y,[]). 
invertir([],Z,Z).
invertir([Head|Tail],Z, Collector):- invertir(Tail,Z,[Head|Collector]).


%%%%%% BUSQUEDA EN LA BASE %%%%%%

% Revisa si es oracion segun lo estructurado en el BNF
es_oracion(S):-
	oracion(S, []), !.

% Revisa si es una negacion
es_negativo(N):-
	negativo(N,[]), !.

% Revisa si es una afirmacion.
es_afirmativo(Y):-
	afirmativo(Y,[]), !.

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


% Buscar respuesta afirmativa en toda la oracion.
% Input: lista con todas las palabras de la oracion ingresada por el usuario.
% output: true en caso de encontrar afirmacion.
respuesta_afirmativa(X):-
	parseToList(X,Y),
	buscar_respuesta_afirmativa(Y).

buscar_respuesta_afirmativa([X|_]):-
	nth0(0, R, X, []),
	es_afirmativo(R), !.
buscar_respuesta_afirmativa([_|Y]):-
	buscar_respuesta_afirmativa(Y).

% Buscar respuesta negativa en toda la oracion.
% Input: lista con todas las palabras de la oracion ingresada por el usuario.
% output: true en caso de encontrar afirmacion.
respuesta_negativa(X):-
	parseToList(X,Y),
	buscar_respuesta_negativa(Y).

buscar_respuesta_negativa([X|_]):-
	nth0(0, R, X, []),
	es_negativo(R), !.
buscar_respuesta_negativa([_|Y]):-
	buscar_respuesta_negativa(Y).


% Busca si dentro de la oracion hay un local, establecimiento o ciudad existe.
% Input: lista con cada palabra de la oracion ingresada por el usuario.
% output: el lugar encontrado.
search_lugar(X, Lugar):-
	parseToList(X,Y),
	buscar_lugar(Y, Lugar).
% Buscar local, establecimiento o ciudad en ToDA la oracion.
% Input: lista con todas las palabras de la oracion ingresada por el usuario.
% output: true en caso de encontrarlo y Lugar como el lugar.
buscar_lugar([X|_], Lugar):-
	nth0(0, L, X, []),
	( es_ciudad(L, Lugar); es_local(L, Lugar); es_establecimiento(L, Lugar)), !.

buscar_lugar([_|Y], Lugar):-
	buscar_lugar(Y, Lugar).


% Busca si dentro de la oracion hay una ciudad existe.
% Input: lista con cada palabra de la oracion ingresada por el usuario.
% output: el lugar encontrado.
search_ciudad(X, Ciudad):-
	parseToList(X,Y),
	buscar_ciudad(Y, Ciudad).
% Buscar ciudad en ToDA la oracion.
% Input: lista con todas las palabras de la oracion ingresada por el usuario.
% output: true en caso de encontrarlo y Lugar como el lugar.
buscar_ciudad([X|_], Ciudad):-
	nth0(0, L, X, []),
	es_ciudad(L, Ciudad), !.
buscar_ciudad([_|Y], Ciudad):-
	buscar_ciudad(Y, Ciudad).


% Busca si dentro de la oracion hay una ciudad existe.
% Input: lista con cada palabra de la oracion ingresada por el usuario.
% output: el lugar encontrado.
search_local(X, Local):-
	parseToList(X,Y),
	buscar_local(Y, Local).
% Buscar ciudad en ToDA la oracion.
% Input: lista con todas las palabras de la oracion ingresada por el usuario.
% output: true en caso de encontrarlo y Lugar como el lugar.
buscar_local([X|_], Local):-
	nth0(0, L, X, []),
	es_local(L, Local), !.
buscar_local([_|Y], Local):-
	buscar_local(Y, Local).


% Busca si dentro de la oracion hay una ciudad existe.
% Input: lista con cada palabra de la oracion ingresada por el usuario.
% output: el lugar encontrado.
search_establecimiento(X, Establecimiento):-
	parseToList(X,Y),
	buscar_establecimiento(Y, Establecimiento).
% Buscar establecimiento en ToDA la oracion.
% Input: lista con todas las palabras de la oracion ingresada por el usuario.
% output: true en caso de encontrarlo y Lugar como el lugar.
buscar_establecimiento([X|_], Establecimiento):-
	nth0(0, L, X, []),
	es_establecimiento(L, Establecimiento), !.
buscar_establecimiento([_|Y], Establecimiento):-
	buscar_establecimiento(Y, Establecimiento).



%%%%%% PARSEo DE INPUTS %%%%%%
% Convierte cada palabra de un string en un elemento de la lista de salida.
% Input: una lista con atomos 
% output: lista con los mismos atomos pero en forma de string al reves. Ejemplo: [foo, hola] a ["foo", "hola"]
atomo_a_string(L1, L):-  atomo_a_string(L1,[],L).
atomo_a_string([], L, L).
atomo_a_string([X|L1], L2, L3):-
	downcase_atom(X, Y),
	text_to_string(Y, String),
	atomo_a_string(L1, [String|L2], L3).

% Elimina los signos de puntuacion
% Input: una lista con una oracion
% output: la lista sin signos de puntuacion
eliminar_puntuacion(X, S5):-
	delete(X, ",", S1),
	delete(S1, ".", S2),
	delete(S2, "!", S3),
	delete(S3, ";", S4),
	delete(S4, "?", S5).

% Recibe la entrada y la devuelve parseada a lista de strings.
% Input: un string.
% output: lista de strings sin signos de puntuacion.
parseToList(X,W):-
    atomo_a_string(X, Y),
	eliminar_puntuacion(Y, Z),
    invertir(Z,W).


%%%%%% VALIDAR INPUT DEL USUARIo %%%%%%
% Revisa si la entrada del usuario equivale a una oracion.
%Hecho si tiene exito.
validacion_entrada(Input):-
	validacion_entrada_aux(Input),!.

%Hecho si fracasa.
validacion_entrada(Input):-
	error_entrada,
	validacion_entrada(Input).

%validacion del input.
validacion_entrada_aux(Input):-
	readln(Ans),
	parseToList(Ans,Input),
    es_oracion(Input).

% Mensaje de error.
error_entrada:-
    writeln('\n- Lo siento, no entendi').

%%%%%% VALIDAR SI o No %%%%%%
% Revisa si la entrada del usuario equivale a una oracion.
%Hecho si tiene exito.
validacion_si_o_no(Input):-
	validacion_si_o_no_aux(Input),!.

%Hecho si fracasa.
validacion_si_o_no(Input):-
	error_si_o_no,
	validacion_si_o_no(Input).

%validacion del input.
validacion_si_o_no_aux(Input):-
	readln(Ans),
	parseToList(Ans,Input),
    ( es_afirmativo(Input); es_negativo(Input) ).

% Mensaje de error.
error_si_o_no:-
    writeln('\n- ¿Si o no?').

%%%%%% VALIDAR LUGAR INGRESADo %%%%%%
% Revisa si la entrada del usuario existe en la base de datos.
%Hecho si tiene exito.
validacion_lugar(Input):-
	validacion_lugar_aux(Input),!.

%Hecho si fracasa.
validacion_lugar(Input):-
	error_lugar,
	validacion_lugar(Input).

%validacion del lugar.
validacion_lugar_aux(Lugar):-
	validacion_entrada(Ans),
	search_lugar(Ans,Lugar).

% Mensaje de error.
error_lugar:-
    writeln('\nEse lugar no lo conozco. \nIngrese otro, por favor.').


%%%%%% VALIDAR CIUDAD INGRESADA %%%%%%
% Revisa si la entrada del usuario existe en la base de datos.
%Hecho si tiene exito.
validacion_ciudad(Input):-
	validacion_ciudad_aux(Input),!.

%Hecho si fracasa.
validacion_ciudad(Input):-
	error_ciudad,
	validacion_ciudad(Input).

%validacion de la ciudad.
validacion_ciudad_aux(Ciudad):-
	validacion_entrada(Ans),
	search_ciudad(Ans,Ciudad).

% Mensaje de error.
error_ciudad:-
    writeln('\nEsa ciudad no la conozco.\nIngrese otra, por favor.').

%%%%%% VALIDAR LoCAL INGRESADo %%%%%%
% Revisa si la entrada del usuario existe en la base de datos.
%Hecho si tiene exito.
validacion_local(Input):-
	validacion_local_aux(Input),!.

%Hecho si fracasa.
validacion_local(Input):-
	error_local,
	validacion_local(Input).

%validacion del local.
validacion_local_aux(Local):-
	validacion_entrada(Ans),
	search_local(Ans,Local).

% Mensaje de error.
error_local:-
    writeln('\nDisculpe, aun no conozco ese local.\n¡Por favor ingrese uno valido!').