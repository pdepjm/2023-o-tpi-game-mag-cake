import wollok.game.*
import factories.*
import ingredientes.*


class Receta inherits Visual(image="CuadernoRecetas.png"){
	
	//Ingredientes receta/////////////////////////////////
	const property capa1 = ingredientesCapa1.anyOne()
	const property capa2 = ingredientesCapa2.anyOne()
	const property capa3 = ingredientesCapa3.anyOne()
	const property capa4 = ingredientesCapa4.anyOne()
	
	const property ingredientes =[capa1,capa2,capa3,capa4]
	///////////////////////////////////////////////////////
	
	method mostrarReceta(){
		
		game.addVisual(new Visual(image=capa1,position=self.posicionIngrediente(4)))
		game.addVisual(new Visual(image=capa2,position=self.posicionIngrediente(8)))
		game.addVisual(new Visual(image=capa3,position=self.posicionIngrediente(12)))
		game.addVisual(new Visual(image=capa4,position=self.posicionIngrediente(16)))
			
	}
	
	method posicionIngrediente(n){
		const abscisaReceta = position.x()
		const ordenadaReceta = position.y()
		return new Position(x = abscisaReceta+12, y = ordenadaReceta+n)
	}
}


