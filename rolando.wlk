object rolando {
    const mochila = mochilaDeAlmacenamiento
	const hogar = castilloDePiedra
	const historialEncuentrosArtefactos = []
	var poder = 5
	const enemigos = [caterina, archibaldo, astra]
    
	method configurarCapacidadMochila(nuevoTamaño){
		mochila.capacidadDeMochila(nuevoTamaño)
	}
    method verMochila() = mochila.artefactosDentro()
	
	method historialEncuentrosArtefactos() = historialEncuentrosArtefactos
	
	method poder() = poder
	method poder(_poder) {poder = _poder}
	
	method llegoASuHogar(){
		hogar.guardarEnCastillo(mochila.artefactosDentro())
		mochila.artefactosDentro().clear()
	}
	
    method encontrarArtefacto(artefacto) {
		historialEncuentrosArtefactos.add(artefacto)
		
        if(self.puedeRecolectarArt()){
            mochila.guardar(artefacto)
        }
    }
	
	method lucharUnaBatalla(){
		poder += 1
		mochila.artefactosDentro().forEach({elemento => elemento.usarloEnBatalla(self)})
	}

    method puedeRecolectarArt() = mochila.artefactosDentro().size() < mochila.capacidadDeMochila()

	method poseeArtefacto(artefacto) = self.posesiones().contains(artefacto)
	method posesiones() = hogar.artefactosGuardados() + mochila.artefactosDentro()
	
	method poderDePelea() = poder + mochila.artefactosDentro().sum({elemento => elemento.poderEnBatalla(self)})
	
	method artefactosEnHogar() = hogar.artefactosGuardados()
	method poderArtefactoMasPoderosoEnMorada() = hogar.poderDelArtefactoMasPoderoso(self)

	method moradasQuePuedeConquistar() = self.enemigoQuePuedeVencer().map({enemigo => enemigo.morada()})
	method enemigoQuePuedeVencer() = enemigos.filter({enemigo => enemigo.poderDeBatalla() < self.poderDePelea()})
	
	method esPoderoso() = self.enemigoQuePuedeVencer() == enemigos
	
	method obtenerArtefactoFatalParaEnemigo(enemigo){
		return mochila.artefactosDentro().find({artefacto => artefacto.poderEnBatalla(self) > enemigo.poderDeBatalla()})
	}
	method poseeArtefactoFatalParaEnemigo(enemigo){
		return mochila.artefactosDentro().any({artefacto => artefacto.poderEnBatalla(self) > enemigo.poderDeBatalla()})
	}
}

object mochilaDeAlmacenamiento{	
    const artefactosDentro = #{}
    var capacidadDeMochila = 2

    method artefactosDentro() = artefactosDentro

    method capacidadDeMochila() = capacidadDeMochila 
    method capacidadDeMochila(_capacidadDeMochila) {capacidadDeMochila = _capacidadDeMochila }

    method  guardar(artefactoAGuardar) {
        artefactosDentro.add(artefactoAGuardar)
    }
}

object espadaDelDestino {
	var vecesUsada = 0

    method  usarloEnBatalla(personaje) {
		vecesUsada += 1
    }
	
	method poderEnBatalla(personaje) = if(vecesUsada == 0) {personaje.poder()}
							else{personaje.poder() / 2}
}

object collarDivino {
	var vecesUsada = 0
	const poderAportado = 3

    method  usarloEnBatalla(personaje) {
		vecesUsada += 1
    }
	
	method poderEnBatalla(personaje) = if(personaje.poder() > 6) {poderAportado + vecesUsada}
							else {poderAportado}
}

object armaduraDeAceroValyrio {
	const poderAportado = 6

    method  usarloEnBatalla(personaje) {
    }
	
	method poderEnBatalla(personaje) = poderAportado
}

object libroDeHechizo {
	const hechizos = []
	
	method agregarHechizo(hechizoAAgregar){
		hechizos.add(hechizoAAgregar)
	}

	method  usarloEnBatalla(personaje) {
		if(!hechizos.isEmpty()){
			hechizos.remove(hechizos.first())
		}
    }
	method poderEnBatalla(personaje) = if(!hechizos.isEmpty()) {hechizos.first().poder(personaje)} else {0}
}

//Ejercicio 1.2: Castillo de piedra
object castilloDePiedra{
	const artefactosGuardados = []
	
	method artefactosGuardados() = artefactosGuardados
	
	method guardarEnCastillo(artefactos){
		artefactosGuardados.addAll(artefactos)
	}

    method poderDelArtefactoMasPoderoso(personaje) = if(artefactosGuardados.isEmpty()){0} else{self.artefactoMasPoderoso(personaje)}

    method artefactoMasPoderoso(personaje) =  artefactosGuardados.map({artefacto => artefacto.poderEnBatalla(personaje)}).max() 
}



//Hechizos
object bendicion{
	const poderQueAporta = 4
	
	method poder(personaje) = poderQueAporta
}

object invisibilidad{
	method poder(personaje) = personaje.poder()
}

object invocacion{
	method poder(personaje) = personaje.poderArtefactoMasPoderosoEnMorada()
	
}


object caterina{
	const poderDeBatalla = 28
	const morada = fortalezaDeAcero
	
	method poderDeBatalla() = poderDeBatalla
	
	method morada() = morada
}

object archibaldo {
	const poderDeBatalla = 16
	const morada = palacioDeMarmol
	
	method poderDeBatalla() = poderDeBatalla
	
	method morada() = morada
}

object astra{
	const poderDeBatalla = 14
	const morada = torreDeMarfil
	
	method poderDeBatalla() = poderDeBatalla
	
	method morada() = morada
}

object fortalezaDeAcero{}
object palacioDeMarmol {}
object torreDeMarfil{}