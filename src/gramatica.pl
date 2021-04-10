:-consult(database).

%%%%% RESPUESTAS %%%%%
% posibles respuestas negativas.
negativo(["no"|S], S).
negativo(["n"|S], S).
negativo(["ninguno"|S], S).
% posibles respuestas afirmativas.
afirmativo(["si"|S], S).
afirmativo(["s"|S], S).
afirmativo(["afirmativo"|S], S).

%%%%% ADVERBIOS %%%%
adverbio(["no"|S], S).
adverbio(["n"|S], S).
adverbio(["ninguno"|S], S).
adverbio(["si"|S], S).
adverbio(["s"|S], S).
adverbio(["afirmativo"|S], S).

%%%%% PRONOMBRES %%%%%
%pronombre(Tipo, Numero, Pronombre, Oracion).
pronombre(personal, singular,["yo"|S],S).
pronombre(personal, plural,["nosotras"|S],S).
pronombre(personal, plural,["nosotros"|S],S).
pronombre(reflexivo, singular,["me"|S],S).
pronombre(reflexivo, plural,["nos"|S],S).
pronombre(posesivo, singular,["mi"|S],S).
pronombre(posesivo, singular,["nuestro"|S],S).
pronombre(impersonal, _,["se"|S],S).

%%%%% ARTICULOS %%%%%
%pronombre(Genero, Numero, Articulo, Oracion).
articulo(masculino, singular, ["el"|S], S).
articulo(masculino, singular, ["al"|S], S).
articulo(masculino, plural, ["los"|S], S).
articulo(femenino, singular, ["la"|S], S).
articulo(femenino, plural, ["las"|S], S).
articulo(masculino, singular, ["un"|S], S).
articulo(masculino, plural, ["unos"|S], S).
articulo(femenino, singular, ["una"|S], S).
articulo(femenino, plural, ["unas"|S], S).

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
verbo(reflexivo, singular, ["encuentra"|S], S).
verbo(reflexivo, plural, ["encontramos"|S], S).
verbo(reflexivo, singular, ["ubico"|S], S).
verbo(reflexivo, singular, ["ubica"|S], S).


verbo(transitivo, singular, ["llama"|S], S).
verbo(transitivo, singular, ["quiero"|S], S).
verbo(transitivo, plural, ["queremos"|S], S).
verbo(transitivo, singular, ["necesito"|S], S).
verbo(transitivo, plural, ["necesitamos"|S], S).

%%%%% PREPOSICIONES %%%%%
%preposicion (Tipo, Preposicion, Oracion).
preposicion(finalidad, ["a"|S], S).
preposicion(finalidad, ["para"|S], S).
preposicion(lugar, ["para"|S], S).
preposicion(lugar, ["a"|S], S).
preposicion(lugar, ["en"|S], S).
preposicion(lugar, ["cerca"|S], S).
preposicion(lugar, ["alrededor"|S], S).
preposicion(lugar, ["junto"|S], S).
preposicion(lugar, ["por"|S], S).
preposicion(conexion, ["a"|S], S).
preposicion(conexion, ["de"|S], S).


%%%%%%%% %%%%% %%%%%%%% SINTAGMAS %%%%%%%% %%%%% %%%%%%%%

%%%%%% SINTAGMA NOMINAL %%%%%%
% Sintagma nominal. (Ej: yo, nosotras)
sintagma_nominal(N, S0, S):-
    pronombre(_, N, S0,S).

% Sintagma nominal. (Ej: yo me, nosotros nos)
sintagma_nominal(N, S0, S):-
    pronombre(personal, N, S0,S1),
    pronombre(reflexivo, N, S1,S).

% Sintagma nominal. (Ej: mi destino)
sintagma_nominal(N, S0, S):-
    pronombre(posesivo, N, S0,S1),
    sustantivo(_, N, S1,S).

% Sintagma nominal. (Ej: mi destino final)
sintagma_nominal(N, S0, S):-
    pronombre(posesivo, N, S0,S1),
    sustantivo(G, N, S1,S2), 
    adjetivo(G, N, S2,S), S1\=S2.

%% CIUDAD 
% Sintagma nominal. (Ej. ciudad.)
sintagma_nominal(_, S0, S):-
    ciudad(S0,S).
% Sintagma nominal. (Ej. el Cartago.)
sintagma_nominal(N, S0, S):-
    articulo(_,N,S0,S1),
    ciudad(S1,S).

%% LOCAL
% Sintagma nominal. (Ej. local.)
sintagma_nominal(_, S0, S):-
    local(S0,S).
