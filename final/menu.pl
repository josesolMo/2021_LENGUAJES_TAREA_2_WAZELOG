%%%% IMPORTS %%%%%
:-consult(database).
:-consult(background).
:-consult(gramatica).
:-consult(graph).

s:-
    writeln('Bienvenido a WazeLog la mejor lógica de llegar a su destino.
        \nPor favor indíqueme dónde se encuentra.'),
    ubicacion(Inicio),
    writeln('Muy bien, ¿Cuál es su destino?'),
    ubicacion(Final),
    % writeln('Excelente, ¿Tiene algún destino intermedio?').
    display(Inicio),
    display(Final),

    findminpath_t(Inicio,Final,W,T,P),

    atom_concat('W: ', W, C),
    atom_concat('Tiempo estimado: ', T, A),
    atom_concat(A, ' min.', B),
    writeln(P),
    writeln(B),
    writeln(C).



%%%%%% VALIDAR LUGAR %%%%%%
% Revisa si el lugar de entrada existe dentro de la base.
ubicacion(Lugar):-
	validacion(Input),              %validar respuesta.
	encontrar_lugar(Input, Lugar).  %encontrar lugar.

encontrar_lugar(Lugar,X):-
	lugar(Lugar,C),
	es_ciudad(C, X),
	!.

encontrar_lugar(Lugar,X):-
	lugar(Lugar,L),
	es_local(L), 
	print_info_local(L,X),
	!.

encontrar_lugar(Lugar,X):-
	lugar(Lugar,E),
	es_establecimiento(E), 
    display("es establecimiento"),
	print_info_establecimiento(E, X), 
	!.


%%%%%% PRINTS %%%%%
print_info_local(Local,X):-
    atom_concat('¿Dónde se encuentra ',Local,A),
    atom_concat(A,'?',B),
    writeln(B),
    validacion(X),!.

print_info_establecimiento(Establecimiento, Y):-
    atom_concat('¿Cuál ', Establecimiento, A),
    atom_concat(A, ' es?',B),
    writeln(B),
    validacion(X),
    display(X),
    display(Y),
    print_info_local(X,Y),
    !.
    
% print_ruta(Origen,Intermedio,Destino)


