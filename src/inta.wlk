import plantas.*
import parcelas.*


object inta {
	
	var property coleDeParcelas = #{}
	method promedioDePlantasPorParcela(){
		return self.sumaDePlantasEnCadaParcela()/ coleDeParcelas.size()
	}
	
	method sumaDePlantasEnCadaParcela(){
		return coleDeParcelas.sum({parce => parce.cantidadDePlantas()})
	}
	
	method parcelaMasAutosuficiente(){
		return self.parceConMasDe4Plantas().max({parce => parce.porcentajeDePlantasBienAsociadas()})
	}
	
	method parceConMasDe4Plantas(){
		return coleDeParcelas.filter({parce => parce.cantidadDePlantas()>4})
	}
	
}
