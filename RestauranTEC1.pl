% Hechos definidos para el BNF

%%%%% COMIDAS %%%%%
comidas(["rice and beans"|S], S).
comidas(["casado"|S], S).
comidas(["chifrijo"|S], S).
comidas(["filet"|S], S).
comidas(["camarones"|S], S).
comidas(["ceviche"|S], S).
comidas(["sushi"|S], S).
comidas(["fideos"|S], S).
comidas(["cantones"|S], S).
comidas(["gallo pinto"|S], S).
comidas(["pinto"|S], S).
comidas(["arreglado"|S], S).
comidas(["hamburguesa"|S], S).
comidas(["pollo"|S], S).
comidas(["pizza"|S], S).
comidas(["pasta"|S], S).
comidas(["calzone"|S], S).
comidas(["chilaquiles"|S], S).
comidas(["tacos"|S], S).
comidas(["empanada"|S], S).
comidas(["wrap"|S], S).
comidas(["papas"|S], S).
comidas(["doraditas"|S], S).
comidas(["brownie"|S], S).
comidas(["queque"|S], S).
comidas(["tartaleta"|S], S).
comidas(["budin"|S], S).
comidas(["china"|S], S).
comidas(["francesa"|S], S).

%%%%% LUGARES %%%%%
:- discontiguous lugar/2.
lugar(["tamarindo"|S], S).
lugar(["heredia"|S], S).
lugar(["la sabana"|S], S).
lugar(["pavas"|S], S).
lugar(["coronado"|S], S).
lugar(["santo domingo"|S], S).
lugar(["perez zeledon"|S], S).
lugar(["puntarenas"|S], S).
lugar(["escazu"|S], S).
lugar(["puerto viejo"|S], S).
lugar(["san pedro"|S], S).
lugar(["alajuela"|S], S).
lugar(["cartago"|S], S).
lugar(["san jose"|S], S).
lugar(["tibas"|S], S).
lugar(["calle blancos"|S], S).
lugar(["liberia"|S], S).
lugar(["moravia"|S], S).
lugar(["limon"|S], S).

%%%%% MENÚ %%%%%
:- discontiguous menu/2.
menu(["italiana"|S], S).
menu(["carnes"|S], S).
menu(["mariscos"|S], S).
menu(["tipica"|S], S).
menu(["oriental"|S], S).
menu(["mexicana"|S], S).
menu(["frituras"|S], S).
menu(["rapida"|S], S).
menu(["reposteria"|S], S).

%%%%% DIGITO %%%%%%
digito(["0"|S], S).
digito(["1"|S], S).
digito(["2"|S], S).
digito(["3"|S], S).
digito(["4"|S], S).
digito(["5"|S], S).
digito(["6"|S], S).
digito(["7"|S], S).
digito(["8"|S], S).
digito(["9"|S], S).
digito(["10"|S], S).
digito(["11"|S], S).
digito(["12"|S], S).
digito(["13"|S], S).
digito(["14"|S], S).
digito(["15"|S], S).
digito(["16"|S], S).
digito(["17"|S], S).
digito(["18"|S], S).
digito(["19"|S], S).
digito(["20"|S], S).
digito(["21"|S], S).
digito(["22"|S], S).
digito(["23"|S], S).
digito(["24"|S], S).
digito(["25"|S], S).

%%%%% VERBOS %%%%%

% Verbo de composicion conjugados (queremos, gustaría, haría)
verbo_conjugado(["queremos"|S], S).
verbo_conjugado(["gustaria"|S], S).
verbo_conjugado(["quiero"|S], S).

%%% Verbos importantes relacionados a comer %%%
verbo(comer, ["comer"|S], S).
verbo(comer, ["comerme"|S], S).
verbo(comer, ["degustar"|S], S).
verbo(comer, ["saborear"|S], S).
verbo(beber, ["beber"|S], S).
verbo(beber, ["beberme"|S], S).

%%%% AUX %%%%%
aux(agregar, ["y"|S], S).
aux(agregar, ["con"|S], S).
aux(comida, ["comida"|S], S).
aux(ubicacion, ["en"|S], S).
aux(ubicacion, ["por"|S], S).
aux(ubicacion, ["cerca de"|S], S).
aux(ubicacion, ["como por"|S], S).
aux(ubicacion, ["alrededor de"|S], S).
aux(tiempo, ["hoy"|S], S).

