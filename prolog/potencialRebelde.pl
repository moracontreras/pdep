%punto1
persona(bakunin).
persona(ravachol).
persona(rosaDubovsky).
persona(emmaGoldman).
persona(judithButler).
persona(elisaBachofen).
persona(juanSuriano).
persona(sebastianFaure).

trabaja([aviacionMilitar],bakunin).
trabaja([inteligenciaMilitar],ravachol).
trabaja([profesoraJudo,cineasta], emmaGoldman).
trabaja([profesoraJudo,inteligenciaMilitar],judithButler).
trabaja(inteligenciaMecanica,elisaBachofen).

tieneGustos([juegosDeAzar,ajedrez,tiroAlBlanco],ravacol).
tieneGustos([construirPuentes,mirarPeppaPig,fisicaCuantica],rosaDubovsky).
tieneGustos([judo,carrerasDeAutomovilismo], emmaGoldman).
tieneGustos([judo,carrerasDeAutomovilismo],judithButler).
tieneGustos([fuego,destruccion],elisaBachofen).
tieneGustos([judo,armarBobas,ring-raje],juanSuriano).

habilidadesDe(bakunin,[conducirAutos]).
habilidadesDe(ravacol,[tiroAlBlanco]).
habilidadesDe(rosaDubovsky,[construirPuentes,mirarPeppaPig]).
habilidadesDe(emmaGoldman,[judo,armarBombas]).
habilidadesDe(judithButler,[judo]).
habilidadesDe(elisaBachofen,[armarBombas]).
habilidadesDe(juanSuriano,[judo,armarBobas,ring-raje]).

tieneHabilidad(Habilidad,Alguien):-
    persona(Alguien),
    habilidadesDe(Alguien,Habilidades),
    member(Habilidad,Habilidades).

historialCriminal([roboAeronaves,fraude,tenenciaCafeina],bakunin).
historialCriminal([falsificacionVacunas,fraude],ravacol).
historialCriminal([falsificacionCheques,fraude],judithButler).
historialCriminal([falsificacionDinero,fraude],juanSuriano).

% PUNTO 2
tieneVivienda([bakunin,elisaBachofen,rosaDubovsky],laSaverino).
tieneVivienda([ravachol],comisaria48).
tieneVivienda([emmaGoldman,juanSuriano,judithButler],laCasaDePapel).

tieneEsconditesVivienda(laSaverino,[cuatoSecreto(4,8),pasadizos(1),tunel(8,construido),tunel(5,construido),tunel(1,enConstruccion)]).
tieneEsconditesVivienda(laCasaDePapel,[pasadizos(2),cuartoSecreto(5,3),cuartoSecreto(4,7),tunel(9,construido),tunel(2,construido)]).
tieneEsconditesVivienda(casaDelSolNaciente,[pasadizos(1),tunel(3,sinConstruir)]).

% PUNTO 5

esActividadTerrorista(Actividad):-
    member(Actividad,[armarBombas,tiroAlBlanco,mirarPeppaPig]).

noTieneGustosOSoloTieneBuenos(Alguien):-
    not(tieneGustos(Alguien,_)).

noTieneGustosOSoloTieneBuenos(Alguien):-
    soloTieneGustosBuenos(Alguien).

soloTieneGustosBuenos(Alguien):-
    tieneGustos(Alguien,Gustos),
    forall(member(Gusto,Gustos), not(esActividadTerrorista(Gusto))).
    
tieneHabilidadesTerroristas(Alguien):-
    habilidadesDe(Alguien,Habilidades),
    member(Habilidad,Habilidades),
    esActividadTerrorista(Habilidad).

convivientesDe(Persona, Convivientes) :-
    tieneVivienda(Convivientes, Vivienda),
    member(Persona, Convivientes).

largoHistorialCriminalEnVivienda(Alguien):-
    convivientesDe(Alguien,Convivientes),
    member(unConviviente,Convivientes),
    tieneLargoHistorialCriminal(unConviviente).

tieneLargoHistorialCriminal(Alguien):-
    historialCriminal(Historial,Alguien),
    length(Historial,Largo),
    Largo > 1.
