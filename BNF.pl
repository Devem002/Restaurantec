
%            BNF


:-style_check(-singleton).


% Pronombres masculinos, femeninos y neutros

pronombre_m([el|S],S).
pronombre_m([ellos|S],S).
pronombre_m([lo|S],S).
pronombre_m([los|S],S).
pronombre_m([un|S],S).
pronombre_m([unos|S],S).

pronombre_f([ella|S],S).
pronombre_f([ellas|S],S).
pronombre_f([la|S],S).
pronombre_f([las|S],S).
pronombre_f([una|S],S).
pronombre_f([unas|S],S).

pronombre_n([nosotros|S],S).
pronombre_n(['Nosotros'|S],S).
pronombre_n([nos|S],S).
pronombre_n(['Nos'|S],S).
pronombre_n([yo|S],S).
pronombre_n(['Yo'|S],S).
pronombre_n(['Kevin'|S],S).
pronombre_n(['Fabian'|S],S).
pronombre_n(['Diego'|S],S).
pronombre_n(['Marco'|S],S).
pronombre_n(['Me'|S],S).
pronombre_n([me|S],S).



% sustantivos

sustantivo([_|S],S).



% verbos

verbo([apetece|S], S).
verbo([apetece,comer|S], S).
verbo([apetece,beber|S], S).
verbo([apetece,tomar|S], S).
verbo([comer|S], S).
verbo([tomar|S], S).
verbo([beber|S], S).
verbo([asitiria|S],S).
verbo([iria|S],S).
verbo([voy|S],S).
verbo([asistiremos|S],S).
verbo([iremos|S],S).
verbo([vamos|S],S).
verbo([quiero|S],S).
verbo([quiere|S],S).
verbo([quieren|S],S).
verbo([queremos|S],S).
verbo([quiero,comer|S],S).
verbo([quiero,tomar|S],S).
verbo([quiero,beber|S],S).
verbo([quiere,comer|S],S).
verbo([quiere,tomar|S],S).
verbo([quiere,beber|S],S).
verbo([quieren,comer|S],S).
verbo([quieren,tomar|S],S).
verbo([quieren,beber|S],S).
verbo([queremos,comer|S],S).
verbo([queremos,tomar|S],S).
verbo([queremos,beber|S],S).

verbo([quiero,estar,cerca,de|S],S).
verbo([quiero,algo,cerca,de|S],S).
verbo([quiero,estar,alrededor,de|S],S).
verbo([quiero,algo,alrededor,de|S],S).
verbo([quiere,estar,cerca,de|S],S).
verbo([quiere,algo,cerca,de|S],S).
verbo([quiere,estar,alrededor,de|S],S).
verbo([quiere,algo,alrededor,de|S],S).
verbo([quieren,estar,cerca,de|S],S).
verbo([quieren,algo,cerca,de|S],S).
verbo([quieren,estar,alrededor,de|S],S).
verbo([quieren,algo,alrededor,de|S],S).
verbo([queremos,estar,cerca,de|S],S).
verbo([queremos,algo,cerca,de|S],S).
verbo([queremos,estar,alrededor,de|S],S).
verbo([queremos,algo,alrededor,de|S],S).

verbo([seria|S], S).
verbo([serian|S], S).
verbo([seriamos|S], S).
verbo([somos|S], S).


verbo(['Quiero'|S],S).
verbo(['Quiere'|S],S).
verbo(['Quieren'|S],S).
verbo(['Queremos'|S],S).
verbo(['Quiero comer'|S],S).
verbo(['Quiero tomar'|S],S).
verbo(['Quiero beber'|S],S).
verbo(['Quiere comer'|S],S).
verbo(['Quiere tomar'|S],S).
verbo(['Quiere beber'|S],S).
verbo(['Quieren comer'|S],S).
verbo(['Quieren tomar'|S],S).
verbo(['Quieren beber'|S],S).
verbo(['Queremos comer'|S],S).
verbo(['Queremos tomar'|S],S).
verbo(['Queremos beber'|S],S).

verbo(['Quiero estar cerca de'|S],S).
verbo(['Quiero algo cerca de'|S],S).
verbo(['Quiero estar alrededor de'|S],S).
verbo(['Quiero algo alrededor de'|S],S).
verbo(['Quiere estar cerca de'|S],S).
verbo(['Quiere algo cerca de'|S],S).
verbo(['Quiere estar alrededor de'|S],S).
verbo(['Quiere algo alrededor de'|S],S).
verbo(['Quieren estar cerca de'|S],S).
verbo(['Quieren algo cerca de'|S],S).
verbo(['Quieren estar alrededor de'|S],S).
verbo(['Quieren algo alrededor de'|S],S).
verbo(['Queremos estar cerca de'|S],S).
verbo(['Queremos algo cerca de'|S],S).
verbo(['Queremos estar alrededor de'|S],S).
verbo(['Queremos algo alrededor de'|S],S).

verbo(['Seria'|S], S).
verbo(['Serian'|S], S).
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
	nl, writeln('Hmm, no te termine de entender'),
	writeln('¿Puedes escribirlo otra vez?'),nl,
	inputToList(Oracion2),
	validacion_de_gramatica(Oracion2).

