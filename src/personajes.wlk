import wollok.game.*
import receta.*
import partida.*

object chef {
	
	const property recetas=[]
	const property inventario=[]
	var property position = game.at(30,1)
	method image() = "chef.png"
	
	method crearReceta(abscisa,ordenada){
		const receta = new Receta(position=game.at(abscisa,ordenada))
		recetas.add(receta)
		game.addVisual(receta)
		receta.mostrarReceta()
	}
	
	method capturarIngrediente(ingrediente){
		const nombre = ingrediente.image()
		inventario.add(ingrediente)
		
		if(nombre.take(4)== "Moho"){
			game.say(mensajeChef,"Nooo! un mohoso")
		}
	}
	
	method perderIngrediente(){
		const ingredienteRandom = inventario.anyOne()
		inventario.remove(ingredienteRandom)
		
	}
	
}

object bandeja{
	method position() = chef.position().up(11) 
	}
	
// para que los mensajes esten a la altura de la cabeza del chef
object mensajeChef{
	method position() = chef.position().up(9).right(7)
}
	
object devorador{
	var property position = game.at(20,5)
	method image() = "devorador.png"
	
	method moverseRandom(){
	const x = 15.randomUpTo(anchoTablero-25).truncate(0)
    const y = 0.randomUpTo(7).truncate(0)
	position = game.at(x,y)
	}
	
	method devorar() {
		if ( chef.inventario().isEmpty() ) {
		game.say(self, "Pobre de Ingredientes")}
		else {
		chef.perderIngrediente()
		game.say(self, "ñam ñam")
		}
	}
}












