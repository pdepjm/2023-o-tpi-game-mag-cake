import wollok.game.*
import ingredientes.*
import estacionDeArmado.*
import partida.*
import jugador.*


object chef inherits Visual(image="Chef.png", position = game.at(50,26)){
	
	const recetas = []
	
	method recetas() = recetas
	method crearReceta(abscisa,ordenada){
		const receta = new Receta(position = game.at(abscisa,ordenada))
		recetas.add(receta)
		game.addVisual(receta)
		receta.mostrarReceta()
	}

	method puntuarCupCake(){
		const puntaje = self.calcularPuntaje()
		game.addVisual(self)
		game.addVisual(mensajeChef)
		aprendizDeChef.sumarPuntos(puntaje)
		game.say(mensajeChef,"Tu puntaje: " + puntaje)
		game.schedule(1500,{
			game.addVisual(new Visual(image = "PresioneEnter.png", position = game.at(23,13)))
		})
		keyboard.enter().onPressDo{partida.armarCupCakes()}	
	}
	
	method calcularPuntaje(){
		const cupCake = estacionDeArmado.cupCake()
		const receta = estacionDeArmado.recetaAsignada()
		const coincidencias = cupCake.count{ingrediente => receta.ingredientes().contains(ingrediente)
		}
		const mohoso = cupCake.any{ingrediente => ingrediente.conMoho()}
		
		var puntaje = coincidencias * 25
		if(mohoso) puntaje -= 10
		
		return puntaje
	}
}
object mensajeChef{
	method position() = chef.position().up(1).right(7)
}
//////////////////////////////////////////////////////////////////////
	
class Receta inherits Visual(image = "CuadernoRecetas.png"){
	
	var imagenes = []
	
	//Ingredientes receta/////////////////////////////////////////////
	const sabor = ingredientesCapa1.anyOne()
	const cremita = ingredientesCapa2.anyOne()
	const cobertura = ingredientesCapa3.anyOne()
	const decoracion = ingredientesCapa4.anyOne()
	
	const ingredientes =[sabor,cremita,cobertura,decoracion]
	//////////////////////////////////////////////////////////////////
	method ingredientes() = ingredientes
	
	method posicionIngrediente(n){
		const abscisaReceta = position.x()
		const ordenadaReceta = position.y()
		return new Position(x = abscisaReceta+12, y = ordenadaReceta+n)
	}

	method mostrarReceta(){
		
		const imagenSabor = new Visual(image=sabor.id(),position=self.posicionIngrediente(4))
		const imagenCremita = new Visual(image=cremita.id(),position=self.posicionIngrediente(8))
		const imagenCobertura = new Visual(image=cobertura.id(),position=self.posicionIngrediente(12))
		const imagenDecoracion = new Visual(image=decoracion.id(),position=self.posicionIngrediente(16))
		imagenes = [imagenSabor, imagenCremita, imagenCobertura, imagenDecoracion]
		
		imagenes.forEach{imagen => game.addVisual(imagen)}
	}
	
	method removerReceta(){
		imagenes.forEach{imagen => game.removeVisual(imagen)}
	}
}
