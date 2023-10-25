import wollok.game.*
import ingredientes.*
import ingredientesInstanciados.*
import estacionDeArmado.*
import partida.*


object chef inherits Visual(image="Chef.png",position=game.at(50,26)){
	
	const property recetas=[]
	
	method crearReceta(abscisa,ordenada){
		const receta = new Receta(position=game.at(abscisa,ordenada))
		recetas.add(receta)
		game.addVisual(receta)
		receta.mostrarReceta()
	}
		method puntuarCupCake(){
		game.addVisual(self)
		game.addVisual(mensajeChef)
		game.say(mensajeChef,"Tu puntaje: "+self.calcularPuntaje())
		game.schedule(2500,{
			game.addVisual(new Visual(image="PresioneEnter.png",position=game.at(23,13)))
		})
		keyboard.enter().onPressDo{partida.armarCupCakes()}
		
	}
	
	method calcularPuntaje(){
		const cupCake=estacionDeArmado.cupCake()
		const receta = estacionDeArmado.recetaAsignada()
		const coincidencias= cupCake.count{ingrediente=>receta.ingredientes().contains(ingrediente)
		}
		const mohoso = cupCake.any{ingrediente=>ingrediente.conMoho()}
		
		var puntaje = coincidencias*25
		if(mohoso)puntaje-=12
		
		return puntaje
		
	}
		
}
object mensajeChef{
	method position() = chef.position().up(1).right(7)
}
//////////////////////////////////////////////////////////////////////
	
class Receta inherits Visual(image="CuadernoRecetas.png"){
	
	//Ingredientes receta/////////////////////////////////////////////
	const property sabor = ingredientesCapa1.anyOne()
	const property cremita = ingredientesCapa2.anyOne()
	const property cobertura = ingredientesCapa3.anyOne()
	const property decoracion = ingredientesCapa4.anyOne()
	
	const property ingredientes =[sabor,cremita,cobertura,decoracion]
	//////////////////////////////////////////////////////////////////
	var imagenes=[]
	
	method posicionIngrediente(n){
		const abscisaReceta = position.x()
		const ordenadaReceta = position.y()
		return new Position(x = abscisaReceta+12, y = ordenadaReceta+n)
	}
	method mostrarReceta(){
		
		const imagenSabor = new Visual(image=sabor.id(),position=self.posicionIngrediente(4))
		const imagenCremita=new Visual(image=cremita.id(),position=self.posicionIngrediente(8))
		const imagenCobertura=new Visual(image=cobertura.id(),position=self.posicionIngrediente(12))
		const imagenDecoracion=new Visual(image=decoracion.id(),position=self.posicionIngrediente(16))
		imagenes=[imagenSabor, imagenCremita, imagenCobertura, imagenDecoracion]
		
		imagenes.forEach{imagen=>game.addVisual(imagen)}
	}
	
	method removerReceta(){
		imagenes.forEach{imagen=>game.removeVisual(imagen)}
	}
}
