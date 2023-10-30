import wollok.game.*
import ingredientes.*
import chefYSusRecetas.*
import devorador.*
import jugador.*
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
		const devorador = new Devorador()
		devorador.molestar()
		
		
		/*****Aprediz de Chef (jugador)*****/
		game.addVisual(aprendizDeChef)
		game.addVisual(bandeja)
		game.addVisual(mensajeAprendiz)
		
		keyboard.up().onPressDo( {aprendizDeChef.moverseHaciaArriba() } )
		keyboard.down().onPressDo( {aprendizDeChef.moverseHaciaAbajo() } )
		keyboard.left().onPressDo( {aprendizDeChef.moverseHaciaIzquierda() } )
		keyboard.right().onPressDo( {aprendizDeChef.moverseHaciaDerecha() } )
		
		game.say(mensajeAprendiz,"Fijate bien lo que agarrás...")
		
		game.whenCollideDo(bandeja, {unidad => 
			unidad.atrapado()
			game.removeVisual(unidad)
		})
		game.whenCollideDo(aprendizDeChef, {unDevorador =>
			aprendizDeChef.position(aprendizDeChef.position().right(2))
			unDevorador.devorar()})
		
		/*****Ingredientes*****/
		game.onTick(2500, "Lluvia de Ingredientes", {
			proveedor.tirarUnidad()
		})
		
		keyboard.c().onPressDo{self.armarCupCakes()}
	}
	
	method armarCupCakes(){
		self.tableroBase()
		game.addVisual(new Visual(image ="FondoArmado.png"))
		
		/*****Seleccionador*****/
		seleccionador.position(game.at(14,4))
		game.addVisual(seleccionador)
		const instruccion= new Visual(image="PresioneEspacio.png", position=game.at(15,13))
		game.addVisual(instruccion)
		game.schedule(5000,{game.removeVisual(instruccion)})
		keyboard.left().onPressDo({seleccionador.moverseHaciaIzquierda()})		
		keyboard.right().onPressDo({seleccionador.moverseHaciaDerecha()})
		keyboard.space().onPressDo{seleccionador.seleccionar()}
		
		estacionDeArmado.hacerUnCupCake()
		
	}
	
	method gameOver(){
		self.tableroBase()
		game.addVisual(new Visual(image = "FondoGameOver.png"))

		const estrellasObtenidas = aprendizDeChef.puntaje().div(100)
		
		estrellasObtenidas.times{i => 
			const posiciones = [new Position(x = 21, y = 24), new Position(x = 45, y = 24), new Position(x = 33, y = 28)]
			const unaPosicion = posiciones.get(i-1)
			game.addVisual(new Visual(image = "Estrella.png", position = unaPosicion))
		}	

		keyboard.enter().onPressDo{game.stop()}
	}

	method avisarFinDeCaceria(){
		game.schedule(8000,{
				game.addVisual(new Visual(image = "Instruccion.png",position=game.at(50,2)))
				game.say(mensajeAprendiz,"Listos para armar CupCakes!")
		})
	}
}

