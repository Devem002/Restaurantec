% Importación de archivos pl de la base de Restaurantec y el BNF
:-consult('nombreDeLaBase')
:-consult('nombreDelBNF')
:-style_check(-singleton)

%                                                      %
% Definición de hechos de apoyo, a modo de operaciones %
%                                                      %

% Verifica si una lista se encuentra vacía
% E: Lista que se quiere verificar y el tamaño
% S: Booleano indicando si está vacía
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
% S: Boolean indicando si el elemento está

miembro(X,[X|_]).
miembro(X,[_|T]):-miembro(X,T).


%                 %
% Sistema Experto % 
%                 %


% Busca el tipo de menu
% E: Lista y resultado
% S: Nombre del menu
compareTipoDeMenu([],X):- nl, writeln('Hey, el menu que pides no est'),
						  writeln('Intente de nuevo'),nl,
						  input_to_list(Oracion),
						  compareTipoDeMenu(Oracion,X).
compareTipoDeMenu([H|_], X):- listaTipoDeMenu(L),
							  miembro(H,L),
							  X = H, !.
compareTipoDeMenu([H|T], X):- listaTipoDeMenu(L),
	                          \+miembro(H,L),
	                          compareTipoDeMenu(T,X).