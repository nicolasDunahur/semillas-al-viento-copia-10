import parcelas.*

class Planta {
	var property anioDeObtencion
	var property altura
	var property horasDeSolTolera = 7
	var property espacioQueOcupa
	
	method  daNuevasSemillas() {return self.esFuerte()}
	method esFuerte() { return self.horasDeSolTolera() > 9}
}

class Menta inherits Planta {
	override method espacioQueOcupa(){
		return self.altura()*3
	}
	override method daNuevasSemillas() {
		return (super() or self.espacioQueOcupa()>1)
	}
	method esIdealLaParcela(unaParcela){
		return unaParcela.superficie() > 6
	}
}

class Hierbabuena inherits Menta {
	override method espacioQueOcupa(){
		return super()*2
}

class Soja inherits Planta {
	override method horasDeSolTolera() {
		if (self.altura() < 0.5){
			return 6
		} else if (self.altura().between(0.5,1)){
			return 8
		}else{
			return 12
		}
	}
	override method daNuevasSemillas() {
		return super() or self.altura().between(0.75,0.9)
	}
	override method espacioQueOcupa(){
		return self.altura()/2
	}
	method esIdealLaParcela(unaParcela){
		return unaParcela.horasDeSolQueRecibeDia() == self.horasDeSolTolera()
	}
}

class Transgenica inherits Soja {
	override method daNuevasSemillas() {return false}
	override method esIdealLaParcela(unaParcela){
		return unaParcela.cantidadMaximaDePlantasQueTolera() == 1}
}

class Quinoa inherits Planta {
	override method daNuevasSemillas() {
		return super() or self.anioDeObtencion() < 2005
	}
	override method horasDeSolTolera() {
		if (self.espacioQueOcupa() < 0.3){
			return 10
		} else{
			return super()
		}
	}
	method esIdealLaParcela(unaParcela){
		return unaParcela.any({plantas => plantas.altura() > 1.5}) 
	}
}