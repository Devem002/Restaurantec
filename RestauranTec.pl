% Importaci�n de archivos pl de la base de datos de Restaurantec y el BNF

:-consult('DataBase').
:-consult('BNF').
:-style_check(-singleton).

%						       %
% Definici�n de hechos de apoyo, a modo de operaciones %
%						       %

% Verifica si una lista se encuentra vac�a
% E: Lista que se quiere verificar y el tama�o
% S: Booleano indicando si est� vac�a
lista_vacia(List, Empty) :-
    length(List, Len),
    (   Len =< 1
    ->  Empty = true
    ;   Empty = false
    ).

% Convierte la entrada recibida en una lista
% E: Input del usuario
% S: Lista
input_to_list(L):-
	read_line_to_codes(user_input,Cs),
	atom_codes(A,Cs),
	atomic_list_concat(L,' ',A).

% Convierte la entrada recibida a string
% E: Input del usuario
% S: String
input_to_string(A):-
	read_line_to_codes(user_input,Cs),
	atom_codes(A,Cs).

% Covierte una lista a un string
% E: Lista y string
% S: String

list_to_string(List, String):-
	atomic_list_concat(List, ' ', String).

% Se convierta un string a una lista
% E: String y lista
% S: Lista

string_to_list_of_atoms(X,L):-
	atom_codes(X,A),
	atomic_list_concat(L,' ',X).

% Verifica que exista el elemento en la lista
% E: Elemento y lista
% S: Boolean indicando si el elemento est�

miembro(X,[X|_]).
miembro(X,[_|T]):-miembro(X,T).


%                 %
% Sistema Experto %
%                 %


% Busca el tipo de menu
% E: Lista y resultado
% S: Nombre del menu

compareTipoDeMenu([],X):- nl, writeln('Hey, el menu que pides no se encuentra disponible'),
			  writeln('Intenta de nuevo, tal vez pueda ayudarte con algo m�s'),nl,
			  input_to_list(Oracion),
			  compareTipoDeMenu(Oracion,X).

compareTipoDeMenu([H|_], X):- listaTipoDeMenu(L),
			      miembro(H,L),
			      X = H, !.

compareTipoDeMenu([H|T], X):- listaTipoDeMenu(L),
			      \+miembro(H,L),
			      compareTipoDeMenu(T,X).

% Busca la comida
% E: Lista y resultado
% S: Nombre de la comida

compareComida([],X):- nl, writeln('Hmm, parece que la comida que quieres no est� disponible'),
		      writeln('�Qu� m�s te apetece?'),nl,
		      input_to_list(Oracion),
		      compareComida(Oracion,X).

compareComida([H|_], X):- listaComidas(L),
			  miembro(H,L),
			  X = H, !.

compareComida([H|T], X):- listaComidas(L),
			  \+miembro(H,L),
			  compareComida(T,X).

% Busca el sabor pedido de comida
% E: Lista y resultado
% S: Sabor de la comida

compareSaborComidaAux([H|_], X):- listaSaborComida(L),
				  flatten(L,Y),
				  X = Y.

compareSaborComida([],X):- nl, writeln('Parece ser que no tenemos ese sabor que buscas'),
			       writeln('Pero tenemos otros incluso mejores, prueba otro'),nl,
			       input_to_list(Oracion),
			       compareSaborComida(Oracion,X).

compareSaborComida([H|_], X):- compareSaborComidaAux(C, Y),
			       miembro(H,Y),
			       X = H, !.
compareSaborComida([H|T], X):- compareSaborComidaAux(C, Y),
			       \+miembro(H,Y),
			       compareSaborComida(T,X).

% Se encarga de buscar el refresco
% E: Lista y el resultado
% S: Sabor de la bebida

compareBebida([],X):- nl, writeln('El sabor de la bebida que buscas parece que no est� disponible'),
		      writeln('�Que otra bebida te apetece?'),nl,
		      input_to_list(Oracion),
		      compareBebida(Oracion,X).

compareBebida([H|_], X):- listaBebidas(L),
			  miembro(H,L),
			  X = H, !.

compareBebida([H|T], X):- listaBebidas(L),
			  \+miembro(H,L),
			  compareBebida(T,X).

