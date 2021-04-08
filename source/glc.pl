%%%%%%%% %%%%% %%%%%%%% HECHOS %%%%%%%% %%%%% %%%%%%%%

%%%%% LUGARES %%%%%
lugar(["turrialba"|S], S).
lugar(["cachi"|S], S).
lugar(["orosi"|S], S).
lugar(["paraiso"|S], S).
lugar(["cartago"|S], S).
lugar(["cervantes"|S], S).
lugar(["juan vinas"|S], S).
lugar(["pacayas"|S], S).
lugar(["tres rios"|S], S).
lugar(["musgo verde"|S], S).
lugar(["san jose"|S], S).
lugar(["corralillo"|S], S).


local("nombre",lugar).
local("nombre",lugar).

%%%%% RESPUESTAS %%%%%
% posibles respuestas negativas.
negativo("no").
negativo("ninguno").
negativo(["no"|S], S).
negativo(["ninguno"|S], S).
% posibles respuestas afirmativas.
afirmativo("si").
afirmativo("afirmativo").
afirmativo(["si"|S], S).
afirmativo(["afirmativo"|S], S).

%%%%% PRONOMBRES %%%%%
%pronombre(Tipo, Numero, Pronombre, Oracion).
pronombre(personal, singular,["yo"|S],S).
pronombre(personal, plural,["nosotras"|S],S).
pronombre(personal, plural,["nosotros"|S],S).
pronombre(reflexivo, singular,["me"|S],S).
pronombre(reflexivo, plural,["nos"|S],S).
pronombre(posesivo, singular,["mi"|S],S).
pronombre(posesivo, singular,["nuestro"|S],S).

%%%%% ARTICULOS %%%%%
%pronombre(Genero, Numero, Articulo, Oracion).
articulo(masculino, singular, ["el"|S], S).
articulo(masculino, singular, ["al"|S], S).
articulo(masculino, plural, ["a los"|S], S).
articulo(femenino, singular, ["a la"|S], S).
articulo(femenino, plural, ["a las"|S], S).

%%%%% SUSTANTIVO %%%%%
%pronombre(Genero, Numero, Sustantivo, Oracion).
sustantivo(masculino, singular,["destino"|S], S).
sustantivo(masculino, singular,["lugar"|S], S).

%%%%% ADJETIVO %%%%%
%pronombre(Genero, Numero, Adjetivo, Oracion).
adjetivo(masculino, singular,["destino"|S], S).
adjetivo(masculino, singular,["instermedio"|S], S).

%%%%% VERBOS %%%%%
%verbo (Tipo, Numero, Verbo, Oracion).
verbo(copulativo, _, ["es"|S], S).
verbo(copulativo, singular, ["estoy"|S], S).

verbo(infinitivo, _, ["ir"|S], S).
verbo(infinitivo, _, ["llegar"|S], S).
verbo(infinitivo, _, ["pasar"|S], S).

verbo(intransitivo, singular, ["viajo"|S], S).
verbo(intransitivo, singular, ["voy"|S], S).
verbo(intransitivo, plural, ["vamos"|S], S).

verbo(reflexivo, singular, ["dirijo"|S], S).
verbo(reflexivo, plural, ["dirigirnos"|S], S).
verbo(reflexivo, singular, ["encuentro"|S], S).
verbo(reflexivo, plural, ["encontramos"|S], S).
verbo(reflexivo, singular, ["ubico"|S], S).

verbo(transitivo, singular, ["quiero"|S], S).
verbo(transitivo, plural, ["queremos"|S], S).

%%%%% PREPOSICIONES %%%%%
preposicion(finalidad, ["a"|S], S).
preposicion(lugar, ["a"|S], S).
preposicion(lugar, ["para"|S], S).
preposicion(lugar, ["en"|S], S).
preposicion(lugar, ["cerca de"|S], S).
preposicion(lugar, ["alrededor de"|S], S).



%%%%%%%% %%%%% %%%%%%%% SINTAGMAS %%%%%%%% %%%%% %%%%%%%%

