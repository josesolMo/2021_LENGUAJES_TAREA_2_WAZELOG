%%%% IMPORTS %%%%%
:-consult(database).
:-consult(background).
:-consult(gramatica).
:-consult(graph).
 


s():-  
    writeln('\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),
    writeln('\n¡Bienvenido a WazeLog la mejor logica de llegar a su destino!'),
    writeln('Por favor indiqueme donde se encuentra.'),
    ubicacion(Inicio),

    writeln('\nMuy bien, Cual es su destino?'),
    ubicacion(Destino),

    writeln('\nTiene algun destino intermedio? (s / n)'),
    intermedio([], List),

    nl, writeln('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl,
    write('Origen: '),
    writeln(Inicio),
    write('Destino: '),
    writeln(Destino),
    write('Intermedio: '),
    writeln(List),
    nl,

    %Realizar una sola lista.
    append([Inicio],List,L1),
    append(L1,[Destino],L2),

    getPath(L2,P,W,T,T2),
    writeln('➤ Info: '),
    writeln(P),
    writeln(W),
    writeln(T),
    writeln(T2),
    s.


%%%%%% SHORTEST PATH %%%%%%
getPath(List_Places,Path,Weight,Time,Overtime):-
    findminpath_t(List_Places,W,T,P),

    parse_ruta(P, '', Path_string),
    atom_concat('  • Su ruta seria: ',Path_string, Path),

    atom_concat('  • Distancia total del recorrido: ',W, Z),
    atom_concat(Z,' km.', Weight),

    atom_concat('  • Tiempo promedio estimado: ', T, X),
    atom_concat(X, ' min.', Time),

    T2 is T*2,
    atom_concat('  • Tiempo con presa estimado: ', T2, Y),
    atom_concat(Y, ' min.', Overtime).


%%% PARSE RUTA %%%
parse_ruta(List, S, Output):-
    parse_ruta_aux(List,S, Output).

parse_ruta_aux([X], S, Output):-
    atom_concat(S,X,Z),
    atom_concat(Z,'.',Output).

parse_ruta_aux([H|T], S, Output):-
    atom_concat(S,H,X),
    atom_concat(X,', ',Y),
    parse_ruta_aux(T,Y, Output).


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
    atom_concat('\nDonde se encuentra ',Local,A),
    atom_concat(A,'?',B),
    writeln(B),
    validacion_ciudad(Ciudad),

    % write('El local esta en: '),
    % writeln(Ciudad),

    !.

print_info_establecimiento(Establecimiento, Ciudad):-
    atom_concat('\nCual ', Establecimiento, A),
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

% concatena dos listas.
concatenate(List1, List2, Result):-
    append(List1, List2, Result).

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
        (writeln('\nCual?'),
        ubicacion(City),
        append(L1, [City], X),         %agrega a la lista.
        
        % nl,
        % display('X :  '),
        % display(X),nl,
        % display('Places :  '),
        % display(Places),nl,

        writeln('\nAlguna otra parada intermedia? (s / n)'),
        intermedio(X, Places))
    ;   
        concatenate(L1,[], Places)
    ).


:-s().