% Se busca el lugar ingresado
% E: Lista y resultadd
% S: nombre del lugar

compareLugarAux([H|_], X):- listaLugar(L),
			    flatten(L,Y),
			    X = Y.

compareLugar([],X):- nl, writeln('El lugar que procuras parece no estar disponible'),
		     writeln('�Otro lugar?'),nl,
		     input_to_list(Oracion),
		     compareLugar(Oracion,X).

compareLugar([H|_], X):- compareLugarAux(C, Y),
			 miembro(H,Y),
			 X = H, !.

compareLugar([H|T], X):- compareLugarAux(C, Y),
			 \+miembro(H,Y),
			 compareLugar(T,X).

% Se busca la cantidad de personas para un cupo.
% E: Lista y Resultado
% S: Cantidad de personas

compareCantidad([],X):-  nl, writeln('Parece ser que no hay el espacio necesario para ti y tus acompa�antes'),
			 writeln('�Puedo ayudarte con otra cantidad?'),nl,
			 input_to_list(Oracion),
			 compareCantidad(Oracion,X).
compareCantidad([H|_], X):- listaCantidad(L),
			    miembro(H,L) ,
			    atom_number(H, Y),
			    X = Y, !.
compareCantidad([H|T], X):- listaCantidad(L),
			    \+miembro(H,L),
			    compareCantidad(T,X).

% Busca la lista completa de restaurantes
% E: Resultado
% S: Lista de restaurantes

listaRestaurantes(L) :- findall(X, (restaurante([X|_])), L).

% Busca la lista de comidas disponibles
% E: Resultado
% S: Lista de comidas

listaComidas(L) :- findall(X, (menu([X|_])), L).

% Busca la lista de sabores posibles para una comida
% E: Resultado
% S: Lista de sabores

listaSaborComida(L) :- findall(X, (menu([_,_,X])), L).

% Se busca la lista de todas las bebidas
% E: Resultado
% S:  Lista de bebidas

listaBebidas(L) :- findall(X, (bebida([X|_])) , L).

% Busca la lista de lugares
% E: Resultado
% S: Lista de lugares disponibles
listaLugar(L) :- findall(X, (restaurante([_,_,X,_,_])) , L).

% Lista de cupos disponibles
% E: Resultado
% S: Lista de cantidades de cupos
listaCantidad(Cantidad) :- numlist(1, 40, CantidadTemp),
			   list_to_string(CantidadTemp, Str),
			   string_to_list_of_atoms(Str,Cantidad).

% Petici�n de los inputs del usuario
% E: Nombre del Restaurante, Tipo del Menu, Tipo de Comida, Sabor de la Comida, Tipo de Bebida, Lugar Deseado y Cantidad de Personas
% S: Resultado final de busqueda del restaurante

pedirDatos(NombreRest, TipoMenu, TipoComida, SaborComida, TipoBebida, LugarDeseado, CantidadDeseada):-

	% Secci�n dedicada al menu que quiere el usuario.
	nl, writeln('�Qu� menu te apetece comer el d�a de hoy?'),
	input_to_list(Oracion),
	validacion_gramatical(Oracion),
    compareTipoDeMenu(Oracion, TipoMenuTemp),
	TipoMenu = TipoMenuTemp,

	% Secci�n que busca la comida que se desea
	nl, write('�En que comida est�s pensando en este momento?'),
	input_to_list(Oracion3),
	validacion_gramatical(Oracion3),
	compareComida(Oracion3, ComidaTemp),
	TipoComida = ComidaTemp,

	% Secci�n que busca el sabor especifico
	nl, write('�Cu�l tipo de '), write(TipoComida), write(' desea?'), nl,
	input_to_list(Oracion4),
	validacion_gramatical(Oracion4),
	compareSaborComida(Oracion4, SaborComidaTemp),
	SaborComida = SaborComidaTemp,

	% Secci�n dedicada que busca la bebida
	nl, writeln('�Qu� bebida le gustar�a para acompa�ar su comida?'),
	input_to_list(Oracion5),
	validacion_gramatical(Oracion5),
	compareBebida(Oracion5, BebidaTemp),
	TipoBebida = BebidaTemp,

	% Secci�n dedicada que busca el lugar
	nl, write('�En cual provincia le quedar�a mejor para comer?'), nl,
	input_to_list(Oracion6),
	validacion_gramatical(Oracion6),
	compareLugar(Oracion6, LugarTemp),
	LugarDeseado = LugarTemp,

	% Secci�n dedicada que busca la cantidad de personas que ir�n al restaurante
	nl, writeln('�Cuantas personas van a asistir al restaurante?'),
	input_to_list(Oracion7),
	validacion_gramatical(Oracion7),
	compareCantidad(Oracion7, CantidadTemp),
	CantidadDeseada = CantidadTemp,

	% Se validan los datos y se el restaurante en caso de existir
	buscarRestauranteConDatosIngresados(RestTemp, TipoMenu, TipoComida, SaborComida, TipoBebida, LugarDeseado, CantidadDeseada).


