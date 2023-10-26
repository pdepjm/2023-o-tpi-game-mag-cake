import wollok.game.*
import chefYSusRecetas.*
import partida.*
import ingredientes.*
import ingredientesInstanciados.*

object aprendizDeChef {
	const property inventario=[]

	var puntaje = 0
	var property position = game.at(30,1)

	method image() = "AprendizDeChef.png"
	
	method capturarUnidad(unidad){
		inventario.add(unidad.ingredienteRepresentado())
		
		if(unidad.tieneMoho()){
			game.say( mensajeAprendiz,"Nooo! un mohoso")
			unidad.ingredienteRepresentado().contaminarse()
		}
	}
	method perderUnidad(){
		const unidadRandom = inventario.anyOne()
		inventario.remove(unidadRandom)
	}

	method sumarPuntos(puntos){puntaje += puntos}
	method puntaje() = puntaje

	/*****Movimiento ********************************************************/
	method moverseHaciaArriba(){
		if (self.position().y() < 9) self.position(position.up(1))
	}
	
	method moverseHaciaAbajo(){
		if (self.position().y() > 1) self.position(position.down(1))
	}
	
	method moverseHaciaIzquierda(){
		self.position(position.left(2)) 
	}
	
	method moverseHaciaDerecha(){
		self.position(position.right(2)) 
	}
	/*************************************************************************/
}

//////// OBJETOS INVSIBLES ///////////////////////////////////////////
object bandeja{
	method position() = aprendizDeChef.position().up(11) 
}
	
object mensajeAprendiz{
	method position() = aprendizDeChef.position().up(9).right(7)
}
//////////////////////////////////////////////////////////////////////		
object seleccionador inherits Visual(image="Seleccionador.png", position=game.at(14,4)){
	var property eligio = false
	
	method seleccionar(){
		const botonSeleccionado = game.colliders(self).last()
		botonSeleccionado.presionar()
	}
	
	/*****Movimiento ********************************************************/
	method moverseHaciaIzquierda(){
		if (self.position().x() > 14) self.position(position.left(8))
	}
	
	method moverseHaciaDerecha(){
		if (self.position().x() < 54)self.position(position.right(8)) 
	} 
	/*************************************************************************/
	
}











