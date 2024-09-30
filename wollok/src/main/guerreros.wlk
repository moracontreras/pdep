import armas.*
import zonas.*


class Guerrero{
    var cantidadDeVida = 0
    var armas = []
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
    method poder(){
        if(cantidadDeVida<10)
        return self.obtenerPoder(300)
        else
        return self.obtenerPoder(15)
    }
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
    method tienePoderSuperiorA1500(){
        return self.poder()>1500
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

const gandalf = new Guerrero(
    cantidadDeVida = 100,
    armas = [baculo, espadaElfica]
)

object tom{
    var vestimenta = ["Chaqueta azul", "Botas amarillas", "Sombrero"]
    method puedePasar(unaZona) = true
    method atravesar(unaZona) {}
    method vestimenta() = vestimenta
}