%%%%%% SINTAGMA NOMINAL %%%%%%
% Sintagma nominal con pronombre personal solamente. (Ej: yo, nosotros)
sintagma_nominal(N, S0, S):-
    pronombre(posesivo, N, S0,S1),
    sustantivo(_, N, S1,S).

% Sintagma nominal con pronombre personal y pronombre reflexivo. (Ej: yo me, nosotros nos)
sintagma_nominal(N, S0, S):-
    pronombre(posesivo, N, S0,S1),
    sustantivo(G, N, S1,S2), 
    adjetivo(G, N, S2,S), S1\=S2.


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
% Sintagma preposicional con una preposicion y un lugar (Ej: heredia)
sintagma_preposicional(lugar, S0, S):-
    lugar(S0,S).
% Sintagma preposicional con una preposicion y un lugar (Ej: a heredia)
sintagma_preposicional(lugar, S0, S):-
	preposicion(lugar, S0, S1),
	lugar(S1, S).

% Sintagma preposicional con un articulo y un lugar (Ej: al supermercado)
sintagma_preposicional(N, S0, S):-
    articulo(_,N,S0,S1),
	lugar(S1, S).


%%%%%%%% %%%%% %%%%%%%% ORACIÓN %%%%%%%% %%%%% %%%%%%%%

% Oración (Ej: si)
oracion(S0,S):-
    afirmativo(S0,S).

% Oración (Ej: no.)
oracion(S0,S):-
    negativo(S0,S).

% Oración (Ej: En Tamarindo.)
oracion(S0,S):-
    sintagma_preposicional(lugar,S0,S).

% Oración (Ej: Si, a Tamarindo.)
oracion(S0,S):-
    afirmativo(S0,S1),
    sintagma_preposicional(lugar,S1,S).

% Oración (Ej: Mi lugar es Tamarindo.)
oracion(S0,S):-
    sintagma_nominal(_,S0,S1),
    verbo(copulativo,_,S1,S2),
    sintagma_preposicional(lugar,S2,S).

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

%%%%%%%% %%%%% %%%%%%%% BACKGROUND %%%%%%%% %%%%% %%%%%%%%

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

%%%%%% BUSQUEDA EN LA BASE %%%%%%

%Funcion miembro.
miembro(X, [X|_]):- !.
miembro(X, [_| R]):- miembro(X,R).

%Funcion invertir(lista, lista invertida).
invertir(X,Y):- invertir(X,Y,[]). 
invertir([],Z,Z).
invertir([Head|Tail],Z, Collector):- invertir(Tail,Z,[Head|Collector]).

% Revisa si es oración según lo estructurado en el BNF
es_oracion(S):-
	oracion(S, []), !.

% Revisa si el imput recibido equivale a un hecho oracion.
es_oracion_input(Input):-
    parseToList(Input,S),
    es_oracion(S).

% Revisa si es una negacion
es_negativo(N):-
	negativo(N), !.

% Revisa si es una afirmacion.
es_afirmativo(Y):-
	afirmativo(Y), !.

% Revisa si es un lugar
es_lugar(L, Lugar):-
	miembro(Lugar, L),
	lugar(L, []), !.


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

% Busca si el lugar existe.
% Input: lista con cada palabra de la oración ingresada por el usuario.
% Output: el lugar encontrado.
destino(X, Lugar):-
	buscar_lugar(X, Lugar).
% Buscar lugar en TODA la oración.
% Input: lista con todas las palabras de la oración ingresada por el usuario.
% Output: true en caso de encontrarlo.
buscar_lugar([X|_], Lugar):-
	nth0(0, L, X, []),
	es_lugar(L, Lugar), !.

buscar_lugar([_|Y], Lugar):-
	buscar_lugar(Y, Lugar).

%%%%%%%% %%%%% %%%%%%%% MENU %%%%%%%% %%%%% %%%%%%%%


%%%%% Funciones Auxiliares %%%%%


