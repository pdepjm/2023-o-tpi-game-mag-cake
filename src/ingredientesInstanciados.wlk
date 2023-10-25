import wollok.game.*
import ingredientes.*

//////////// INGREDIENTES ///////////////////////////////////////////////////////////////////////////////////////////

	const saborChocolate = new IngredienteCapa1 (nombre = "Chocolate")
	const saborMarmolado = new IngredienteCapa1 (nombre = "Marmolado")
	const saborVainilla = new IngredienteCapa1 (nombre = "Vainilla")
	const saborFrutilla = new IngredienteCapa1 (nombre = "Frutilla")
	const saborRedVelvet = new IngredienteCapa1 (nombre = "RedVelvet")

	const ingredientesCapa1= [saborChocolate, saborMarmolado, saborVainilla, saborFrutilla, saborRedVelvet] 
	

	const cremaArandano = new IngredienteCapa2 (nombre = "Arandano")
	const cremaChocolate = new IngredienteCapa2 (nombre = "Chocolate")
	const cremaFrutilla = new IngredienteCapa2 (nombre = "Frutilla")
	const cremaVainilla = new IngredienteCapa2 (nombre = "Vainilla")
	const crema = new IngredienteCapa2 (nombre = "Crema")
	
	const ingredientesCapa2= [cremaArandano, cremaChocolate, cremaFrutilla, cremaVainilla, crema]
	
	
	const glaseadoChoco = new IngredienteCapa3 (nombre = "GlaseadoChoco")
	const glaseadoMixto = new IngredienteCapa3 (nombre = "GlaseadoMixto")
	const bolitas = new IngredienteCapa3(nombre = "Bolitas")
	const granas = new IngredienteCapa3 (nombre = "Granas")
	const salsa = new IngredienteCapa3 (nombre = "Salsa")
	
	const ingredientesCapa3= [glaseadoChoco, glaseadoMixto, bolitas, granas, salsa] 


	const cereza = new IngredienteCapa4 (nombre = "Cereza")
	const frutilla = new IngredienteCapa4 (nombre = "Frutilla")
	const naranja = new IngredienteCapa4 (nombre = "Naranja")
	const chocolate = new IngredienteCapa4 (nombre = "Chocolate")
	const arandano = new IngredienteCapa4 (nombre = "Arandano")
	
	const ingredientesCapa4= [cereza, frutilla, naranja, chocolate, arandano] 


const todosLosIngredientes = ingredientesCapa1 + ingredientesCapa2 + ingredientesCapa3 + ingredientesCapa4 

// ! las 4 listas de cada categoria se pueden obtener de todosLosIngredientes si  se ponen los objetos de una ahi
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

