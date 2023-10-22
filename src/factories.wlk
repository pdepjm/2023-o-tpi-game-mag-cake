import wollok.game.*

class Visual {
	const property image
	var property position = game.origin()
}
/////// PARA LOS INGREDIENTES ///////////////////////////////////////////////////////////////////////////////////////////////////

class Ingrediente{
	const property capa
	const nombre
	var property tieneMoho = false
	
	method id()=capa + nombre + ".png"
			
	method nuevaUnidad(){
		const unidad= new Unidad(ingredienteRepresentado = self)
		game.addVisual(unidad)
		unidad.caer()
	}	
}

/*
 Eventualmente vamos a tener dos subclases de ingredientes, una para los mohosos y una para los de buen estado
 esto es porque tienen un comportamiento diferente.
 A su vez los ingredientes en buen estado pueden llegar a tener un compotamiento distinto segun la capa
*/

class IngredienteCapa1 inherits Ingrediente(capa="1"){}
class IngredienteCapa2 inherits Ingrediente(capa="2"){}
class IngredienteCapa3 inherits Ingrediente(capa="3"){}
class IngredienteCapa4 inherits Ingrediente(capa="4"){}


/////// PARA LA LLUVIA DE INGREDIENTES //////////////////////////////////////////////////////////////////////////////////////////

class Unidad{ 
	var property position = new Position(x = 9.randomUpTo(61),y = 45)
	
	const property ingredienteRepresentado
	var estaAtrapado = false
	method image()= ingredienteRepresentado.id()
	method atrapado(){
		estaAtrapado=true
	}
	
	method caer(){ 
		game.onTick(500,"caida", {
			position=position.down(1)
			if(position.y()== 9 && !estaAtrapado){
				game.removeVisual(self) 
			} 
		})
	}
}

