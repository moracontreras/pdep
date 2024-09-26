import guerreros.*

class Arma {
  method poder()
}


class Baculo inherits Arma {
  const poder = 0
  override method poder() = poder 
}

const baculo = new Baculo (poder = 400)

class Espada inherits Arma{
  const poderPorOrigen = 0
  override method poder(){
    return 10* poderPorOrigen
  }
}

const espadaElfica = new Espada(
  poderPorOrigen = 30
)

const espadaEnana = new Espada(
  poderPorOrigen = 20
)

const espadaHumana = new Espada(
  poderPorOrigen = 15
)
