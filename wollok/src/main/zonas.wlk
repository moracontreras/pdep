import guerreros.*

class RequerimientoDeItem{
    var item
    var cantidad

    method loCumplen(guerreros){
        return self.obtenerCantidadItemsTotal(item, guerreros) >= cantidad
    }

    method obtenerCantidadItemsTotal(nombreItem, guerreros){
        return guerreros.map({guerrero => guerrero.cantidadItems(nombreItem)}).sum()
    }
}

const requerimientoLembas = new RequerimientoDeItem(item = "lemba", cantidad = 10)
const requerimientoCapas = new RequerimientoDeItem(item = "capa elfica", cantidad = 3)

class RequerimientoDeGuerrero{
    var condicion

    method loCumplen(guerreros){
        return guerreros.any(condicion)
    }
}

const requerimientoDePoder = new RequerimientoDeGuerrero(condicion = {guerrero => guerrero.tienePoderSuperiorA1500()})
const requerimientoDeArmas = new RequerimientoDeGuerrero(condicion = {guerrero => guerrero.tieneArmas()})

class Zona {
    var requerimiento = 0

    method puedenPasar(guerreros){
        return requerimiento.loCumplen(guerreros)
    }

}

//Region de Gondor
object gondor{
    const zonas = [belfalas, lebennin, minasTirith]
}

object lebennin inherits Zona(requerimiento = requerimientoDePoder){

    method permitePasar(guerrero){
        return guerrero.tienePoderSuperiorA1500()    
    }

    method dejarPasar(guerrero){}
}

object minasTirith inherits Zona(requerimiento = requerimientoLembas){

    method permitePasar(guerrero){
        return guerrero.tieneArmas()
    }
    method dejarPasar(guerrero){
        guerrero.perderVida(10)
    }
}


object belfalas inherits Zona(){
    
    override method puedenPasar(guerreros) = true
}


//Region de Rohan
object rohan{
    const zonas = [fangorn, edoras, estemnet]
}


object fangorn inherits Zona(requerimiento = requerimientoDeArmas){
    

}

object edoras inherits Zona(){
    override method puedenPasar(guerreros) = true
}

object estemnet inherits Zona(requerimiento = requerimientoCapas){
}


object lossarnach {
    method permitePasar(guerrero)= true

    method dejarPasar(guerrero){
        guerrero.aumentarVida(1)
    }
}

class Camino{
    var camino = #{}

    method dejarPasar(guerreros) = camino.all{
        zona => zona.puedenPasar(guerreros)
    }
}

const caminoDeGondor = new Camino(camino = #{lebennin , minasTirith})

const bosqueDe = new Camino(camino = #{fangorn, edoras, belfalas, minasTirith})

const caminoPrueba = new Camino(camino = #{belfalas,edoras})
