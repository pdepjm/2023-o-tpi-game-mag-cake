import wollok.game.*

class Visual {
	const property image
	var property position = game.origin()
}
/////// PARA LOS INGREDIENTES ///////////////////////////////////////////////////////////////////////////////////////////////////

class Ingrediente{
	const nombre
	const property capa
	var property conMoho = false
	
	method id()=capa + nombre + ".png"
	method idSinStock() = "SinStock" + self.id()
	method idBoton() = "Opcion" + self.id()
	method idCupCake() = "Armado" + self.id()		
}


class IngredienteCapa1 inherits Ingrediente(capa="1"){
	override method idSinStock()= "SinStockSabor.png"
}

class IngredienteCapa2 inherits Ingrediente(capa="2"){
	override method idCupCake() {
		if (conMoho)return "Moho"+ super()
		else return super()
	}
	
	override method idSinStock()= "SinStockCrema.png"
	
	method contaminarse(){conMoho=true}
}
class IngredienteCapa3 inherits Ingrediente(capa="3"){}
class IngredienteCapa4 inherits Ingrediente(capa="4"){}


/////// PARA LA LLUVIA DE INGREDIENTES //////////////////////////////////////////////////////////////////////////////////////////

class Unidad{ 
	const property ingredienteRepresentado
	const tieneMoho = false
	var property position = new Position(x = self.asignarRandom() , y = 45)
	
	var estaAtrapado = false
	
			
	method asignarRandom(){
		const list = [10,16,22,28,34,40,46,52,58]
		return list.anyOne()
	}
	method tieneMoho() = tieneMoho
	method image(){
		if(tieneMoho) return "Moho" + ingredienteRepresentado.id()
		else return ingredienteRepresentado.id()
	}
	method atrapado(){
		estaAtrapado=true
	}
	
	method caer(){ 
		game.onTick(200,"caida", {
			position=position.down(1)
			if(position.y()== 9 && !estaAtrapado){
				game.removeVisual(self) 
			} 
		})
	}
}

