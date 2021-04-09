%%%% IMPORTS %%%%%
:-consult(database).
:-consult(background).
:-consult(gramatica).
:-consult(graph).

s:-
    writeln('Bienvenido a WazeLog la mejor lógica de llegar a su destino.
        \nPor favor indíqueme dónde se encuentra.'),
    ubicacion(Inicio),

    writeln('\nMuy bien, ¿Cuál es su destino?'),
    ubicacion(Destino),
%%%%%%%%%%%%%
    % intermedio(Intermedio),
%%%%%%%%%%%%%
    nl,
    write('Origen: '),
    writeln(Inicio),
    write('Destino: '),
    writeln(Destino),
    write('Intermedio: '),
    writeln('PENDIENTE'),
    % display(Intermedio), 
    nl,

    getPath(Inicio,Destino,P,W,T,T2),
    write('Su ruta sería: '),
    writeln(P),
    writeln(W),
    writeln(T),
    writeln(T2).

% %%%%%% SHORTEST PATH %%%%%%
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

% %%%%%% CONSULTAR LUGAR INTERMEDIO %%%%%%
% intermedio(Lugar):-
%     writeln('¿Tiene algún destino intermedio?'),
%     respuesta(_, Lugar).

% % mete el lugar a una lista. bueno, deberia xd pero no lo hace.
% aux(Lugar, Lugares):-
%     %meter en una lista
%     Lugar=Lugares,
%     intermedio(Lugares).

% % si responde no, pues devuelvo el lugar,
% respuesta(Input, Lugar):-
%     respuesta_negativa(Input),!.

% % si responde si.
% respuesta(Input, Lugares):-
%     respuesta_afirmativa(Input),
%     writeln('¿Cuál?'),
%     ubicacion(Lugar),
%     aux(Lugar, Lugares),
%     !.


% % si responde con el lugar.
% respuesta(Input, Lugares):-
%     ubicacion(Input),
%     aux(Input, Lugares),
%     !.

% create(L1):-read(Elem),create(Elem,L1).

% create(-1,[]):-!. 
% create(Elem,[Elem|Tail]):-read(Next),create(Next,Tail).

% go:- write('Creating a list'),nl, write('Enter -1 to stop'),nl, create(L), write('List is:'), write(L).



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
encontrar_lugar(Input, Lugar):-
    error_lugar, %error.
    encontrar_lugar_aux(Input, Lugar).

%Hecho para preguntar otra vez hasta tener exito.
encontrar_lugar_aux(Input, Lugar):-
    validacion_entrada(Input),      %validar respuesta.
	encontrar_lugar(Input, Lugar),!. 


%%%%%% PRINTS %%%%%
print_info_local(Local,Ciudad):-
    atom_concat('\n¿Dónde se encuentra ',Local,A),
    atom_concat(A,'?',B),
    writeln(B),
    validacion_ciudad(Ciudad),

    write('El local está en: '),
    writeln(Ciudad),

    !.

print_info_establecimiento(Establecimiento, Ciudad):-
    atom_concat('\n¿Cuál ', Establecimiento, A),
    atom_concat(A, ' es?',B),
    writeln(B),
    validacion_local(Local),

    write('El establecimiento se llama: '),
    writeln(Local),
    
    print_info_local(Local,Ciudad),
    !.
    
% print_ruta(Origen,Intermedio,Destino)


