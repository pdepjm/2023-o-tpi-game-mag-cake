
import wollok.game.*
import partida.*
import ingredientes.*
import chefYSusRecetas.*
import jugador.*
import devorador.*

//-----------------------------------------------------------------------------------------------------------------------------------

object proveedor {
	
	const property unidadesATirar = self.seleccionarUnidades()
	
	method seleccionarUnidades(){
		const ingredientesNecesarios = []
		const unidadesExtra = []
		const agregarUnidadesPorReceta={receta=>receta.ingredientes().forEach{ingrediente =>
				ingredientesNecesarios.add(new UnidadIngrediente(ingredienteRepresentado = ingrediente))}}
		
		//Todos los ingredientes que se necesitan para las recetas
		chef.recetas().forEach{receta => agregarUnidadesPorReceta.apply(receta)}
		//Ingredientes Adicionales
		9.times({i => unidadesExtra.add(new UnidadIngrediente(ingredienteRepresentado = todosLosIngredientes.anyOne()))})
		// unidades sabotaje
		3.times({i => 
			unidadesExtra.add(new UnidadIngrediente(ingredienteRepresentado = ingredientesCapa2.anyOne(), tieneMoho= true))
			unidadesExtra.add(new MultiplicadorDevorador())
			unidadesExtra.add(new Hielito())
		})

		return ingredientesNecesarios + unidadesExtra 
	}
	
	method tirarUnidad(){
		if(unidadesATirar.isEmpty()){
			
			game.removeTickEvent("Lluvia de Ingredientes")
			partida.avisarFinDeCaceria()
		}
		else{
			const nuevaUnidad = unidadesATirar.anyOne()
			unidadesATirar.remove(nuevaUnidad)
			game.addVisual(nuevaUnidad)
			nuevaUnidad.caer()
		}
	}
	
}

//-----------------------------------------------------------------------------------------------------------------------------------

class Unidad{ 
	
	var position = new Position(x = self.asignarRandom() , y = 45)
	var estaAtrapado = false
	
	method image()
	method position() = position
	
	method asignarRandom(){
		const list = [10,16,22,28,34,40,46,52,58]
		return list.anyOne()
	}
	
	method atrapado(){
		self.efecto()
		estaAtrapado=true
	}
	method efecto()
	
	method caer(){ 
		game.onTick(200,"caida", {
			position=position.down(1)
			if(position.y()== 9 && !estaAtrapado){
				game.removeVisual(self)
			}
			
			if(position.y()== 0) game.removeTickEvent("caida") //elimino el lagg
		})
	}
}

class UnidadIngrediente inherits Unidad{
	const ingredienteRepresentado
	const tieneMoho = false
	
	method tieneMoho() = tieneMoho
	method ingredienteRepresentado() = ingredienteRepresentado
	override method image(){
		if(tieneMoho) return "Moho" + ingredienteRepresentado.id()
		else return ingredienteRepresentado.id()
	}
	
	override method efecto(){
		aprendizDeChef.capturarUnidad(self)
	}
}

class MultiplicadorDevorador inherits Unidad{
	override method image() = "DevoradorMasMas.png"
	
	override method efecto(){
		const nuevoDevorador = new Devorador()
		nuevoDevorador.molestar()
		// para que la imagen este por delante
		game.removeVisual(aprendizDeChef)
		game.addVisual(aprendizDeChef)
		game.say(mensajeAprendiz, "¿Qué hacés? ESQUIVALO!")
		game.sound("niamniam.mp3").play()
	}
}

class Hielito inherits Unidad{
	override method image() = "Hielito.png"
	
	override method efecto(){
		aprendizDeChef.congelado(true)
		game.say(mensajeAprendiz, "Me Congeléee!")
		game.sound("Ice.mp3").play()
		game.schedule(2500,{aprendizDeChef.congelado(false)})
	}
}
