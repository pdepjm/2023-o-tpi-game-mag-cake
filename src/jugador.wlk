import wollok.game.*
import receta.*
import partida.*
import factories.*
import ingredientes.*

object aprendizDeChef {
	
	const property inventario=[]
	
	var property position = game.at(30,1)
	method image() = "AprendizDeChef.png"
	
	method capturarUnidad(unidad){
		inventario.add(unidad.ingredienteRepresentado())
		
		if(unidad.ingredienteRepresentado().tieneMoho()){
			game.say( mensajeAprendiz,"Nooo! un mohoso")
		}
	}
	method perderUnidad(){
		const unidadRandom = inventario.anyOne()
		inventario.remove(unidadRandom)
	}
	/*****Movimiento ********************************************************/
	method moverseHaciaArriba(){
		if (self.position().y() < 9) self.position(position.up(1))
	}
	
	method moverseHaciaAbajo(){
		if (self.position().y() > 1) self.position(position.down(1))
	}
	
	method moverseHaciaIzquierda(){
		self.position(position.left(1))
	}
	
	method moverseHaciaDerecha(){
		self.position(position.right(1))
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












