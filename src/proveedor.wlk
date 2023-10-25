import wollok.game.*
import partida.*
import ingredientes.*
import receta.*
import ingredientesInstanciados.*
import jugador.*

object proveedor{
	
	const property pedidoIngredientes = self.seleccionarIngredientes()
	
	method seleccionarIngredientes(){
		const ingredientesNecesarios = []
		const ingredientesExtra = []
		const agregarUnidadesPorReceta={receta=>receta.ingredientes().forEach{ingrediente =>ingredientesNecesarios.add(new Unidad(ingredienteRepresentado = ingrediente))}}
		
		//Todos los ingredienets que se necesitan para las recetas
		chef.recetas().forEach{receta => agregarUnidadesPorReceta.apply(receta)}
		//Ingredientes Adicionales
		5.times({i => ingredientesExtra.add(new Unidad(ingredienteRepresentado = todosLosIngredientes.anyOne()))})
		3.times({i => ingredientesExtra.add(new Unidad(ingredienteRepresentado = ingredientesCapa2.anyOne(), tieneMoho= true))})
		
		return ingredientesNecesarios + ingredientesExtra
	}
	
	method tirarIngredientePorUnidad(){
		if(pedidoIngredientes.isEmpty()){
			
			game.removeTickEvent("Lluvia de Ingredientes")
			partida.avisarFinDeCaceria()
		}
		else{
			const nuevaUnidad = pedidoIngredientes.anyOne()
			pedidoIngredientes.remove(nuevaUnidad)
			game.addVisual(nuevaUnidad)
			nuevaUnidad.caer()
		}
	}
	
}