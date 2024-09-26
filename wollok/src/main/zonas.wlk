import guerreros.*

object lebennin{
    method puedePasar(guerrero){
        if (guerrero == tom)
            return true
        else
            return guerrero.tienePoderSuperiorA1500()    
    }
    method atravesar(guerrero){}

}
object minasTirith{
    method puedePasar(guerrero){
        if (guerrero == tom)
            return true
        else        
            return guerrero.tieneArmas()
    }
    method atravesar(guerrero){
        if (guerrero != tom)
            guerrero.perderVida(10)
    }
}
object lossarnach{
    method puedePasar(guerrero)= true
    method atravesar(guerrero){
        if(guerrero != tom)
            guerrero.aumentarVida()
    }
}

object caminoDeGondor {
  var camino = #{lebennin , minasTirith}

  method modificarCamino(partida , llegada) {
    camino = #{partida , llegada}
  }

  method puedeAtravesar(guerrero) = camino.all({unaZona => unaZona.puedePasar(guerrero)})
  
  method recorrerCamino(guerrero) {
    if(self.puedeAtravesar(guerrero))
        camino.forEach({unaZona => unaZona.atravesar(guerrero)})
  }
}
