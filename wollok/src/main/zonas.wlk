import guerreros.*
import armas.*


object lebennin {
  method permitePasarA(guerrero) {
    return guerrero.poderGuerrero() > 1500
  }

  method consecuencias(guerrero) {}
}

object minasTirith {
  method permitePasarA(guerrero) {
    return guerrero.armas().size() > 0
  }

  method consecuencias(guerrero) {
    return 0.max(guerrero.nivelDeVida() - 10)
  }

}

object lossarnach {
  method permitePasarA(guerrero) = true

  method consecuencias(guerrero) {
    return 100.min(guerrero.nivelDeVida() + 1)
  }
}

object caminoDeGondor {
  const camino = #{lebennin, minasTirith}
  
  method camino() = camino
  
  method permitePasarA(guerrero) {
    return camino.all({unLugar => unLugar.permitePasarA(guerrero)})
  }

  method consecuencias(guerrero) {
    camino.forEach({unLugar => unLugar.consecuencias(guerrero)})
  }

}