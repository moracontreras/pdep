import guerreros.*
object baculo {
  const property poder = 400 
}

object espada {
  var property origen = "Elfico"

  method cambiarOrigen(origenNuevo) {
    origen = origenNuevo
  }

  method poder() {
    if (origen == "Elfico") {
        return 10 * 25
    } else if (origen == "Enano") {
        return 10 * 20
    } else {
        return 10 * 15
    }
  }
}