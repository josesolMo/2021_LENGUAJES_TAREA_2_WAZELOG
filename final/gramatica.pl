:-consult(database).

%%%%% RESPUESTAS %%%%%
% posibles respuestas negativas.
negativo("no").
negativo("ninguno").
negativo(["no"|S], S).
negativo(["ninguno"|S], S).
% posibles respuestas afirmativas.
afirmativo("si").
afirmativo("afirmativo").
afirmativo(["si"|S], S).
afirmativo(["afirmativo"|S], S).

%%%%% PRONOMBRES %%%%%
%pronombre(Tipo, Numero, Pronombre, Oracion).
pronombre(personal, singular,["yo"|S],S).
pronombre(personal, plural,["nosotras"|S],S).
pronombre(personal, plural,["nosotros"|S],S).
pronombre(reflexivo, singular,["me"|S],S).
pronombre(reflexivo, plural,["nos"|S],S).
pronombre(posesivo, singular,["mi"|S],S).
pronombre(posesivo, singular,["nuestro"|S],S).

%%%%% ARTICULOS %%%%%
%pronombre(Genero, Numero, Articulo, Oracion).
articulo(masculino, singular, ["el"|S], S).
articulo(masculino, singular, ["al"|S], S).
articulo(masculino, plural, ["a los"|S], S).
articulo(femenino, singular, ["a la"|S], S).
articulo(femenino, plural, ["a las"|S], S).

%%%%% SUSTANTIVO %%%%%
%pronombre(Genero, Numero, Sustantivo, Oracion).
sustantivo(masculino, singular,["destino"|S], S).
sustantivo(masculino, singular,["lugar"|S], S).

%%%%% ADJETIVO %%%%%
%pronombre(Genero, Numero, Adjetivo, Oracion).
adjetivo(masculino, singular,["destino"|S], S).
adjetivo(masculino, singular,["instermedio"|S], S).

%%%%% VERBOS %%%%%
%verbo (Tipo, Numero, Verbo, Oracion).
verbo(copulativo, _, ["es"|S], S).
verbo(copulativo, singular, ["estoy"|S], S).

verbo(infinitivo, _, ["ir"|S], S).
verbo(infinitivo, _, ["llegar"|S], S).
verbo(infinitivo, _, ["pasar"|S], S).

verbo(intransitivo, singular, ["viajo"|S], S).
verbo(intransitivo, singular, ["voy"|S], S).
verbo(intransitivo, plural, ["vamos"|S], S).

verbo(reflexivo, singular, ["dirijo"|S], S).
verbo(reflexivo, plural, ["dirigirnos"|S], S).
verbo(reflexivo, singular, ["encuentro"|S], S).
verbo(reflexivo, plural, ["encontramos"|S], S).
verbo(reflexivo, singular, ["ubico"|S], S).

verbo(transitivo, singular, ["quiero"|S], S).
verbo(transitivo, plural, ["queremos"|S], S).

%%%%% PREPOSICIONES %%%%%
preposicion(finalidad, ["a"|S], S).
preposicion(lugar, ["a"|S], S).
preposicion(lugar, ["para"|S], S).
preposicion(lugar, ["en"|S], S).
preposicion(lugar, ["cerca de"|S], S).
preposicion(lugar, ["alrededor de"|S], S).



%%%%%%%% %%%%% %%%%%%%% SINTAGMAS %%%%%%%% %%%%% %%%%%%%%

%%%%%% SINTAGMA NOMINAL %%%%%%
% Sintagma nominal con pronombre personal solamente. (Ej: yo, nosotros)
sintagma_nominal(N, S0, S):-
    pronombre(posesivo, N, S0,S1),
    sustantivo(_, N, S1,S).

% Sintagma nominal con pronombre personal y pronombre reflexivo. (Ej: yo me, nosotros nos)
sintagma_nominal(N, S0, S):-
    pronombre(posesivo, N, S0,S1),
    sustantivo(G, N, S1,S2), 
    adjetivo(G, N, S2,S), S1\=S2.

sintagma_nominal(_, S0, S):-
    local(S0,S).

