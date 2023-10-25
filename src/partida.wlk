import wollok.game.*
import ingredientes.*
import receta.*
import devorador.*
import jugador.*
import ingredientesInstanciados.*
import proveedor.*
import estacionDeArmado.*

const anchoTablero = 75
const altoTablero = 50

object partida{
	
	////////////////// DIMENSIONES TABLERO ///////////////////
	
	method tableroBase(){
		game.clear()
		game.cellSize(20)
		game.width(anchoTablero)
		game.height(altoTablero)
	}
	
	////////////////////////// INTRO /////////////////////////
	
	method iniciar(){
		game.title("Operacion CupCakes")
		self.tableroBase()
		game.boardGround("PantallaInicio.png")	
		keyboard.enter().onPressDo{self.revelarRecetas()}
	}
	
	
	////////////////////// PRIMERA PARTE //////////////////////
	
	method revelarRecetas(){
		self.tableroBase()
		game.addVisual(new Visual(image ="FondoBase.png"))
		chef.crearReceta(5,19)
		chef.crearReceta(29,19)
		chef.crearReceta(53,19)
		keyboard.enter().onPressDo{self.caceriaSalvaje()}

	}
	
	
	////////////////////// SEGUNDA PARTE //////////////////////
	
	method caceriaSalvaje(){
		self.tableroBase()
		game.addVisual(new Visual(image ="FondoCaida.png"))
		
		/*****Devorador*****/
		game.addVisual(devorador)
		
		game.onTick(4000,"movimiento", {
		devorador.moverseRandom()
		})
		
		game.whenCollideDo(devorador, {personaje =>
			personaje.position(personaje.position().right(2))
			devorador.devorar()
		})
		/*****Aprediz de Chef (jugador)*****/
		game.addVisual(aprendizDeChef)
		game.addVisual(bandeja)
		game.addVisual(mensajeAprendiz)
		
		keyboard.up().onPressDo( {aprendizDeChef.moverseHaciaArriba() } )
		keyboard.down().onPressDo( {aprendizDeChef.moverseHaciaAbajo() } )
		keyboard.left().onPressDo( {aprendizDeChef.moverseHaciaIzquierda() } )
		keyboard.right().onPressDo( {aprendizDeChef.moverseHaciaDerecha() } )
		
		game.say(mensajeAprendiz,"Cuidado con los mohosos")
		
		game.whenCollideDo(bandeja, {unidad => 
			aprendizDeChef.capturarUnidad(unidad)
			unidad.atrapado()
			game.removeVisual(unidad)
		})
		
		/*****Ingredientes*****/
		proveedor.tirarIngredientePorUnidad()// para que haya un primer ingrediente cayendo
		
		game.onTick(4000, "Lluvia de Ingredientes", {
			proveedor.tirarIngredientePorUnidad()
		})
		
		keyboard.c().onPressDo{self.armarCupCakes()}
	}
	
	method armarCupCakes(){
		game.clear()
		self.tableroBase()
		game.addVisual(new Visual(image ="FondoArmado.png"))
		
		/*****Seleccionador*****/
		seleccionador.position(game.at(14,4))
		game.addVisual(seleccionador)
		const instruccion= new Visual(image="PresioneEspacio.png", position=game.at(15,13))
		game.addVisual(instruccion)
		game.schedule(3000,{game.removeVisual(instruccion)})
		keyboard.left().onPressDo({seleccionador.moverseHaciaIzquierda()})		
		keyboard.right().onPressDo({seleccionador.moverseHaciaDerecha()})
		keyboard.space().onPressDo{seleccionador.seleccionar()}
		
		estacionDeArmado.hacerUnCupCake()
		
	}
	
	method avisarFinDeCaceria(){
		game.schedule(14000,{
				game.addVisual(new Visual(image = "Instruccion.png",position=game.at(50,2)))
				game.say(mensajeAprendiz,"Listos para armar CupCakes!")
			})
	}
}