% Sintagma nominal. (Ej. el local.)
sintagma_nominal(N, S0, S):-
    articulo(_,N,S0,S1),
    local(S1,S).

%% ESTABLECIMIENTO
% Sintagma nominal. (Ej. establecimiento.)
sintagma_nominal(_, S0, S):-
    establecimiento(S0,S).
% Sintagma nominal. (Ej. el establecimiento.)
sintagma_nominal(_, S0, S):-
    articulo(_,_,S0,S1),
    establecimiento(S1,S).

% Sintagma nominal. (Ej. el supermercado Walmart.)
sintagma_nominal(_, S0, S):-
    articulo(_,_,S0,S1),
    establecimiento(S1,S2),
    local(S2,S).


%%%%%% SINTAGMA VERBAL %%%%%%
% Sintagma verbal. (Ej: pasar, dirijo, vamos).
sintagma_verbal(N,S0,S):-
    verbo(_, N, S0, S1),
    sintagma_preposicional(N,S1,S).

% Sintagma verbal. (Ej: quiero viajar).
sintagma_verbal(N,S0,S):-
    verbo(transitivo, N, S0, S1),
    verbo(infinitivo, _, S1, S2),
    sintagma_preposicional(N,S2,S).

% Sintagma verbal. (Ej: Necesito pasar al supermercado.).
sintagma_verbal(N,S0,S):-
    verbo(transitivo, N, S0, S1),
    verbo(infinitivo, _, S1, S2),
    sintagma_nominal(N,S2,S).

% Sintagma verbal. (Ej: voy a pasar).
sintagma_verbal(N,S0,S):-
    verbo(reflexivo, N, S0, S1),
    preposicion(finalidad, S1, S2),
    verbo(infinitivo, N, S2, S3),
    sintagma_preposicional(N,S3,S).

%%%%%% SINTAGMA PREPOSICIONAL %%%%%%
% Sintagma preposicional. (Ej: supermercado)
sintagma_preposicional(_, S0, S):-
	ciudad(S0, S).

% Sintagma preposicional. (Ej: supermercado)
sintagma_preposicional(_, S0, S):-
	local(S0, S).

% Sintagma preposicional. (Ej: supermercado)
sintagma_preposicional(_, S0, S):-
	establecimiento(S0, S).

% Sintagma preposicional. (Ej: para el supermercado)
sintagma_preposicional(N, S0, S):-
    preposicion(_,S0,S1),
    sintagma_nominal(N,S1,S).

% Sintagma preposicional. (Ej: cerca de supermercado)
sintagma_preposicional(N, S0, S):-
    preposicion(lugar,S0,S1),
    preposicion(conexion,S1,S2),
    sintagma_nominal(N,S2,S).


%%%%%%%% %%%%% %%%%%%%% ORACIONES %%%%%%%% %%%%% %%%%%%%%

% Oracion (Ej: si, no.)
oracion(S0,S):-
    adverbio(S0,S).

% Oracion (Ej: pulperia)
oracion(S0,S):-
    sintagma_nominal(_,S0,S).

% Oracion (Ej: En Tamarindo.)
oracion(S0,S):-
    sintagma_preposicional(_,S0,S).

% Oracion (Ej: a la universidad.)
oracion(S0,S):-
    sintagma_nominal(_,S0,S1),
    sintagma_preposicional(_,S1,S).


% Oracion (Ej: ir a Tamarindo.)
oracion(S0,S):-
    sintagma_verbal(_,S0,S).

% Oracion (Ej: Si, la universidad.)
oracion(S0,S):-
    adverbio(S0,S1),
    sintagma_nominal(_,S1,S).

% Oracion (Ej: Si, a Tamarindo.)
oracion(S0,S):-
    adverbio(S0,S1),
    sintagma_preposicional(_,S1,S).

% Oracion (Ej: Si, voy para Tamarindo.)
oracion(S0,S):-
    adverbio(S0,S1),
    sintagma_verbal(_,S1,S).

% Oracion (Ej: Mi lugar es Tamarindo.)
oracion(S0,S):-
    sintagma_nominal(N,S0,S1),
    sintagma_verbal(N,S1,S).

% Oracion (Ej: Mi lugar en Tamarindo.)
oracion(S0,S):-
    sintagma_nominal(N,S0,S1),
    sintagma_preposicional(N,S1,S).


% Oracion (Ej: El ssupermercado se llama Walmart.)
oracion(S0,S):-
    sintagma_nominal(_,S0,S1),
    sintagma_verbal(_,S1,S2),
    sintagma_preposicional(_,S2,S).