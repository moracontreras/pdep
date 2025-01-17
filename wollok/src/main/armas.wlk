import guerreros.*


class Baculo {
  const poder = 0
  method poder() = poder 
}

const baculo = new Baculo (poder = 400)

class Espada {
  var multiplicadorDePoder = 0
    method multiplicadorDePoder(unPoder) {
        multiplicadorDePoder = (unPoder.max(1)).min(20)
    }
    method multiplicadorDePoder() =  multiplicadorDePoder

    var poderPorOrigen = 0
  method poderPorOrigen() = poderPorOrigen

  method poder(){
    return multiplicadorDePoder * poderPorOrigen
  }
}

class EspadaElfica inherits Espada(poderPorOrigen = 30){}
  
class EspadaEnana inherits Espada(poderPorOrigen = 20){}

class EspadaHumana inherits Espada(poderPorOrigen = 15){}

class Daga inherits Espada {
    override method poder() {
        return super() / 2
    }

    method poderPorOrigen(unPoder) {
      poderPorOrigen = unPoder
    }
}

class Arco  {
  var property tension = 40 
  var largo = 0

  method largo() = largo

  method poder() {
    return (tension * largo) / 10
  }
}

class Hacha {
  var largoDelMango = 0
  var pesoDeHoja = 0
  method largoDelMango() = largoDelMango
  method pesoDeHoja() = pesoDeHoja

  method poder() {
    return largoDelMango * pesoDeHoja
  }
}

//Armas de los guerreros
const espadaDeFrodo = new EspadaElfica(multiplicadorDePoder = 8)

const hachaDeGimli = new Hacha (largoDelMango = 70 , pesoDeHoja = 5)

const arcoDeLegolas = new Arco (largo = 110)

const espadaDeLegolas = new EspadaElfica(multiplicadorDePoder = 12)

const dagaEnana = new Daga (poderPorOrigen = 20 , multiplicadorDePoder = 10)

const espadaAnduril = new EspadaElfica(multiplicadorDePoder = 18)

const glamdring = new EspadaElfica(multiplicadorDePoder = 10)