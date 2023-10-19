import wollok.game.*
import factories.*
import receta.*
import personajes.*
import ingredientes.*

const anchoTablero = 75
const altoTablero = 50
//const altoPiso = 10


object partida{
	
	////////////////// DIMENSIONES TABLERO ///////////////////
	
	method tableroBase(){
		game.cellSize(20)
		game.width(anchoTablero)
		game.height(altoTablero)
	}
	
	////////////////////////// INTRO /////////////////////////
	
	method iniciar(){
		
		game.clear()
		game.title("Operacion CupCakes")
		self.tableroBase()
		game.boardGround("PantallaInicio.png")	
		keyboard.enter().onPressDo{self.revelarRecetas()}
	}
	
	
	////////////////////// PRIMERA PARTE //////////////////////
	
	method revelarRecetas(){
		
		game.clear()
		self.tableroBase()
		game.addVisual(new Fondo(image ="FondoBase.png"))
		chef.crearReceta(5,19)
		chef.crearReceta(29,19)
		chef.crearReceta(53,19)
		keyboard.enter().onPressDo{self.caceriaSalvaje()}

	}
	
	
	////////////////////// SEGUNDA PARTE //////////////////////
	
	method caceriaSalvaje(){
		
		game.clear()
		self.tableroBase()
		game.addVisual(new Fondo(image ="FondoCaida.png"))
		
		/*****Ingredientes*****/
		proveedor.tirarIngrediente()// para que haya un primer ingrediente cayendo
		
		game.onTick(4500, "Lluvia de Ingredientes", {
			proveedor.tirarIngrediente()
		})
		
		/*****Chef*****/
		keyboard.up().onPressDo( { chef.moverseHaciaArriba() } )
		keyboard.down().onPressDo( { chef.moverseHaciaAbajo() } )
		keyboard.left().onPressDo( { chef.moverseHaciaIzquierda() } )
		keyboard.right().onPressDo( { chef.moverseHaciaDerecha() } )
		
		//game.addVisualCharacter(chef)
		game.addVisual(chef)
		game.addVisual(bandeja)
		game.addVisual(mensajeChef)
		
		game.say(mensajeChef,"Cuidado con los mohosos")
		
		game.whenCollideDo(bandeja, {ingrediente => 
			chef.capturarIngrediente(ingrediente)
			game.removeVisual(ingrediente) 
			
		})
		
		/*****Devorador*****/
		game.addVisual(devorador)
		
		game.onTick(4000,"movimiento", {
		devorador.moverseRandom()
		})
		
		game.whenCollideDo(devorador, {personaje =>
			personaje.position(personaje.position().right(3))
			devorador.devorar()
		})
		
	}
	
	
	}

