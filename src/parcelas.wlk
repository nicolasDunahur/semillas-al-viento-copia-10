import plantas.*
import parcelas.*

class Parcela {
	var property ancho
	var property largo
	var property horasDeSolQueRecibeDia	
	var property plantasQueTiene = #{}	
	
	method superficie(){
		return self.ancho() * self.largo()
	}
	
	method cantMaximaDePlantasQueTolera(){
		if (self.ancho()>self.largo()){
			return self.superficie()/5
		}else {
			return 3 + self.largo()
		}
	}
	
	method tieneComplicaciones(){
		plantasQueTiene.any({ 
			planta => planta.horasDeSolTolera()< self.horasDeSolQueRecibeDia()
		})
	}
	
	
	method recibeMasSolQueLoqueToleraUnaPlanta(unaPlanta){
		return self.horasDeSolQueRecibeDia()+2 > unaPlanta.horasDeSolTolera()
	}
	
	method superaLaCantidadMaxima(){
		return self.cantMaximaDePlantasQueTolera() < plantasQueTiene.size()+1
	}
	
	method plantar(unaPlanta){
		if ( self.superaLaCantidadMaxima()
			or self.recibeMasSolQueLoqueToleraUnaPlanta(unaPlanta)){
			
			self.error("supera la cantidad máxima o bien si la parcela recibe al menos 2 horas más ")
		}else{
			plantasQueTiene.add(unaPlanta)
		}
	}
	method cantidadDePlantas(){
		return plantasQueTiene().size()
		
	}
	
	method porcentajeDePlantasBienAsociadas(){
		return self.cantMaximaDePlantasQueTolera() / self.cantidadDePlantas()
	}
	method cantDePlantasBienAsociadas(){
		return plantasQueTiene.filter({planta => self.seAsociaBien(planta)}).size()
	}
}

class Ecologica inherits Parcela {
	method seAsociaBien(unaPlanta){
		return not self.tieneComplicaciones() and unaPlanta.esIdealLaParcela(self)
	}
	
}
class Industrial inherits Parcela {
	method seAsociaBien(unaPlanta){
		return self.cantidadDePlantas() >=2 and unaPlanta.esFuerte()
	}
}
