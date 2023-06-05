% Importaci�n de archivos pl de la base de datos de Restaurantec y el BNF

:-consult('DataBase').
:-consult('BNF').
:-style_check(-singleton).

%						       %
% Definici�n de hechos de apoyo, a modo de operaciones %
%

% Convierte la entrada recibida en una lista
% E: Input del usuario
% S: Lista
inputToList(L):-
	read_line_to_codes(user_input,Cs),
	atom_codes(A,Cs),
	atomic_list_concat(L,' ',A).

% Covierte una lista a un string
% E: Lista y string
% S: String

listToString(List, String):-
	atomic_list_concat(List, ' ', String).

% Se convierta un string a una lista
% E: String y lista
% S: Lista

stringToListOfAtoms(X,L):-
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


% Busca el tipo de comida
% E: Lista y resultado
% S: Nombre del menu

tipoDeComida([],X):- nl, writeln('Hey, el tipo de comida que pides no se encuentra disponible'),
			  writeln('Int�ntalo de nuevo, tal vez pueda ayudarte con algo m�s'),nl,
			  inputToList(Oracion),
			  tipoDeComida(Oracion,X).

tipoDeComida([H|_], X):- listaTipoDeComida(L),
			      miembro(H,L),
			      X = H, !.

tipoDeComida([H|T], X):- listaTipoDeComida(L),
			      \+miembro(H,L),
			      tipoDeComida(T,X).

% Busca la lista de comidas disponibles
% E: Resultado
% S: Lista de tipos de comidas

listaTipoDeComida(L) :- findall(X, (restaurante([_,X,_,_,_])) , L).


% Busca el platillo
% E: Lista y resultado
% S: Nombre del platillo

platillo([],X):- nl, writeln('Hmm, parece que la comida que quieres no est� disponible'),
		      writeln('�Qu� m�s te apetece?'),nl,
		      inputToList(Oracion),
		      platillo(Oracion,X).

platillo([H|_], X):- listaPlatillo(L),
			  miembro(H,L),
			  X = H, !.

platillo([H|T], X):- listaPlatillo(L),
			  \+miembro(H,L),
			  platillo(T,X).
% Busca la lista de platillos disponibles
% E: Resultado
% S: Lista de platillos

listaPlatillo(L) :- findall(X, (menu([X|_])), L).


% Busca el sabor pedido de comida
% E: Lista y resultado
% S: Sabor de la comida

saborComidaAux([H|_], X):- listaSaborComida(L),
				  flatten(L,Y),
				  X = Y.

saborComida([],X):- nl, writeln('Parece ser que no tenemos ese sabor que buscas'),
			       writeln('Pero tenemos otros incluso mejores, prueba otro'),nl,
			       inputToList(Oracion),
			       saborComida(Oracion,X).

saborComida([H|_], X):- saborComidaAux(C, Y),
			       miembro(H,Y),
			       X = H, !.
saborComida([H|T], X):- saborComidaAux(C, Y),
			       \+miembro(H,Y),
			       saborComida(T,X).

% Busca la lista de sabores posibles para una comida
% E: Resultado
% S: Lista de sabores

listaSaborComida(L) :- findall(X, (menu([_,_,X])), L).


% Se encarga de buscar el refresco
% E: Lista y el resultado
% S: Sabor de la bebida

bebida([],X):- nl, writeln('El sabor de la bebida que buscas parece que no est� disponible'),
		      writeln('�Que otra bebida te apetece?'),nl,
		      inputToList(Oracion),
		      bebida(Oracion,X).

bebida([H|_], X):- listaBebidas(L),
			  miembro(H,L),
			  X = H, !.

bebida([H|T], X):- listaBebidas(L),
			  \+miembro(H,L),
			  bebida(T,X).

% Se busca la lista de todas las bebidas
% E: Resultado
% S:  Lista de bebidas

listaBebidas(L) :- findall(X, (bebida([X|_])) , L).


% Se busca el lugar ingresado
% E: Lista y resultadd
% S: nombre del lugar

lugarAux([H|_], X):- listaLugares(L),
			    flatten(L,Y),
			    X = Y.

