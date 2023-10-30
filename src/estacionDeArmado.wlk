import wollok.game.*
import partida.*
import chefYSusRecetas.*
import ingredientes.*
import jugador.*

object estacionDeArmado {
	var recetaAsignada
	var cupCake=[] 
	
	method recetaAsignada()= recetaAsignada
	method cupCake()= cupCake
	
	method hacerUnCupCake(){
		
		if(chef.recetas().isEmpty())
			partida.gameOver()
		else{
			cupCake=[] 
			recetaAsignada=chef.recetas().head()
			self.visualizarReceta()
			barraSabores.insertarBotones()
		}
	}
	method visualizarReceta(){
		recetaAsignada.position(game.at(2,25))
		game.addVisual(recetaAsignada)
		recetaAsignada.mostrarReceta()
	}
}
/////// PARA EL ARMADO DEL CUPCAKE /////////////////////////////////////////////////////////////////////////////////////////////

/**********Barra de opciones***************/
class BarraOpciones{
	const opciones
	const botonOperacion 
	
	method insertarBotones(){
		5.times{i=>
	
			const ingrediente = opciones.get(i-1)
			const posicion = new Position(x=14+(i-1)*8, y=4)
			
			const boton = new BotonIngrediente(ingredienteRepresentado=ingrediente)
			game.addVisualIn(boton, posicion)
			
		}

		game.addVisualIn(botonOperacion, game.at(54,4))
	}
}


const barraSabores = new BarraOpciones(opciones = ingredientesCapa1, botonOperacion = botonOp1)
const barraCremas = new BarraOpciones(opciones = ingredientesCapa2, botonOperacion = botonOp2)
const barraCoberturas = new BarraOpciones(opciones = ingredientesCapa3, botonOperacion = botonOp3)
const barraDecorados = new BarraOpciones(opciones = ingredientesCapa4, botonOperacion = botonOp4)

/********** Botones ***************/
class BotonIngrediente{
	const ingredienteRepresentado
	method imagenSinStock()=ingredienteRepresentado.idSinStock()
	
	method hayIngrediente()= aprendizDeChef.inventario().contains(ingredienteRepresentado)
	
	method image(){
		if(self.hayIngrediente()) return ingredienteRepresentado.idBoton()
		else return self.imagenSinStock()
	}
	
	method usarIngrediente(){
		game.addVisual(new Visual(image=ingredienteRepresentado.idCupCake(), position=game.at(24,19)))
		estacionDeArmado.cupCake().add(ingredienteRepresentado)
		aprendizDeChef.inventario().remove(ingredienteRepresentado)
	}
	method presionar(){

		if(self.hayIngrediente()&& !seleccionador.eligio()){
			self.usarIngrediente()
			seleccionador.eligio(true)	
		}
		else
			game.say(self,"No se puede seleccionar")
	}
}

class BotonDeOperacion{
	const barraSiguiente
	
	method image()= "Siguiente.png"
	
	method presionar(){
		barraSiguiente.insertarBotones()
		seleccionador.eligio(false)
		seleccionador.position(game.at(14,4))
	}	
}

class BotonConAutocompletado inherits BotonDeOperacion{
	const capa 
	const opcionFantasma 
	
	method seAgregoIngrediente() = estacionDeArmado.cupCake().any{ingrediente => ingrediente.capa() == capa}
	
	override method presionar(){
		super()
		if(!self.seAgregoIngrediente()) {
			game.addVisual(new Visual(image = opcionFantasma, position = game.at(24,19)))
		}
	}
}

/*Intancias de botones*/
const botonOp1 = new BotonConAutocompletado(barraSiguiente = barraCremas, opcionFantasma="SaborFantasma.png",capa="1")
const botonOp2 = new BotonConAutocompletado(barraSiguiente = barraCoberturas, opcionFantasma="CremaFantasma.png",capa="2")
const botonOp3 = new BotonDeOperacion(barraSiguiente = barraDecorados)
object botonOp4{
	
	method image()="Entregar.png"
	
	method presionar(){
		chef.puntuarCupCake()
		chef.recetas().remove(estacionDeArmado.recetaAsignada())
		estacionDeArmado.recetaAsignada().removerReceta()
		game.removeVisual(estacionDeArmado.recetaAsignada())
		seleccionador.eligio(false)
	}
}
