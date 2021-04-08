
%=======================  Restaurantes  =========================%

%restaurante("Nombre del restaurante").
restaurante("Bella Italia").
restaurante("Italianisimo").
restaurante("McBurguesa").


%=======================  Disposiciones  =========================%

%disposiciones("Restaurante", "Disposici  n").
disposiciones("Bella Italia",  "Solo se permiten burbujas y durante la espera se debe utilizar mascarilla").
disposiciones("Italianisimo", "Utilizar mascarilla").
disposiciones("McBurguesa", "Solo se permiten burbujas").


%=======================  Men  s  =========================%

%mennu("Nombre", "Tipo de men  ", "[Comida |[Tipos espec  ficos]]").

mennu("Bella Italia", "italiano", ["Pizza", ["jamon y queso", "suprema", "hawaiana"], "calzone", "espagueti"]).

mennu("Italianisimo","italiano" ,["Pizza", ["pepperoni"], "calzone", "espagueti"] ).

mennu("McBurguesa","Comida Rapida" ,["hamburguesas", "tacos ", "papas"] ).




%=======================  Pizzas =========================%

%pizza("Nombre del restaurante", "[Tipos espec  ficos]").
pizza("Bella Italia", ["jamon y queso", "suprema", "hawaiana"]).

pizza("Italianisimo", ["pepperoni"]).

%pizza("Restaurante 1", "Restaurante 2").
pizza("Italianisimo","Bella Italia").



%=======================  Comida Rapida =========================%

%comidarapida("Nombre del restaurante", "[Tipos espec  ficos]").

comidarapida("McBurguesa",["hamburguesas", "tacos", "papas"]  ).



%=======================  Direcciones =========================%

% direccion("Nombre del restaurante", "Direccion").

direccion("Bella Italia","300m Sur de la entrada principal de la Universidad Nacional" ).

direccion("Italianisimo", "50m Sur de la entrada Banco de Costa Rica" ).

direccion("McBurguesa","100m Norte de la entrada principal del TEC" ).



%=======================  Lugares  =========================%

% lugar("Nombre del restaurante", "Lugar donde se ubica").

lugar("Bella Italia", "Heredia").

lugar("Italianisimo", "Alajuela").

lugar("McBurguesa", "Cartago").


%=======================  Capacidad  =========================%

% capacidad("Nombre del restaurante", Capacidad m  xima).

capacidad("Bella Italia", 10).

capacidad("Italianisimo", 5).

capacidad("McBurguesa", 20).


%=======================  ALIMENTOS  =========================%


%alimento(Oraci  n, Oraci  n preliminar, Palabra(s) clave).

alimento(S0,S,Claves):-
    pronombre(Num,S0,S1),
    sintagma_verbal(Num,Estado,S1,S2),
    sintagma_nominal(_Gen2,Num,Estado,S2,S, Claves), !.
                  %G  nero, n  mero, estado del nombre

alimento(S0,S, Claves):-
    sintagma_verbal(Num,Estado,S0,S1),
    sintagma_nominal(_Gen2,Num,Estado,S1,S, Claves), !.

alimento(S0,S, Claves):-
    sintagma_nominal(_Gen2,Num,Estado,S0,S, Claves), !.

alimento(_S0,_S,_Claves):-
    write("Lo sentimos, no se conoce alg  n restaurante con ese tipo de comida"),
    nl, nl,
    restaurantec().


%======================  UBICACIONES  =======================%

% ubicaci  n(Oraci  n, Oraci  n preliminar, Palabra(s) clave).

ubicacion(S0,S,S1):-
    preposicion(S0,S1),
    lugares(_,S), !.

ubicacion(S0,S,S0):-
    lugares(_,S), !.


%==================  CANTIDAD DE PERSONAS  ==================%

% personas(Oraci  n, Oraci  n preliminar, Palabra(s) clave).

personas(S0,S,S1):-
    preposicion(S0,[S1|_]),
    cantidad(_,S2),
    person(S2,S), !.

personas(S0,S,S1):-
    preposicion(S0,S1),
    cantidad(_,S), !.

personas(S0,S,S0):-
    cantidad(_,S1),
    person(S1,S), !.

personas(S0,S,S0):-
    cantidad(_,S), !.


%=======================  SINTAGMAS =========================%

% sintagma_nominal(G  nero, N  mero, Estado, Oraci  n preliminar, Oraci  n,Palabra clave).
%
sintagma_nominal(Gen,Num,Estado,S0,S, S1):-
    determinante(Gen,Num,S0,S1),
    nombre(Gen,Num,Estado,S1,S2),
    adjetivo(Gen,Num,S2,S).

sintagma_nominal(Gen,Num,Estado,S0,S, S1):-
    nombre(Gen,Num,Estado,S0,S1),
    adjetivo(Gen,Num,S1,S).

sintagma_nominal(Gen,Num,Estado,S0,S, S1):-
    determinante(Gen,Num,S0,S1),
    nombre(Gen,Num,Estado,S1,S).