lugar([],X):- nl, writeln('El lugar que procuras parece no estar disponible en nuestra aplicaci�n'),
		     writeln('�Otro lugar?'),nl,
		     inputToList(Oracion),
		     lugar(Oracion,X).

lugar([H|_], X):- lugarAux(C, Y),
			 miembro(H,Y),
			 X = H, !.

lugar([H|T], X):- lugarAux(C, Y),
			 \+miembro(H,Y),
			 lugar(T,X).

% Busca la lista de lugares
% E: Resultado
% S: Lista de lugares disponibles
listaLugares(L) :- findall(X, (restaurante([_,_,X,_,_])) , L).


% Se busca la cantidad de personas para un cupo.
% E: Lista y Resultado
% S: Cantidad de personas

cantidad([],X):-  nl, writeln('Parece ser que no hay el espacio necesario para ti y tus acompa�antes'),
			 writeln('�Puedo ayudarte con otra cantidad?'),nl,
			 inputToList(Oracion),
			 cantidad(Oracion,X).
cantidad([H|_], X):- listaCantidad(L),
			    miembro(H,L) ,
			    atom_number(H, Y),
			    X = Y, !.
cantidad([H|T], X):- listaCantidad(L),
			    \+miembro(H,L),
			    cantidad(T,X).


% Lista de cupos disponibles
% E: Resultado
% S: Lista de cantidades de cupos
listaCantidad(Cantidad) :- numlist(1, 40, CantidadTemp),
			   listToString(CantidadTemp, Str),
			   stringToListOfAtoms(Str,Cantidad).

% Petici�n de los inputs del usuario
% E: Nombre del Restaurante, Tipo de comida, Tipo de platillo, Sabor de la Comida, Tipo de Bebida, Lugar Deseado y Cantidad de Personas
% S: Resultado final de busqueda del restaurante

inicializaci�nDeApp(NombreRest, TipoComida, Platillo, SaborComida, TipoBebida, LugarDeseado, CantidadDeseada):-

	% Secci�n dedicada al menu que quiere el usuario.
	nl, writeln('�Qu� tipo de comida te apetece comer el d�a de hoy?'),
	inputToList(Oracion),
	validacion_de_gramatica(Oracion),
    tipoDeComida(Oracion, TipoComidaTemp),
	TipoComida = TipoComidaTemp,

	% Secci�n que busca la comida que se desea
	nl, writeln('�En que platillo est�s pensando en este momento?'),
	inputToList(Oracion3),
	validacion_de_gramatica(Oracion3),
	platillo(Oracion3, ComidaTemp),
	Platillo = ComidaTemp,

	% Secci�n que busca el sabor especifico
	nl, write('�Cu�l tipo de '), write(Platillo), writeln(' desea?'),
	inputToList(Oracion4),
	validacion_de_gramatica(Oracion4),
	saborComida(Oracion4, SaborComidaTemp),
	SaborComida = SaborComidaTemp,

	% Secci�n dedicada que busca la bebida
	nl, writeln('�Qu� bebida le gustar�a para acompa�ar su comida?'),
	inputToList(Oracion5),
	validacion_de_gramatica(Oracion5),
	bebida(Oracion5, BebidaTemp),
	TipoBebida = BebidaTemp,

	% Secci�n dedicada que busca el lugar
	nl, writeln('�En cual provincia le quedar�a mejor para comer?'),
	inputToList(Oracion6),
	validacion_de_gramatica(Oracion6),
	lugar(Oracion6, LugarTemp),
	LugarDeseado = LugarTemp,

	% Secci�n dedicada que busca la cantidad de personas que ir�n al restaurante
	nl, writeln('�Cuantas personas van a asistir al restaurante?'),nl,
	inputToList(Oracion7),
	validacion_de_gramatica(Oracion7),
	cantidad(Oracion7, CantidadTemp),
	CantidadDeseada = CantidadTemp,

	% Se validan los datos y se el restaurante en caso de existir
	buscarRestauranteConDatosIngresados(RestTemp, TipoComida, Platillo, SaborComida, TipoBebida, LugarDeseado, CantidadDeseada).


