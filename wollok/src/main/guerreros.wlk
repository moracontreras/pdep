import armas.*
import zonas.*


class Guerrero{
    var cantidadDeVida = 0
    var armas = []
    var items = []
    method armas() = armas
    method poderArmas(){
        return armas.sum({unArma=> unArma.poder()})
    }
    method cantidadDeVida(unaCantidad){
        cantidadDeVida = (unaCantidad.max(0)).min(100)
    }
    method obtenerPoder(unaCantidad){
        return cantidadDeVida*unaCantidad + self.poderArmas()*2
    }
    method poder(){}
    method cantidadDeVida()= cantidadDeVida
        method agregarArma(unArma){
        armas.add(unArma)
    }
    method eliminarUnArma(unArma){
        armas.remove(unArma)
    }
    method vaciarArmas(){
        armas.clear()
    }
    method perderVida(unaCantidad){
        cantidadDeVida -= unaCantidad
    }
    method aumentarVida(unaCantidad){
        cantidadDeVida += unaCantidad
    }
    method tieneArmas(){
        return ! armas.isEmpty()
    }

    method atravesar(unaZona) {
        unaZona.dejarPasar(self)
    }

    method puedePasar(unaZona) {
        return unaZona.permitePasar(self)
    }
}

//Clases de guerreros

class Hobbit inherits Guerrero {
  method cantidadDeItems() = items.sum()
  override method poder() = cantidadDeVida + self.poderArmas() + self.cantidadDeItems()
  
}
class Enano inherits Guerrero {
    const factorDePoder = 0
    override method poder() = cantidadDeVida + factorDePoder * self.poderArmas()
}

class Elfo inherits Guerrero {
    var destrezaPropia = 0
    var destrezaBase = 2
    method sumarDestreza(unValor) {
        destrezaPropia += unValor
    }
    override method poder() = cantidadDeVida + self.poderArmas() * (destrezaPropia + destrezaBase)
}

class Humano inherits Guerrero {
    var limitadorDePoder = 0
    override method poder() = cantidadDeVida * self.poderArmas() / limitadorDePoder
}

class Maiar inherits Guerrero {
  const poderBasico = 15
  const poderBajoAmenaza = 300
  var factorActual = poderBasico

  method cambiarFactorAPoderBajoAmenaza() {
    factorActual = poderBajoAmenaza
  }

  method cambiarFactorAPoderBasico() {
    factorActual = poderBasico
  }

  override method poder() {
    return cantidadDeVida * factorActual + self.poderArmas() * 2
  }
}

class Gollum inherits Hobbit {
  override method poder() {
    return super.poder() / 2
  }
}

//Guerreros
const frodo = new Hobbit(
  cantidadDeVida = 50,
  armas = [espadaDeFrodo]
)

const gimli = new Enano (
    factorDePoder = 3,
    cantidadDeVida = 75,
    armas = [hachaDeGimli , hachaDeGimli]
)

const legolas = new Elfo (
    cantidadDeVida = 80,
    destrezaPropia = 1,
    armas = [arcoDeLegolas , espadaDeLegolas]
)

const aragorn = new Humano (
    limitadorDePoder = 20,
    cantidadDeVida = 85,
    armas = [espadaAnduril , dagaEnana]
)

const gandalf = new Maiar(
    cantidadDeVida = 100,
    armas = [baculo, glamdring]
)


object tom{
    var vestimenta = ["Chaqueta azul", "Botas amarillas", "Sombrero"]
    method puedePasar(unaZona) = true
    method atravesar(unaZona) {}
    method vestimenta() = vestimenta
}