% consultar_lugar_de_destino(Lugar):-

%     writeln('Wazelog - ¿Cual es su destino?'),
%     readln(Input),
%     display(Input),
%     (verificar_oracion(Input) -> !;
%     writeln('Disculpe, no entendí.'),
%     consultar_lugar_de_destino(Lugar)),

%     (destino(Input, Lugar) -> !;
%         writeln('Lo sentimos, ese lugar se encuentra fuera de covertura.'),
%         consultar_lugar_de_destino(Lugar)).

% consultar_lugar_de_intermedio(Lugar):-

%     writeln('Wazelog - ¿Tiene algun destino intermedio?'),
%     readln(Input),

%     (verificar_oracion(Input) -> !;
%     writeln('Disculpe, no entendí.'),
%     consultar_lugar_de_intermedio(Lugar))

%     ->
%         (respuesta_negativa(Input),!
%     ;
%         respuesta_afirmativa(Input),
%         (destino(Input, Lugar) -> !;
%             writeln('Aun no conocemos ese lugar.'),
%             consultar_lugar_de_intermedio(Lugar)),
%             nl,!
%     ;
%         respuesta_afirmativa(Input),
%         consultar_ubicacion_del_lugar_intermedio(Lugar)).
    
% consultar_ubicacion_del_lugar_intermedio(Lugar):-
%     writeln('Wazelog - ¿Donde se encuentra el lugar de intermedio?'),
%     readln(Input),
%     (destino(Input, Lugar) -> !;
%         writeln('Lo sentimos, no conocemos ese lugar.'),
%         consultar_ubicacion_del_lugar_intermedio(Lugar)).





% main():-

        % nl,
        % writeln('Welcome.'),
        % repeat, 
        % writeln('Print this message again? (yes/no)'),
        % read(Ans),nl,
        % (Ans == yes -> 
        %   writeln('You selected yes.'), 
        %   fail % backtrack to repeat
        % ; writeln('You selected no.'),
        %   ! % cut, we won't backtrack to repeat anymore
        % ).

    % nl,repeat,
    % writeln('Wazelog:\tBienvenido a WazeLog la mejor lógica de llegar a su destino.\n\tPor Favor indíqueme donde se encuentra.'),
    
        % %% Preguntas
        % consultar_lugar_de_inicio(LugarInicio),
        % consultar_lugar_de_destino(LugarDestino),
        % consultar_lugar_de_intermedio(UbicacionIntermedia),
        % nl,
        % display('Salida: '), display(LugarInicio),
        % nl,
        % display('Llegada: '), display(LugarDestino),
        % nl,
        % display('Parada en:'), display(UbicacionIntermedia),
    
        % display('Fin')
        % -> wazelog().
    

verificar_entrada(Input):-
    verificar_oracion(Input),!.

verificar_entrada(Input):-
    writeln('Wazelog - Lo siento, no entendí'),
    esperar_nueva_entrada(Input).

esperar_nueva_entrada(Input):-

% Revisa si el input recibido equivale a un hecho oracion.
verificar_oracion(S):-
    readln(Ans),
    es_oracion_input(Ans).


verificar_destino(Ans, Lugar):-
    (\+destino(Ans, Lugar) -> 
        writeln('Lo sentimos, ese lugar se encuentra fuera de covertura.'),
        fail  % backtrack to repeat
        ; Ans, Lugar, ! % cut, we won't backtrack to repeat anymore
    ).

%%%%% WazeLog %%%%%
% consultar_lugar_de_inicio(Lugar):-
%     repeat,
%     nl,
%     writeln('Por favor indiqueme donde se encuentra.'),
%     verificar_oracion(S),
%     verificar_destino()
%     (\+destino(S, Lugar) -> 
%         writeln('Lo sentimos, ese lugar se encuentra fuera de covertura.'),
%         fail  % backtrack to repeat
%         ; display(Lugar), ! % cut, we won't backtrack to repeat anymore
%     ).