sintagma_nominal(Gen,Num,Estado,S0,S, S0):-
    nombre(Gen,Num,Estado,S0,S).


% sintagma_verbal(G  nero, N  mero, Estado, Oraci  n preliminar, Oraci  n,Palabra clave).

sintagma_verbal(Num,_Estado,S0,S):-verbo(Num,S0,S).

sintagma_verbal(Num,Estado,S0,S):-
    verbo(Num,S0,S1),
    infinitivo(Estado,S1,S).

%=======================  NOMINAL =========================%

%determinante(G  nero, N  mero, Determinante, Oraci  n).
determinante(femenino, singular, [una|S],S).
determinante(femenino, plural, [unas|S],S).
determinante(masculino, singular, [un|S],S).
determinante(masculino, plural, [unos|S],S).


%pronombre(N  mero, Pronombre, Oraci  n).
pronombre(singular,[yo|S],S).

%adjetivo(G  nero, N  mero, adjetivo, Oraci  n).
adjetivo(femenino,singular,[r  pida|S],S).

%nombre(G  nero, N  mero, Estado,  Nombre, Oraci  n).
nombre(masculino, singular, solido, [italiano|S],S).
nombre(masculino, _, solido, [tacos|S],S).
nombre(masculino, singular, solido, [calzone|S],S).
nombre(masculino, singular, solido, [espagueti|S],S).
nombre(femenino, singular, solido, [pizza|S],S).
nombre(femenino, _, solido, [papas|S],S).
nombre(femenino, _, solido, [hamburguesas|S],S).
nombre(femenino, singular, solido, [comida|S],S).
nombre(femenino, singular, liquido, [bebida|S],S).

%lugares(_, Oraci  n). Admite cualquier lugar
lugares([_|S],S).

%person(personas, Oraci  n).
person([personas|S],S).

%cantidad(_, Oraci  n). Admite cualquier cantidad
cantidad([_|S],S).

%=======================  VERBAL =========================%

% verbo(N  mero, Verbo, Oraci  n).
verbo(singular,[quiero|S],S).
verbo(singular,[deseo|S],S).

%infinitivo(Estado,  Infinitivo, Oraci  n).
infinitivo(solido, [comer|S],S).
infinitivo(liquido, [tomar|S],S).

%preposici  n(Preposici  n Oraci  n).
preposicion([en|S],S).
preposicion([para|S],S).



%=====================  PARSEAR INPUT =======================%


%Caso base
parseInput([],[]).

%Se hace una lista de las palabras ingresadas por el usuario como   tomos
parseInput([C|InputList], [A|Result]):-
    atom_string(A,C),
    parseInput(InputList,Result).

%Entradas: Input es la entrada de texto del usuario
%Salidas: R ser   la entrada en formato analizable
getInput(Input,R):-
    split_string(Input," ",".",R1),
    parseInput(R1,R).



%======================  DELIMITANTES ========================%

% Revisa si un elemento pertenece a una lista
% Sintaxis: miembro(elemento, lista).
% Entradas: elemento, lista.
% Salidas: Booleano indicando si el elemento pertenece a la lista o no

miembro(X, [X|_]).
miembro(X, [_|R]):-miembro(X,R).

% Consideraci  n si el usuario quiere comer pizza, devuelve el
% restaurante a recomendar.
% Sintaxis:
% validaralimento(listaPalabrasClave, restaurante). Se utiliza:
% validaralimento(listaPalabrasClave, X) donde X es el restaurante
% candidato a recomendar al usuario
% Entradas: listaPalabrasClave, restaurante
% Salidas: restaurante a recomendar.

%Validar tipo de men   italiano
validaralimento(Y, X):-
    %Ver si el tipo de comida que escribe coincide con el men   de alg  n restaurante
    Y == [italiano],
    %P ser   el lugar clave como string
    write("  Qu   tipo de comida Italiana quiere comer?"), nl,
    read(T),
    getInput(T,Tparsed),

    % AlimentoClave es la palabra clave de la frase del alimento
    alimento(Tparsed,[],AlimentoClave),
    validaralimento(AlimentoClave,X),!
    .


%Validar otros tipos de comida italiana
validaralimento([Y|_], X):-
    %Ver si el tipo de comida que escribe coincide con el men   de alg  n restaurante
    %P ser   el lugar clave como string
    atom_string(Y, P),
    mennu(X,_,B), miembro(P, B), nl, !
    .


validaralimento(Y, X):-
    Y == [pizza],
    write("  Alg  n tipo de pizza especial?"),nl,
    read(L),

    %Ver si el tipo de comida que escribe coincide con la lista de pizzas de alg  n    %restaurante
    pizza(X,B), miembro(L, B), nl, !
    .