%%%%% DETERMINANTES %%%%%
determinante(singular, ["me"|S], S).
determinante(plural, ["nos"|S], S).
determinante(plural, ["nosotros"|S], S).
determinante(["les"|S], S).

%%%%% ARTICULOS %%%%%
articulo(singular, ["una"|S], S).
articulo(singular, ["un"|S], S).


%%%%%%%%%%% Gramática libre de contexto %%%%%%%%%%%


%%%%% POSIBLES ORACIONES %%%%%

% Oración sencilla donde solo indica comida (Ej: pizza).
oracion(S0,S):-
	comidas(S0,S).

% Oración donde indica dos comidas (Ej: hamburguesa con papas).
oracion(S0,S):-
	comidas(S0, S1),
	aux(agregar, S1, S2),
	comidas(S2, S).

% Oración sencilla donde solo indica  lugar (Ej: heredia).
oracion(S0,S):-
	lugar(S0,S).

% Oración sencilla donde solo indica tipo de comida (Ej: rapida).
oracion(S0,S):-
	menu(S0,S).

% Oración sencilla donde solo indica tipo de comida con la palabra comida antes (Ej: comida rapida).
oracion(S0,S):-
	aux(comida, S0, S1),
	menu(S1,S).

% Definicion de oracion solo en lugar (Ej: Alajuela, en heredia)
oracion(S0,S):-
	sintagma_preposicional(S0,S).

% Tipo de oración
oracion(S0,S):-
	sintagma_verbal(S0, S).

% Tipo de oración
oracion(S0,S):-
	sintagma_verbal(S0,S1),
	sintagma_preposicional(S1,S).

% Tipo de oración
oracion(S0,S):-
	sintagma_verbal(S0, S1),
	sintagma_preposicional(S1, S).

% Tipo de oración
oracion(S0,S):-
	verbo_conjugado(S0, S1),
	verbo(comer, S1, S2),
	sintagma_preposicional(S2, S).

% Tipo de oración
oracion(S0,S):-
	verbo_conjugado(S0, S1),
	verbo(comer, S1, S2),
	sintagma_nominal(S2, S).

% Tipo de oración
oracion(S0,S):-
	verbo(comer, S0, S1),
	sintagma_nominal(S1, S).

% Tipo de oración
oracion(S0,S):-
	verbo_conjugado(S0, S1),
	sintagma_nominal(S1, S).

% Tipo de oración
oracion(S0,S):-
	verbo_conjugado(S0, S1),
	verbo(comer, S1, S2),
	sintagma_nominal(S2, S3),
	sintagma_preposicional(S3, S).

% Tipo de oración
oracion(S0, S):-
	aux(tiempo, S0, S1),
	verbo_conjugado(S1, S2),
	verbo(comer, S2, S3),
	comidas(S3, S).

% Tipo de oración
oracion(S0, S):-
	aux(tiempo, S0, S1),
	verbo_conjugado(S1, S2),
	comidas(S2, S).

% Tipo de oración
oracion(S0, S):-
	verbo_conjugado(S0, S1),
	comidas(S1, S2),
	aux(tiempo, S2, S).

% Tipo de oración
oracion(S0, S):-
	aux(tiempo, S0, S1),
	verbo_conjugado(S1, S2),
	verbo(comer, S2, S3),
	comidas(S3, S4),
	sintagma_preposicional(S4, S).

% Tipo de oración
oracion(S0, S):-
	aux(tiempo, S0, S1),
	verbo_conjugado(S1, S2),
	verbo(comer, S2, S3),
	sintagma_nominal(S3, S4),
	sintagma_preposicional(S4, S).

% Tipo de oración
oracion(S0, S):-
	verbo_conjugado(S0, S1),
	verbo(comer, S1, S2),
	sintagma_nominal(S2, S3),
	sintagma_preposicional(S3, S4),
	aux(tiempo, S4, S).


%%%%%% SINTAGMAS %%%%%%

% Definicion de sintagma nominal (artículo y sujeto)
sintagma_nominal(S0,S):-
	articulo(singular, S0, S1),
	comidas(S1,S).

% Verbo y comida (Ej: comer pizza)
sintagma_verbal(S0,S):-
	verbo(comer, S0, S1),
	comidas(S1, S).

% Verbo conjugado y una comida (Ej: queremos pizza)
sintagma_verbal(S0,S):-
	verbo_conjugado(S0, S1),
	comidas(S1, S).

