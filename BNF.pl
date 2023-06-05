
%            BNF


:-style_check(-singleton).


% Pronombres masculinos, femeninos y neutros

pronombre_m([el|S],S).
pronombre_m([lo|S],S).
pronombre_m([los|S],S).
pronombre_m([un|S],S).
pronombre_m([unos|S],S).

pronombre_f([la|S],S).
pronombre_f([las|S],S).
pronombre_f([una|S],S).
pronombre_f([unas|S],S).

pronombre_n([nosotros|S],S).
pronombre_n(['Nosotros'|S],S).
pronombre_n([yo|S],S).
pronombre_n(['Yo'|S],S).



% sustantivos

sustantivo([_|S],S).



% verbos

verbo([comer|S], S).
verbo([tomar|S], S).
verbo([beber|S], S).
verbo([quiero|S],S).
verbo([queremos|S],S).
verbo([quiero,comer|S],S).
verbo([quiero,tomar|S],S).
verbo([quiero,beber|S],S).
verbo([queremos,comer|S],S).
verbo([queremos,tomar|S],S).
verbo([queremos,beber|S],S).

verbo([quiero,estar,cerca,de|S],S).
verbo([quiero,algo,cerca,de|S],S).
verbo([quiero,estar,alrededor,de|S],S).
verbo([quiero,algo,alrededor,de|S],S).
verbo([queremos,estar,cerca,de|S],S).
verbo([queremos,algo,cerca,de|S],S).
verbo([queremos,estar,alrededor,de|S],S).
verbo([queremos,algo,alrededor,de|S],S).

verbo([seria|S], S).
verbo([seriamos|S], S).
verbo([somos|S], S).

verbo(['Quiero'|S],S).
verbo(['Queremos'|S],S).
verbo(['Quiero,comer'|S],S).
verbo(['Quiero,tomar'|S],S).
verbo(['Quiero,beber'|S],S).
verbo(['Queremos,comer'|S],S).
verbo(['Queremos,tomar'|S],S).
verbo(['Queremos,beber'|S],S).

verbo(['Quiero,estar,cerca,de'|S],S).
verbo(['Quiero,algo,cerca,de'|S],S).
verbo(['Quiero,estar,alrededor,de'|S],S).
verbo(['Quiero,algo,alrededor,de'|S],S).
verbo(['Queremos,estar,cerca,de'|S],S).
verbo(['Queremos,algo,cerca,de'|S],S).
verbo(['Queremos,estar,alrededor,de'|S],S).
verbo(['Queremos,algo,alrededor,de'|S],S).

verbo(['Seria'|S], S).
verbo(['Seriamos'|S], S).
verbo(['Somos'|S], S).



% validacion de oraciones
% E: lista de palabras y lista vacia
% S: verificacion si la oracion es correcta


oracion(A,B):-
    sujeto(A,C).



% recibe la lista de palabras, elimina el primer sujeto y devuelve el
% resto
% E: lista de palabras
% S: lista de palabras sin el primer sujeto

sujeto(A,B):-
    pronombre_m(A,C),
    predicado(C,Z),
	sustantivo(Z,B).
sujeto(A,B):-
    pronombre_f(A,C),
    predicado(C,Z),
	sustantivo(Z,B).
sujeto(A,B):-
    pronombre_n(A,C),
    predicado(C,Z),
	sustantivo(Z,B).
sujeto(A,B):-
    pronombre_n(A,C),
    predicado(C,Z),
    pronombre_m(Z,Y),
	sustantivo(Y,B).
sujeto(A,B):-
    pronombre_n(A,C),
    predicado(C,Z),
    pronombre_f(Z,Y),
	sustantivo(Y,B).
sujeto(A,B):-
    pronombre_n(A,C),
    predicado(C,Z),
	sustantivo(Z,B).
sujeto(A,B):-
	predicado(A,C),
    sustantivo(C,B).
sujeto(A,B):-
    predicado(A,B).


% recibe la lista de palabras, elimina el primer predicado y devuelve el
% resto
% E: lista de palabras
% S: lista de palabras sin el primer predicado


predicado(A,B):-
	verbo(A,B).





% valida si la oracion digitada es correcta
% E: Oracion digitada por el usuario
% S: Verificacion gramatical



validacion_de_gramatica(Oracion):-
    oracion(Oracion,[]),
	!.

validacion_de_gramatica(Oracion):-
	nl, writeln('Oracion gramaticalmente incorrecta'),
	writeln('Escriba de nuevo su oracion'),nl,
	input_to_list(Oracion2),
	validacion_de_gramatica(Oracion2).