% Se verifican los inputs del usuario

verificacionDeDatos(NombreRest, NombreIngresado, NombreIngresado2, SaborComida, SaboresDisponibles):-
	miembro(NombreRest, NombreIngresado),
	miembro(NombreRest, NombreIngresado2),
	miembro(SaborComida, SaboresDisponibles).

% Busca el mejor restaurante segun los datos obtenidos del usuario

buscarRestauranteConDatosIngresados(NombreRest, TipoComida, Platillo, SaborComida, TipoBebida, LugarDeseado, CantidadDeseada):-
    restaurante([NombreRest, TipoComida, [LugarDeseado | Direccion], RCapacidad, Obligaciones]),
	CantidadDeseada > 0,
	CantidadDeseada =< RCapacidad,
	menu([Platillo, NombreIngresado, SaboresDisponibles]),
	bebida([TipoBebida, NombreIngresado2]),
	verificacionDeDatos(NombreRest, NombreIngresado, NombreIngresado2, SaborComida, SaboresDisponibles),
	crearRecomendacion(NombreRest, Direccion, Obligaciones),
	buscarNuevamente(), !.

buscarRestauranteConDatosIngresados(NombreRest, TipoComida, Platillo, SaborComida, TipoBebida, LugarDeseado, CantidadDeseada):-
    restaurante([NombreRest, TipoComida, [LugarDeseado | Direccion], RCapacidad, Obligaciones]),
	CantidadDeseada > 0,
	CantidadDeseada > RCapacidad,
	nl, write('La cantidad de personas supera la capacidad total del restaurante: '), write(RCapacidad), nl,
	write('Prueba con otra cantida por favor'), nl, nl,
	inputToList(Oracion),
	validacion_de_gramatica(Oracion),
	cantidad(Oracion, CantidadTemp),
	buscarRestauranteConDatosIngresados(NombreRest, TipoComida, Platillo, SaborComida, TipoBebida, LugarDeseado, CantidadTemp).

buscarRestauranteConDatosIngresados(NombreRest, TipoComida, Platillo, SaborComida, TipoBebida, LugarDeseado, CantidadDeseada):-
	restaurante([NombreRest, TipoComida, [LugarDeseado | Direccion], RCapacidad, Obligaciones]),
	CantidadDeseada > 0,
	CantidadDeseada =< RCapacidad,
	menu([Platillo, NombreIngresado, SaboresDisponibles]),
	bebida([TipoBebida, NombreIngresado2]),
	\+verificacionDeDatos(NombreRest, NombreIngresado, NombreIngresado2, SaborComida, SaboresDisponibles),
	nl, writeln('> Lo intente pero no pude encontrar un restaurante lo suficientemente bueno para t�. Lo siento mucho :( <'), nl,
	buscarNuevamente(), !.
	
buscarRestauranteConDatosIngresados(_, _, _, _, _, _, _):-
    nl, writeln('> Lo intente pero no pude encontrar un restaurante lo suficientemente bueno para t�. Lo siento mucho :( <'), nl,
    buscarNuevamente(), !.

% Se crea la recomendaci�n del restaurante

crearRecomendacion(NombreRest, DireccionTemp, Obligaciones):-
	listToString(DireccionTemp,Direccion),
	writeln('Hmm, dejame ver...'),nl,
	write('> Nuestra sugerencia de restaurante es: '), write(NombreRest), writeln(' <'),
	write('> La direccion es: '), write(Direccion), writeln(' <'),
	write('> Para que te hagas una idea, '), write(Obligaciones), writeln(' <'),
	nl.

% Se le da la opci�n al usuario de volver a buscar otro restaurante

buscarNuevamenteAux(Respuesta):- miembro('si',Respuesta),
								 inicializaci�nDeApp(A,B,C,D,E,F,G).
buscarNuevamenteAux(Respuesta):- \+miembro('si',Respuesta),
								 despedida(), !.
buscarNuevamente():- nl, writeln('> �Quieres alguna otra recomendaci�n? Por favor dime si o no <'), nl,
						inputToList(Respuesta),
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
	inicializaci�nDeApp(A,B,C,D,E,F,G).
