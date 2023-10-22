import wollok.game.*
import partida.*
import jugador.*

object devorador{
	var property position = game.at(20,5)
	method image() = "devorador.png"
	
	method moverseRandom(){
	const x = 15.randomUpTo(anchoTablero-25).truncate(0)
    const y = 7.randomUpTo(10).truncate(0)
	position = game.at(x,y)
	}
	
	method devorar() {
		if ( aprendizDeChef.inventario().isEmpty() ) {
		game.say(self, "Pobre de Ingredientes")}
		else {
		aprendizDeChef.perderUnidad()
		game.say(self, "ñam ñam")
		}
	}
}