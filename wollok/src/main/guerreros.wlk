import armas.*

class Guerrero{
    var cantidadDeVida = 0
    var armas = []
    method armas() = armas
    method poderArmas(){
        return armas.map({unArma=> unArma.poder()}).sum()
    }
    method cantidadDeVida(unaCantidad){
        cantidadDeVida = (unaCantidad.max(0)).min(100)
    }
    method poder(){
        if(cantidadDeVida<10)
        return cantidadDeVida*300 + self.poderArmas()*2
        else
        return cantidadDeVida*15 + self.poderArmas()*2
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
    method aumentarVida(){
        cantidadDeVida +=1
    }
    method tienePoderSuperiorA1500(){
        return self.poder()>1500
    }
}

const gandalf = new Guerrero(
    cantidadDeVida = 100,
    armas = [baculo, espada]
)

const tom = new Guerrero(
    armas = ["Chaqueta azul", "Botas amarillas", "Sombrero"]
)