% Se verifican los inputs del usuario

verificarDatos(NombreRest, NombreIngresado, NombreIngresado2, SaborComida, SaboresDisponibles):-
	miembro(NombreRest, NombreIngresado),
	miembro(NombreRest, NombreIngresado2),
	miembro(SaborComida, SaboresDisponibles).

% Busca el mejor restaurante segun los datos obtenidos del usuario

buscarRestauranteConDatosIngresados(NombreRest, TipoMenu, TipoComida, SaborComida, TipoBebida, LugarDeseado, CantidadDeseada):-
    restaurante([NombreRest, TipoMenu, [LugarDeseado | Direccion], RCapacidad, Obligaciones]),
	CantidadDeseada > 0,
	CantidadDeseada =< RCapacidad,
	menu([TipoComida, NombreIngresado, SaboresDisponibles]),
	bebida([TipoBebida, NombreIngresado2]),
	verificarDatos(NombreRest, NombreIngresado, NombreIngresado2, SaborComida, SaboresDisponibles),
	crearReferencia(NombreRest, Direccion, Obligaciones),
	buscarNuevamente(), !.

buscarRestauranteConDatosIngresados(NombreRest, TipoMenu, TipoComida, SaborComida, TipoBebida, LugarDeseado, CantidadDeseada):-
    restaurante([NombreRest, TipoMenu, [LugarDeseado | Direccion], RCapacidad, Obligaciones]),
	CantidadDeseada > 0,
	CantidadDeseada > RCapacidad,
	nl, write('La cantidad de personas supera la capacidad total del restaurante: '), write(RCapacidad), nl,
	write('Prueba con otra cantida por favor'), nl, nl,
	input_to_list(Oracion),
	validacion_gramatical(Oracion),
	compareCantidad(Oracion, CantidadTemp),
	buscarRestauranteConDatosIngresados(NombreRest, TipoMenu, TipoComida, SaborComida, TipoBebida, LugarDeseado, CantidadTemp).

buscarRestauranteConDatosIngresados(NombreRest, TipoMenu, TipoComida, SaborComida, TipoBebida, LugarDeseado, CantidadDeseada):-
	restaurante([NombreRest, TipoMenu, [LugarDeseado | Direccion], RCapacidad, Obligaciones]),
	CantidadDeseada > 0,
	CantidadDeseada =< RCapacidad,
	menu([TipoComida, NombreIngresado, SaboresDisponibles]),
	bebida([TipoBebida, NombreIngresado2]),
	\+verificarDatos(NombreRest, NombreIngresado, NombreIngresado2, SaborComida, SaboresDisponibles),
	nl, writeln('> Lo intente pero no pude encontrar un restaurante lo suficientemente bueno para t�. Lo siento mucho :( <'), nl,
	buscarNuevamente(), !.

% Se crea la recomendaci�n del restaurante

crearReferencia(NombreRest, DireccionTemp, Obligaciones):-
	list_to_string(DireccionTemp,Direccion),
	write('> Nuestra sugerencia de restaurante es: '), write(NombreRest), writeln(' <'),
	write('> La direccion es: '), write(Direccion), writeln(' <'),
	write('> Tenga en cuenta que para ingresar al restaurante '), write(Obligaciones), writeln(' <'),
	nl.