% Verbo conjugado y comida (Ej: queremos comer pizza)
sintagma_verbal(S0, S):-
	verbo_conjugado(S0, S1),
	verbo(comer, S1, S2),
	comidas(S2, S).

% Sintagma preposicional de lugar únicamente(Ej: heredia)
sintagma_preposicional(S0, S):-
	lugar(S0, S).

% Sintagma preposicional con una ubicación (Ej: en heredia)
sintagma_preposicional(S0, S):-
	aux(ubicacion, S0, S1),
	lugar(S1, S).

% Sintagma preposicional con una acción de deseo y el lugar (Ej: quiero heredia)
sintagma_preposicional(S0, S):-
	verbo_conjugado(S0, S1),
	lugar(S1, S).

% Sintagma preposicional con una acción de deseo, una preposición y el lugar (Ej: quiero en san pedro)
sintagma_preposicional(S0, S):-
	verbo_conjugado(S0, S1),
	aux(ubicacion, S1, S2),
	lugar(S2, S).

% Sintagma preposicional con un tiempo, acción de deseo, una preposición y el lugar (Ej: hoy quiero en san pedro)
sintagma_preposicional(S0, S):-
	aux(tiempo, S0, S1),
	verbo_conjugado(S1, S2),
	aux(ubicacion, S2, S3),
	lugar(S3, S).


% Revisa si es oración según lo estructurado en el BNF
es_oracion(L):-
	oracion(L, []), !.

% Revisa si es una comida
es_comida(L, Comida):-
	miembro(Comida, L),
	comidas(L, []), !.

% Revisa si es un lugar
es_lugar(L, Lugar):-
	miembro(Lugar, L),
	lugar(L, []), !.

% Revisa el tipo de comida
es_menu(L, Menu):-
	miembro(Menu, L),
	menu(L, []), !.

% Revisa si es un numero
es_digito(L, Digito):-
	miembro(Digito, L),
	digito(L, []), !.


% Buscar comida en TODA la oración
% Entra una lista con cada palabra de la oración ingresada por el usuario
% Retorna un true en caso de encontrarlo
buscar_comida([X|_], Comida):-
	nth0(0, L, X, []),
	es_comida(L, Comida), !.

buscar_comida([_|Y], Comida):-
	buscar_comida(Y, Comida).

% Revisa si en la oración hay algún tipo comida
% Entra una lista con cada palabra de la oración ingresada por el usuario
% Retorna la comida en caso de encontrarla
comida(X, Comida):-
	atomo_a_string(X, Y),
	eliminar_puntuacion(Y, Z),
	buscar_comida(Z, Comida).


% Buscar lugar en TODA la oración
% Entra una lista con cada palabra de la oración ingresada por el usuario
% Retorna un true en caso de encontrarlo
buscar_lugar([X|_], Lugar):-
	nth0(0, L, X, []),
	es_lugar(L, Lugar), !.

buscar_lugar([_|Y], Lugar):-
	buscar_lugar(Y, Lugar).

% Entra una lista con cada palabra de la oración ingresada por el usuario
% Retorna el lugar encontrado
lugar(X, Lugar):-
	atomo_a_string(X, Y),
	eliminar_puntuacion(Y, Z),
	buscar_lugar(Z, Lugar).

% Buscar un tipo de menú en TODA la oración
buscar_menu([X|_], Menu):-
	nth0(0, L, X, []),
	es_menu(L, Menu), !.

buscar_menu([_|Y], Menu):-
	buscar_menu(Y, Menu).

% Entra una lista con cada palabra de la oración ingresada por el usuario
% Retorna el tipo de menú encontrado
menu(X, Menu):-
	atomo_a_string(X, Y),
	eliminar_puntuacion(Y, Z),
	buscar_menu(Z, Menu).

% Busca un número o dígito en TODA la oración
buscar_digito([X|_], Digito):-
	nth0(0, L, X, []),
	es_digito(L, Digito), !.

buscar_digito([_|Y], Digito):-
	buscar_digito(Y, Digito).

% Entra una lista con cada palabra de la oración ingresada por el usuario
% Retorna el digito encontrado
digitos(X, Digito):-
	atomo_a_string(X, Y),
	eliminar_puntuacion(Y, Z),
	buscar_digito(Z, Digito).

