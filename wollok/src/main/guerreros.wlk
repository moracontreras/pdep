import armas.*

object gandalf {

  var property nivelDeVida = 0  
  const armas = #{}
  const poderBaculo = 400
  
  var property origen = "elfico"

  method poderBaculo() = poderBaculo
  method armas() = armas

  method agregarArma(unArma) {
    armas.add(unArma)
  }

  method sacarArma(unArma) {
    armas.remove(unArma)
  }

  method poderGuerrero() {
    if (nivelDeVida < 10) {
        return (nivelDeVida * 300) + (self.sumaPoderArmas() * 2)
    } else {
        return (nivelDeVida * 15) + (self.sumaPoderArmas() * 2)
    }
  }

  method sumaPoderArmas() {
    return armas.sum({unArma => unArma.poderArma(self)})
  }


}