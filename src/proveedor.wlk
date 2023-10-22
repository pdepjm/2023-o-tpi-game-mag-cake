import wollok.game.*
import partida.*
import factories.*
import receta.*
import ingredientes.*
import jugador.*

object proveedor{
	
	const property pedidoIngredientes = self.seleccionarIngredientes()
	
	method seleccionarIngredientes(){
		const ingredientesNecesarios = []
		const ingredientesExtra = []
		
		//Todos los ingredienets que se necesitan para las recetas
		chef.recetas().forEach{receta => ingredientesNecesarios.addAll(receta.ingredientes())}
		//Ingredientes Adicionales
		5.times({i => ingredientesExtra.add(todosLosIngredientes.anyOne())})
		3.times({i => ingredientesExtra.add(ingredientesMohosos.anyOne())})
		
		return ingredientesNecesarios + ingredientesExtra
	}
	
	method tirarIngredientePorUnidad(){
		if(pedidoIngredientes.isEmpty()){
			game.removeTickEvent("Lluvia de Ingredientes")
			partida.avisarFinDeCaceria()
		}
		else{
			const ingrediente = pedidoIngredientes.anyOne()
			ingrediente.nuevaUnidad()
			pedidoIngredientes.remove(ingrediente)
		}
	}
	
}