% Recibe una lista con átomos 
% Retorna una lista con los mismos átomos pero en forma de string al revés. Ejemplo: [foo, hola] a ["foo", "hola"]
atomo_a_string(L1, L):-  atomo_a_string(L1,[],L).
atomo_a_string([], L, L).
atomo_a_string([X|L1], L2, L3):-
	downcase_atom(X, Y),
	text_to_string(Y, String),
	atomo_a_string(L1, [String|L2], L3).

% Elimina los signos de puntuacion
% Entra una lista con una oración
% Retorna la lista sin signos de puntuación
eliminar_puntuacion(X, S5):-
	delete(X, ",", S1),
	delete(S1, ".", S2),
	delete(S2, "!", S3),
	delete(S3, ";", S4),
	delete(S4, "?", S5).

/** Restaurantes */

restaurante('Bella Italia','Italiana',["pizza","pasta","calzone"],'300 mts Sur de la entrada principal de la UCR',"San Pedro", 10, 'Solo se permiten burbujas y durante la espera se debe utilizar mascarilla').
restaurante('Italianisimo','Italiana',["pasta","calzone", "ensalada"] ,'50 mts Sur de la entrada del BCR','Alajuela', 25, 'Utilizar mascarilla').
restaurante('McBurguesa','Rapida',["hamburguesa","papas","sandwich"],'100 mts Norte de la entrada principal del TEC' ,'Cartago', 20, 'Solo se permiten burbujas').
restaurante('La Casona','Tipica',["pinto","chifrijo","casado"],'300 mts Este del cruce con Heredia','Tibas', 23 , 'Utilizar mascarilla').
restaurante('Trigo Miel','Reposteria', ["queque","empanadas","pañuelo"],'150 mts Oeste del Banco Nacional','San Jose', 25 , 'Lavado de manos y uso de mascarilla').
restaurante('Totopos','Mexicana',["nachos","tacos","empanadas"],'200 mts Sur de los Tribunales','Calle Blancos', 10 , 'Solo se permiten burbujas').
restaurante('Frys','Carnes',["churrasco","al pastor","costilla"],'Contiguo al BAC','Liberia', 25 , 'Utilizar mascarilla y solo burbujas permitidas').
restaurante('El cafetal','Reposteria',["budin","queque","cacho"],'350 mts Oeste del Estadio Rosabal Cordero','Tibas', 10 , 'Respetar el distanciamiento y utilizar mascarillas').
restaurante('El Banco de los Mariscos','Mariscos',["filet","camarones","ceviche"],'150 mts Norte del cruce' ,'Moravia', 25 , 'Lavarse las manos antes de entrar y utilizar mascarilla todo el tiempo posible').
restaurante('R&B','Tipica',["empanadas","casado","chifrijo"],'Centro comercial El Verde','Puerto Viejo', 20 , 'Utilizar mascarilla').
restaurante('Casa del Sabor','Oriental',["sushi","fideos","cantones"],'300 mts Este del mall Multiplaza','Escazu', 25 , 'Mantener la distancia y usar mascarilla').
restaurante('La Mariscada','Mariscos',["camarones","ceviche","casado"],'Frente al costado norte del Estadio Municipal','Puntarenas', 30 , 'Solo se permiten burbujas').
restaurante('Casa Cadejo','Tipica',["casado","pinto","arreglado"],'500 mts Norte de la Municipalidad','Perez Zeledon', 10 , 'Utilizar mascarilla y lavarse las manos antes de ingresar').
restaurante('Linda Tierra','Rapida',["hamburguesa","pollo","pizza"],'150 mts Sur de la Basilica','Cartago', 15 , 'Utilizar mascarilla, solo se permiten burbujas').
restaurante('PF Chang','Oriental',["fideos","cantones","sushi"],'Contiguo a la Iglesia', 'Santo Domingo' , 20 , 'Utilizar mascarilla y careta como complemento').
restaurante('Pizzeria El Cruce','Italiana',["pizza","pasta","calzone"],'25 mts Norte del cruce','Coronado', 10 , 'Lavarse las manos antes de ingresar y utilizar mascarilla durante la espera').
restaurante('MTY Flavor','Mexicana',["chilaquiles","tacos","empanadas"],'Centro comercial Aureal','Pavas', 25 , 'Utilizar mascarilla').
restaurante('Soda Maye','Frituras',["papas","doraditas","tacos"],'300 mts Sur del Estadio Nacional','La Sabana', 20 , 'Solo burbujas y utilizar mascarilla').
restaurante('Tres Escobas','Rapida',["hamburguesa","pollo","wrap"],'Contiguo al mercado','Heredia', 25 , 'Lavarse las manos antes y despues de ingresar').
restaurante('Wake n Bake','Reposteria',["brownie","queque","tartaleta"],'100 mts Este del Hotel Best Western','Tamarindo', 10 , 'Utilizar mascarilla y solo burbujas').

