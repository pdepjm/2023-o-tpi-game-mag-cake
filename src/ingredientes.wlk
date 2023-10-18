import wollok.game.*
import factories.*
import personajes.*
import receta.*

/// INGREDIENTES ////////////////////////////////////////////////////////////////////////////////////////////////////////////
const ingredientesCapa1= ["1Chocolate.png","1Marmolado.png","1Vainilla.png","1Frutilla.png","1RedVelvet.png"] 
const ingredientesCapa2= ["2Arandano.png","2Chocolate.png","2Frutilla.png","2Vainilla.png","2Crema.png"] 
const ingredientesCapa3= ["3GlaseadoChoco.png","3GlaseadoMixto.png","3Bolitas.png","3Granas.png","3Salsa.png"] 
const ingredientesCapa4= ["4Cereza.png","4Frutilla.png","4Naranja.png","4Chocolate.png","4Arandano.png"] 

const todosLosIngredientes = ingredientesCapa1 + ingredientesCapa2 + ingredientesCapa3 + ingredientesCapa4 

const ingredientesMohosos=["Moho2Arandano.png","Moho2Chocolate.png","Moho2Frutilla.png","Moho2Vainilla.png","Moho2Crema.png"] 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Ingrediente inherits Visual(position = new Position(x = 9.randomUpTo(61),y = 45)){
	
	method caer(){ 
		game.onTick(500, "caida", {self.position(position.down(1))})
	}
	
	method inventario(){}
	/* Falta agregar que cuando el ingrediente llega a la fila 9 desaparezca, implementar... */
}

object proveedor{
	
	const property aquellosQueCaen = self.seleccionarIngredientes()
	
	method seleccionarIngredientes(){
		const ingredientesPedidos = []
		const ingredientesExtra = []
		
		//Todos los ingredienets que se necesitan para las recetas
		chef.recetas().forEach{receta => ingredientesPedidos.addAll(receta.ingredientes())}
		//Ingredientes Adicionales
		8.times({i => ingredientesExtra.add(todosLosIngredientes.anyOne())})
		3.times({i => ingredientesExtra.add(ingredientesMohosos.anyOne())})
		
		return ingredientesPedidos + ingredientesExtra
	}
	
	method tirarIngrediente(){
		if(aquellosQueCaen.isEmpty()){
			
			game.removeTickEvent("Lluvia de Ingredientes")
			game.onTick(10000,"Siguiente", {
				game.addVisual(new Visual(image = "Instruccion.png",position=game.at(50,2)))
				game.say(mensajeChef,"Listos para armar CupCakes!")
			})

		}
		else{
			
			const ingrediente = new Ingrediente(image = aquellosQueCaen.anyOne())
			game.addVisual(ingrediente)
			aquellosQueCaen.remove(ingrediente.image())
			ingrediente.caer()
		}
		
	}
	
}
		
	