sintagma_nominal(N, S0, S):-
    articulo(_,N,S0,S1),
    local(S1,S).

sintagma_nominal(_, S0, S):-
    establecimiento(S0,S).

sintagma_nominal(_, S0, S):-
    articulo(_,_,S0,S1),
    establecimiento(S1,S).


%%%%%% SINTAGMA VERBAL %%%%%%
% % Verbo solo en infinitivo (Ej: pasar).
% sintagma_verbal(N,S0,S):-
%     verbo(infinitivo, N, S0, S).

% % Verbo intransitivo solo (Ej: viajo).
% sintagma_verbal(N,S0,S):-
%     verbo(intransitivo, N, S0, S).

% % Verbo reflexivo, verbo infinitivo (Ej: quiero ir).
% sintagma_verbal(S0,S):-
%     verbo(transitivo, _, S0, S1),
%     verbo(infinitivo, _, S1, S).

% % Verbo reflexivo, a, verbo infinitivo  (Ej: voy a pasar).
% sintagma_verbal(S0,S):-
%     verbo(reflexivo, _, S0, S1),
%     preposicion(finalidad, S1, S2),
%     verbo(infinitivo, _, S2, S).




%%%%%% SINTAGMA PREPOSICIONAL %%%%%%
% Sintagma preposicional con una preposicion y un lugar (Ej: heredia)
sintagma_preposicional(lugar, S0, S):-
    ciudad(S0,S).
% Sintagma preposicional con una preposicion y un lugar (Ej: a heredia)
sintagma_preposicional(lugar, S0, S):-
	preposicion(lugar, S0, S1),
	ciudad(S1, S).

% Sintagma preposicional con un articulo y un lugar (Ej: al supermercado)
sintagma_preposicional(N, S0, S):-
    articulo(_,N,S0,S1),
	ciudad(S1, S).


%%%%%%%% %%%%% %%%%%%%% ORACIONES %%%%%%%% %%%%% %%%%%%%%

% Oración (Ej: si)
oracion(S0,S):-
    afirmativo(S0,S).

% Oración (Ej: no.)
oracion(S0,S):-
    negativo(S0,S).

% Oración (Ej: pulperia)
oracion(S0,S):-
    sintagma_nominal(_,S0,S).

% Oración (Ej: En Tamarindo.)
oracion(S0,S):-
    sintagma_preposicional(lugar,S0,S).

% Oración (Ej: Si, a Tamarindo.)
oracion(S0,S):-
    afirmativo(S0,S1),
    sintagma_preposicional(lugar,S1,S).

% Oración (Ej: Mi lugar es Tamarindo.)
oracion(S0,S):-
    sintagma_nominal(_,S0,S1),
    verbo(copulativo,_,S1,S2),
    sintagma_preposicional(lugar,S2,S).

% Oración (Ej: Estoy en Tamarindo.)
oracion(S0,S):-
    verbo(X, _, S0, S1), X\=transitivo, X\=reflexivo, 
    sintagma_preposicional(lugar,S1,S).

%Oración (Ej: Yo estoy en Tamarindo.)
oracion(S0,S):-
    pronombre(personal, N, S0,S1),
    verbo(X, N, S1, S2),  X\=transitivo, X\=reflexivo, 
    sintagma_preposicional(lugar,S2,S).

%Oración (Ej: Yo quiero visitar el establecimiento.)
oracion(S0,S):-
    pronombre(personal, N, S0,S1),
    verbo(transitivo, N, S1, S2),
    verbo(infinitivo, _, S2, S3),
    sintagma_preposicional(N,S3,S).

% Oración (Ej: Me encuentro en Tamarindo.)
oracion(S0,S):-
    pronombre(reflexivo, N, S0,S1),
    verbo(reflexivo, N, S1, S2),
    sintagma_preposicional(lugar,S2,S).

% Oración (Ej: Yo me encuentro en Tamarindo.)
oracion(S0,S):-
    pronombre(personal, N, S0,S1),
    pronombre(reflexivo, N, S1,S2),
    verbo(reflexivo, N, S2, S3),
    sintagma_preposicional(lugar,S3,S).