/** Miembro de una lista */
miembro(X, [X|_]):- !.
miembro(X, [_| R]):- miembro(X,R).

/** Helper */
plato(R,Plato):- restaurante(R,_,X,_,_,_,_), miembro(Plato,X).
capacidad(R,Cantidad):- restaurante(R,_,_,_,_,X,_), Cantidad =< X.
direccion(R,D):- restaurante(R,_,_,D,_,_,_).
lugarR(R,L):- restaurante(R,_,_,_,X,_,_), string_lower(X, Y), L == Y.
lugarDisplay(R,L):- restaurante(R,_,_,_,L,_,_).
disposicion(R,Disposicion):- restaurante(R,_,_,_,_,_,Disposicion).
menuR(R,T):- restaurante(R,X,_,_,_,_,_), string_lower(X, Y), T == Y.

/** Delimitacion de las recomendaciones*/
recomendacion(R,T,V,L,P):- busqueda(R,T,V,L,P), write('Te recomiendo visitar '), write(R), write(', que se ubica '),
                                direccion(R,D), write(D), write(' en '), lugarDisplay(R,X), write(X), write(', y que te ofrece '), write(P),
                                write(' y es '),writeln(T),
                                write('Las disposiciones del lugar son: '), disposicion(R,Disposicion), write(Disposicion), !.
recomendacion(R,T,V,L,P):- busqueda(R,V,L,P), write('Te recomiendo visitar '), write(R), write(', que se ubica '),
                                direccion(R,D), write(D), write(' en '), lugarDisplay(R,X), write(X), write(', que te ofrece '), write(P),
				write(', pero no es comida '),
                                writeln(T),
                                write('Las disposiciones del lugar son: '), disposicion(R,Disposicion), write(Disposicion),!.
recomendacion(R,T,V,L,P):- busqueda(R,T,V,L), write('Te recomiendo visitar '), write(R), write(', que se ubica '),
                                direccion(R,D), write(D), write(' en '), lugarDisplay(R,X), write(X), write(', pero no te ofrece '), write(P), write(' y es comida '),
                                writeln(T),
                                write('Las disposiciones del lugar son: '), disposicion(R,Disposicion), write(Disposicion),!.
recomendacion(R,T,V,L,P):- busqueda(R,T,V,P), write('Te recomiendo visitar '), write(R), write(', que se ubica '),
                                direccion(R,D), write(D), write(' en '), lugarDisplay(R,X), write(X), write(', no se ubica en '),write(L),
                                write(', pero te ofrece '), write(P), write(' y es comida '),
                                writeln(T),
                                write('Las disposiciones del lugar son: '), disposicion(R,Disposicion), write(Disposicion),!.
recomendacion(R,T,V,L,P):- busqueda(R,V,L) ,write('Te recomiendo visitar '), write(R), write(', que se ubica '),
                                direccion(R,D), write(D), write(' en '), lugarDisplay(R,X), write(X), write(', pero no te ofrece '),
				write(P), write(' y no es comida '),
                                writeln(T),
                                write('Las disposiciones del lugar son: '), disposicion(R,Disposicion), write(Disposicion), !.
recomendacion(R,T,V,L,P):- busqueda(R,V,P), write('Te recomiendo visitar '), write(R), write(', que se ubica '),
                                direccion(R,D), write(D), write(' en '), lugarDisplay(R,X), write(X), write(', no se ubica en '),write(L),
                                write(', pero te ofrece '), write(P), write(' y no es comida '),
                                writeln(T),
                                write('Las disposiciones del lugar son: '), disposicion(R,Disposicion), write(Disposicion), !.
