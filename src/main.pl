%%%% IMPORTS %%%%%
:-consult(database).
:-consult(background).
:-consult(gramatica).
:-consult(graph).
 


s():-  writeln('\n¡Bienvenido a WazeLog la mejor lógica de llegar a su destino!'),
    writeln('Por favor indíqueme dónde se encuentra.'),
    ubicacion(Inicio),

    writeln('\nMuy bien, ¿Cuál es su destino?'),
    ubicacion(Destino),

    writeln('\n¿Tiene algún destino intermedio?'),
    intermedio([], List),

    nl, writeln('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl,
    write('Origen: '),
    writeln(Inicio),
    write('Destino: '),
    writeln(Destino),
    write('Intermedio: '),
    writeln(List),
    nl,

    getPath(Inicio,Destino,P,W,T,T2),
    write('Su ruta sería: '),
    writeln(P),
    writeln(W),
    writeln(T),
    writeln(T2).


%%%%%% SHORTEST PATH %%%%%%
getPath(Origin,Destination,Path,Weight,Time,Overtime):-
    findminpath_t(Origin,Destination,W,T,Path),

    % atom_concat('Su ruta sería: ',P, Path),

    atom_concat('Distancia total del recorrido: ',W, Z),
    atom_concat(Z,' km.', Weight),

    atom_concat('Tiempo promedio estimado: ', T, X),
    atom_concat(X, ' min.', Time),

    T2 is T*2,
    atom_concat('Tiempo con presa estimado: ', T2, Y),
    atom_concat(Y, ' min.', Overtime).


%%%%%% VALIDAR LUGAR %%%%%%
% Revisa si el lugar de entrada existe dentro de la base.
ubicacion(Lugar):-
    validacion_entrada(Input),      %validar respuesta.
	encontrar_lugar(Input, Lugar).  %encontrar lugar.
    
%% Encontrar Ciudad.
encontrar_lugar(Lugar,Nombre):-
	search_ciudad(Lugar,Nombre),
	es_ciudad(Nombre),

    % display('¡ES CIUDAD!'),
    % nl,
    % true,

	!.

%% Encontrar Local.
encontrar_lugar(Lugar,Ciudad):-
	search_local(Lugar,Nombre),
	es_local(Nombre),

    % display('¡ES LOCAL!'),
    % nl,
    % display(Nombre),
    % nl,

	print_info_local(Nombre,Ciudad),
	!.

%% Encontrar Establecimiento.
encontrar_lugar(Lugar,Local):-
	search_establecimiento(Lugar,Nombre),
	es_establecimiento(Nombre), 

    % display('¡ES ESTABLECIMIENTO!'),
    % nl,
    % display(Nombre),
    % nl,

	print_info_establecimiento(Nombre, Local), 
	!.

%Hecho si fracasa.
encontrar_lugar(_, Lugar):-
    error_lugar, %error.
    encontrar_lugar_aux(_, Lugar).

%Hecho para preguntar otra vez hasta tener exito.
encontrar_lugar_aux(_, Lugar):-
    validacion_lugar(Input),      %validar respuesta.
    miembro(Input,Parsed),
	encontrar_lugar(Parsed, Lugar).

%%%%%% PRINTS %%%%%
print_info_local(Local,Ciudad):-
    atom_concat('\n¿Dónde se encuentra ',Local,A),
    atom_concat(A,'?',B),
    writeln(B),
    validacion_ciudad(Ciudad),

    % write('El local está en: '),
    % writeln(Ciudad),

    !.

print_info_establecimiento(Establecimiento, Ciudad):-
    atom_concat('\n¿Cuál ', Establecimiento, A),
    atom_concat(A, ' es?',B),
    writeln(B),
    validacion_local(Local),

    % write('El establecimiento se llama: '),
    % writeln(Local),
    
    print_info_local(Local,Ciudad),
    !.
    


%%%%%% CONSULTAR LUGAR INTERMEDIO %%%%%%
%Hechos de si una lista es vacia.
list_empty([], true).
list_empty([_|_], false).

% concatena dos lista.
concatenate(List1, List2, Result):-
    append(List1, List2, Result).

% append un elemento a una lista.
list(L1,X,Z):- append(L1,[X],Z).
% list(Head,[Head|Tail]):-list(Next,Tail).

% si responde no, pues devuelvo el lugar,
respuesta(Input):-respuesta_negativa(Input),fail.

% si responde si.
respuesta(Input):- respuesta_afirmativa(Input),!.

% Funcion if then else, de respuesta.
% Input: Una lista vacia si es la primera vez que se llama, o la lista de los lugares.
% Output: [] si no se tiene lugares intermedios, lista con lugares si se tienen lugares intermedios.
% intermedio([]).
intermedio(L1, Places):-
    validacion_si_o_no(Y),
    parseToList(Y,Z),
    ( respuesta(Z)
    ->  
        (writeln('\n¿Cuál?'),
        ubicacion(City),
        list(L1, City, X),         %agrega a la lista.
        
        % nl,
        % display('X :  '),
        % display(X),nl,
        % display('Places :  '),
        % display(Places),nl,

        writeln('\n¿Alguna otra parada intermedia?'),
        intermedio(X, Places))
    ;   
        concatenate(L1,[], Places)
    ).


:-s().