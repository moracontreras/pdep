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
