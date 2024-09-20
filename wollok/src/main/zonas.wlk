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
            return ! guerrero.armas().isEmpty()
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
