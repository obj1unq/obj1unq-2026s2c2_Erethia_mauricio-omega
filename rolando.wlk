object rolando {
    const mochila = mochilaDeAlmacenamiento

    method verMochila() = mochila.artefactosDentro()
    
    method encontrarArtefacto(artefacto) {
        if(self.puedeRecolectarArt()){
            mochila.guardar(artefacto)
        }
    }


    method puedeRecolectarArt() = mochila.artefactosDentro().size() < mochila.capacidadDeMochila()
}

object mochilaDeAlmacenamiento{
    const artefactosDentro = []
    var capacidadDeMochila = 2

    method artefactosDentro() = artefactosDentro

    method capacidadDeMochila() = capacidadDeMochila 
    method capacidadDeMochila(_capacidadDeMochila) {capacidadDeMochila = _capacidadDeMochila }

    method  guardar(artefactoAGuardar) {
        artefactosDentro.add(artefactoAGuardar)
    }
}

object espadaDelDestino {
  
}

object libroDeHechizo {
  
}

object collarDivino {
  
}

object armaduraDeAceroValyrio {
  
}