recomendacion(R,T,V,L,P):- busqueda(R,T,V), write('Te recomiendo visitar '), write(R), write(', que se ubica '),
                                direccion(R,D), write(D), write(' en '), lugarDisplay(R,X), write(X), write(', no se ubica en '),write(L),
                                write(', y tampoco te ofrece '), write(P), write(' pero es comida '),
                                writeln(T),
                                write('Las disposiciones del lugar son: '), disposicion(R,Disposicion), write(Disposicion), !.
recomendacion(R,T,V,L,P):- busqueda(R,V), write('Te recomiendo visitar '), write(R), write(', que se ubica '),
                                direccion(R,D), write(D), write(' en '), lugarDisplay(R,X), write(X), write(', no se ubica en '),write(L),
                                write(', tampoco te ofrece '), write(P), write(', no es comida '),
                                write(T), writeln(' pero puede acoger a tu grupo.'),
                                write('Las disposiciones del lugar son: '), disposicion(R,Disposicion), write(Disposicion), !.


/** Verificacion de las recomendaciones*/
busqueda(R,V):- capacidad(R,V), !.
busqueda(R,T,V):- menuR(R,T), capacidad(R,V), !.
busqueda(R,V,P):- plato(R,P), capacidad(R,V), !.
busqueda(R,V,L):- lugarR(R,L), capacidad(R,V), !.
busqueda(R,T,V,P):- menuR(R,T),plato(R,P), capacidad(R,V), !.
busqueda(R,T,V,L):-  lugarR(R,L), menuR(R,T), capacidad(R,V), !.
busqueda(R,V,L,P):- lugarR(R,L), plato(R,P), capacidad(R,V), !.
busqueda(R,T,V,L,P):- lugarR(R,L), menuR(R,T),  plato(R,P), capacidad(R,V), !.


/** SE */
start() :-
nl,repeat,
/** Preguntas*/
    writeln('Hola, soy RestauranTEC! Estoy para ayudarte a escoger un restaurante. Dime, que especialidad de comida te gustaria?'),
/** Tipo de Comida */
				readln(Tipo_aux),
				menu(Tipo_aux, Tipo),

/** Platillo*/
                                writeln('Perfecto, mas o menos que te gustaria comer de esa especialidad?'),
                                readln(Platillo_aux),
				comida(Platillo_aux, Platillo),

/** Visitantes*/
				writeln('Entendido. Y cuantas personas van con vos? Indicame el numero'),
				readln(Visitantes_aux),
				digitos(Visitantes_aux, Burbuja), 
				number_codes(Visitantes, Burbuja),
/** Lugar*/
				writeln('Super, en que o cerca de cual lugar te gustaria comer?'),
				readln(Lugar_aux), 
				lugar(Lugar_aux, Lugar) ->
/** Realiza la recomendación*/
				recomendacion(_, Tipo, Visitantes, Lugar, Platillo)
				; write("Lo siento, no encontré ese lugar").



			wazelog():-
				nl,repeat,
					/** Preguntas*/
					% consultar_lugar_de_inicio(A),
					% consultar_lugar_de_destino(B),
					% consultar_lugar_de_intermedio(),
					nl,
					% display('Salida: '), display(A),
					% nl,
					% display('Llegada: '), display(B),
					% nl,
					% display('Intermedio? '), display(X),
					% nl,
					% display('Parada en:'), display(C),
				
					display('Fin'),
					%Se llama recursivamente por si el usuario quiere volver a consultar
					wazelog().
				
				
				consultar_lugar_de_inicio(LugarInicio):-
					writeln('Wazelog - Bienvenido a wazelog! \nPor favor indiqueme donde se encuentra.'),
					readln(Input),
					destino(Input, LugarInicio) -> %revisa si esta o no, avisa si no esta y pregunta de nuevo.
						% (display(LugarInicio); 
						% writeln('Lo sentimos, ese lugar se encuentra fuera de covertura.')),
					nl.
				
				consultar_lugar_de_destino(LugarDestino):-
					writeln('Wazelog - ¿Cual es su destino?'),
					readln(Input),
					destino(Input, LugarDestino) -> %revisa si esta o no, avisa si no esta y pregunta de nuevo.
						% (display(LugarDestino); 
						% writeln('Lo sentimos, ese lugar se encuentra fuera de covertura.')),
					nl.
				
				consultar_lugar_de_intermedio():-
					writeln('Wazelog - ¿Tiene algun destino intermedio?'),
					readln(Input),
					(respuesta_afirmativa(Input);
					respuesta_negativa(Input)).