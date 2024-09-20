import guerreros.*
object baculo {
  method poderArma(guerrero) {
    return guerrero.poderBaculo()
  }
}

object espada {
  
  method valorSegunOrigen(guerrero) {
    if (guerrero.origen() == "elfico") {
        return 25
    } else if (guerrero.origen() == "enano") {
        return 20
    } else {
        return 15
    }
  }

  method poderArma(guerrero) {
    return 10 * self.valorSegunOrigen(guerrero)
  }
}