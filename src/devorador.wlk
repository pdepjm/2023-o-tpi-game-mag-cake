import wollok.game.*
import partida.*
import jugador.*

//-----------------------------------------------------------------------------------------------------------------------------------

class Devorador{
	var position = game.at(20,5)
	method position() = position
	method image() = "devorador.png"
	
	method moverseRandom(){
		const x = 5.randomUpTo(30).truncate(0) *2 
    	const y = 7.randomUpTo(10).truncate(0)
		position = game.at(x,y)
	}
	method molestar(){
		game.addVisual(self)
		
		game.onTick(4000,"movimiento", {
		self.moverseRandom()
		})
	}
	
	method devorar() {
		if ( aprendizDeChef.inventario().isEmpty() ) {
			game.say(self, "Pobre de Ingredientes")}
		else {
			aprendizDeChef.perderUnidad()
			game.say(self, "ñam ñam")
			game.sound("niamniam.mp3").play()
		}
	}
}