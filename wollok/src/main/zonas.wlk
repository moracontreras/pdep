import guerreros.*

object lebennin{
    method permitePasar(guerrero){
            return guerrero.tienePoderSuperiorA1500()    
    }

    method dejarPasar(guerrero){
    }

}
object minasTirith{
    method permitePasar(guerrero){
        return guerrero.tieneArmas()
    }
    method dejarPasar(guerrero){
        guerrero.perderVida(10)
    }
}
object lossarnach{
    method permitePasar(guerrero)= true

    method dejarPasar(guerrero){
            guerrero.aumentarVida(1)
    }
}

object caminoDeGondor {
  var camino = #{lebennin , minasTirith}

  method modificarCamino(partida , llegada) {
    camino = #{partida , llegada}
  }

  method permitePasar(guerrero) = camino.all({unaZona => unaZona.permitePasar(guerrero)})
  
  method dejarPasar(guerrero) {
    if(self.permitePasar(guerrero))
        camino.forEach({unaZona => unaZona.dejarPasar(guerrero)})
  }
}