% Se le da la opci�n al usuario de volver a buscar otro restaurante

buscarNuevamenteAux(Respuesta):- miembro('si',Respuesta),
								 pedirDatos(A,B,C,D,E,F,G).
buscarNuevamenteAux(Respuesta):- \+miembro('si',Respuesta),
								 despedida(), !.
buscarNuevamente():- nl, writeln('> �Quieres volver a bucar una recomendaci�n? Por favor dime s� o no <'), nl,
						input_to_list(Respuesta),
						buscarNuevamenteAux(Respuesta), !.

% Presentaci�n de RestauranTEC
% Utilizar Fuente Courier New para su visualizaci�n correcta.
encabezado():-
    writeln("                  ,--.    ,--."),
    writeln("                 ((O ))--((O ))"),
    writeln("               ,'_`--'____`--'_`."),
    writeln("              _:  ____________  :_"),
    writeln("             | | ||::::::::::|| | |   �Hola! Bienvenido a RestauranTEC."),
    writeln("             | | ||::::::::::|| | |   Voy a ser tu ayudante por este rato."),
    writeln("             | | ||::::::::::|| | |"),
    writeln("             |_| |/__________\\| |_|"),
    writeln("               |________________|"),
    writeln("            __..-'            `-..__"),
    writeln("         .-| : .----------------. : |-."),
    writeln("       ,\\ || | |\\______________/| | || /."),
    writeln("      /`\\.\\:| | ||  __  __  __  || | |;/,'\\"),
    writeln("     :`-._\\;.| | || '--''--''--' || |,:/_.-':"),
    writeln("     |    :  | | || .----------. || |  :    |"),
    writeln("     |    |  | | ||   Restauran  || |  |    |"),
    writeln("     |    |  | | ||      TEC     || |  |    |"),
    writeln("     :,--.;  | | ||  (_) (_) (_) || |  :,--.;"),
    writeln("     (`-'|)  | | ||______________|| |  (|`-')"),
    writeln("      `--'   | |/______________\\| |    `--'"),
    writeln("             |____________________|"),
    writeln("              `.________________,'"),
    writeln("               (_______)(_______)"),
    writeln("               (_______)(_______)"),
    writeln("               (_______)(_______)"),
    writeln("               (_______)(_______)"),
    writeln("              |        ||        |"),
    writeln("              '--------''--------'"),nl.

% Muestra mensaje de despedida de RestauranTEC

despedida():-
    writeln("                  ,--.    ,--."),
    writeln("                 ((O ))--((O ))"),
    writeln("               ,'_`--'____`--'_`."),
    writeln("              _:  ____________  :_"),
    writeln("             | | ||::::::::::|| | |   �Hasta la proxima!"),
    writeln("             | | ||::::::::::|| | |   Espero haberte sido de ayuda."),
    writeln("             | | ||::::::::::|| | |"),
    writeln("             |_| |/__________\\| |_|"),
    writeln("               |________________|"),
    writeln("            __..-'            `-..__"),
    writeln("         .-| : .----------------. : |-."),
    writeln("       ,\\ || | |\\______________/| | || /."),
    writeln("      /`\\.\\:| | ||  __  __  __  || | |;/,'\\"),
    writeln("     :`-._\\;.| | || '--''--''--' || |,:/_.-':"),
    writeln("     |    :  | | || .----------. || |  :    |"),
    writeln("     |    |  | | ||   Restauran  || |  |    |"),
    writeln("     |    |  | | ||      TEC     || |  |    |"),
    writeln("     :,--.;  | | ||  (_) (_) (_) || |  :,--.;"),
    writeln("     (`-'|)  | | ||______________|| |  (|`-')"),
    writeln("      `--'   | |/______________\\| |    `--'"),
    writeln("             |____________________|"),
    writeln("              `.________________,'"),
    writeln("               (_______)(_______)"),
    writeln("               (_______)(_______)"),
    writeln("               (_______)(_______)"),
    writeln("               (_______)(_______)"),
    writeln("              |        ||        |"),
    writeln("              '--------''--------'"),nl.

% Se encarga de comenzar todo el programa
restauranTEC():-
	encabezado(),
	pedirDatos(A,B,C,D,E,F,G).
