import guerreros.*

object lebennin{
    method puedePasarGuerrero(guerrero){
            return guerrero.tienePoderSuperiorA1500()    
    }

    method puedePasarPersona(persona) {
        return persona.puedeAtravesar(self)
    }

    method dejarPasar(guerrero){
    }

}
object minasTirith{
    method puedePasarPersona(persona) {
        return persona.puedeAtravesar(self)
    }
    method puedePasarGuerrero(guerrero){
        return guerrero.tieneArmas()
    }
    method dejarPasar(guerrero){
        guerrero.perderVida(10)
    }
}
object lossarnach{
    method puedePasarGuerrero(guerrero)= true
    method puedePasarPersona(persona) {
        return persona.puedeAtravesar(self)
    }
    method dejarPasar(guerrero){
            guerrero.aumentarVida(1)
    }
}

object caminoDeGondor {
  var camino = #{lebennin , minasTirith}

  method modificarCamino(partida , llegada) {
    camino = #{partida , llegada}
  }

  method puedePasarGuerrero(guerrero) = camino.all({unaZona => unaZona.puedePasarGuerrero(guerrero)})
  
  method dejarPasar(guerrero) {
    if(self.puedePasarGuerrero(guerrero))
        camino.forEach({unaZona => unaZona.dejarPasar(guerrero)})
  }
}