% En caso de que el compa quiera comer comida r  pida, recomienda el
% restaurante para ello y valida si el tipo de comida es v  lido para
% dicho restaurante.
% Sintaxis:
% validaralimento(listaPalabrasClave, restaurante). Se utiliza:
% validaralimento(listaPalabrasClave, X) donde X es el restaurante
% candidato a recomendar al usuario
% Entradas: listaPalabrasClave, restaurante
% Salidas: restaurante a recomendar.
% Restricciones: Se debe dar la Y y dejar al X como variable para que se
% retorne.

validaralimento(Y, X):-
    miembro(rapida, Y),
    write("Qu   tipo de comida r  pida?"),nl,
    read(L),

    %Ver si el tipo de comida que escribe coincide con la lista de comida r  pida
    comidarapida(X,B), miembro(L, B), nl, !
    .

validaralimento(_K,_Y):-
    write("Lo sentimos, no se conoce alg  n restaurante con ese tipo espec  fico de alimentaci  n"), nl, nl,
    restaurantec().


% Valida si el lugar indicado por el usuario coincide con donde se
% encuentra el restaurante a recomendar. Retorna true si coinciden, sino
% false.
% Sintaxis: validarlugar(restaurante, lugar). Se utiliza como:
% validarlugar(rest, lugar), dando los dos argumentos para que retorne
% un booleano.
% Entrada: restaurante, lugar.
% Salida: Booleano indicando si el restaurante y lugar coinciden
% Restricciones: Se deben dar los dos argumentos para que funcione.

validarlugar(K, Y):-
    lugar(K, Y), !.


validarlugar(_K,_Y):-
    write("Lo sentimos, no se conoce alg  n restaurante con sus preferencias en ese lugar"), nl, nl,
    restaurantec().

% Valida si la capacidad solicitada por el usuario es menor o igual a la
% disponible en el restaurante.
% Sintaxis: validarcapacidad(rest, capacidad).
% Se utiliza como: validarcapacidad(rest, capacidad), dando los dos
% argumentos para que retorne un booleano.
% Entrada: restaurante, capacidad -> dada por el usuario
% Salida: Booleano indicando si la capacidad solicitada se satisface o
% no.
% Restricciones: Se deben dar los dos argumentos para que funcione

validarcapacidad(K, Y):-
    capacidad(K, T), T >= Y, !
    .

validarcapacidad(_K,_Y):-
    write("Lo sentimos, no se conoce alg  n restaurante con sus preferencias con esa capacidad"), nl, nl,
    restaurantec().



%======================  PRINCIPAL  ========================%
% Funci  n principal que hace las preguntas al usuario adem  s de ser
% utilizada como interfaz.
% Entradas: Ninguna.
% Salidas: Ninguna.
% Restricciones: Contempladas en las validaciones

restaurantec():-
    write("  Hola!   Qu   desea comer hoy? Escriba su preferencia entre comillas, todo en min  scula, excepto los nombres propios, y con punto final por favor."), nl,

    read(InputAlimento),
    % InputAlimento es el input de usuario de preferencia de alimento
    % InputAlimentoParseado es el input para poder analizarse
    getInput(InputAlimento,InputAlimentoParseado),

    % AlimentoClave es la palabra clave de la frase del alimento
    alimento(InputAlimentoParseado,[],AlimentoClave),

    %K ser   el restaurante candidato
    validaralimento(AlimentoClave, K),

    %
    write("  D  nde se te antoja comer?"), nl,

    read(InputLugar),

    % InputLugar es el input de usuario de preferencia de lugar
    % InputLugarParseado es el input para poder analizarse
    getInput(InputLugar,InputLugarParseado),

    % LugarClave es la palabra clave de la frase del lugar
    ubicacion(InputLugarParseado,[],[LugarClave|_]),

    %P ser   el lugar clave como string
    atom_string(LugarClave, P),

    validarlugar(K, P),
    write("  Para cu  ntas personas ser  a la reservaci  n?"), nl,
    read(InputPersonas),

    %InputPersonas es el input de usuario de cantidad de personas
    % InputPersonasParseado es el input para poder analizarse

    getInput(InputPersonas,InputPersonasParseado),

    % PersonasClave es la palabra clave de la frase de la capacidad
    personas(InputPersonasParseado,[],[PersonasClave|_]),

    % V ser   la cantidad de personas clave como n  mero para ser comparado con la capacidad del restaurante
    atom_number(PersonasClave, V),

    validarcapacidad(K, V),

    %K es el nombre del restaurante y S su direcci  n
    direccion(K,S),

    atom_concat("Nuestra sugerencia es: Restaurante ", K, O1),
    atom_concat(O1, " que se ubica ", O2),
    atom_concat(O2, S, O3),

    %O3 es la frase completa de la recomendaci  n
    write(O3), nl,
    write("Su reservaci  n ha sido tramitada."), nl,
    %D son las disposiciones de los restaurantes
    disposiciones(K, D),
    write(D),nl, nl,

    %Se llama recursivamente por si el usuario quiere volver a consultar
    restaurantec().

