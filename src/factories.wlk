import wollok.game.*



class Visual {
	const property image
	var property position 
}

class Fondo inherits Visual(position=game.origin()){}


//aca va todo lo necesario para que el cocinero no se mueva mas alla del piso
