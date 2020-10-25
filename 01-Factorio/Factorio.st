!classDefinition: #CintaAzul category: 'Factorio'!
DenotativeObject subclass: #CintaAzul
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaAzul class' category: 'Factorio'!
CintaAzul class
	instanceVariableNames: 'contenido destino'!

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:01:00'!
agregar: unaMena
	contenido add: unaMena.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:45:39'!
agregarTodo: cargaDeMenas
	contenido addAll: cargaDeMenas.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:08:35'!
cantidadDe: unaMenaDeMuestra
	^contenido count: [:unaMena | unaMena = unaMenaDeMuestra ].! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:09:08'!
cantidadDeMenas
	^contenido size.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 13:59:37'!
conectarA: unDestino 
	destino := unDestino.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:38:38'!
descargar
	destino agregarTodo: contenido.
	self vaciar.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:47:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new)).
	destino := Contenedor.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 13:58:08'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #CintaRoja category: 'Factorio'!
DenotativeObject subclass: #CintaRoja
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaRoja class' category: 'Factorio'!
CintaRoja class
	instanceVariableNames: 'contenido destino'!

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:16:35'!
agregar: unaMena
	contenido add: unaMena.! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:16:35'!
cantidadDe: unaMenaDeMuestra
	^contenido count: [:unaMena | unaMena = unaMenaDeMuestra ].! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:16:35'!
cantidadDeMenas
	^contenido size.! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:16:35'!
conectarA: unDestino 
	destino := unDestino.! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:44:41'!
descargar
	destino agregarTodo: contenido.
	self vaciar.! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:47:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new)).
	destino := CintaAzul.! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:16:35'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #Contenedor category: 'Factorio'!
DenotativeObject subclass: #Contenedor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Contenedor class' category: 'Factorio'!
Contenedor class
	instanceVariableNames: 'contenido'!

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:35:04'!
agregar: unaMena
	contenido add: unaMena.! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:37:50'!
agregarTodo: cargaDeMenas
	contenido addAll: cargaDeMenas.! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:38:00'!
cantidadDe: unaMenaDeMuestra
	^contenido count: [:unaMena | unaMena = unaMenaDeMuestra ].! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:38:20'!
cantidadDeMenas
	^contenido size.! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:47:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new) add: #carbon; add: #hierro; yourself).! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:35:51'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #ExtractorDeCarbon category: 'Factorio'!
DenotativeObject subclass: #ExtractorDeCarbon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeCarbon class' category: 'Factorio'!
ExtractorDeCarbon class
	instanceVariableNames: 'destino'!

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:33:23'!
conectarA: unDestino
	destino := unDestino.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:35:45'!
extraer
	destino agregar: #carbon.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:47:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := CintaAzul.! !


!classDefinition: #ExtractorDeHierro category: 'Factorio'!
DenotativeObject subclass: #ExtractorDeHierro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeHierro class' category: 'Factorio'!
ExtractorDeHierro class
	instanceVariableNames: 'destino'!

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:16:02'!
conectarA: unDestino
	destino := unDestino.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:16:10'!
extraer
	destino agregar: #hierro.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'AA 10/25/2020 14:47:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := CintaRoja.! !


!classDefinition: #FactorioTest category: 'Factorio'!
DenotativeObject subclass: #FactorioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FactorioTest class' category: 'Factorio'!
FactorioTest class
	instanceVariableNames: ''!

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SF 10/23/2020 01:01:45'!
configurarCircuitoExtractorCaja.

	Contenedor vaciar.
	ExtractorDeCarbon conectarA: Contenedor.	
! !

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SF 10/23/2020 00:55:32'!
hacerAndarCircuitoExtractorCaja

	ExtractorDeCarbon extraer.
	! !

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SF 10/23/2020 00:53:55'!
test01ExtractorCaja
	self configurarCircuitoExtractorCaja.
	
	self hacerAndarCircuitoExtractorCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 1.! !


!FactorioTest class methodsFor: 'escenario 2' stamp: 'AA 10/25/2020 13:51:26'!
configurarCircuitoExtractorCintaCaja
	
	"No se olviden de vaciar la cinta tambien!!"
	"Conectamos el extractor a la cinta, luego conectamos la cinta a la caja"
	
	Contenedor vaciar.
	CintaAzul vaciar.
	ExtractorDeCarbon conectarA: CintaAzul.
	CintaAzul conectarA: Contenedor.
! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'AA 10/25/2020 13:53:17'!
hacerAndarCircuitoExtractorCintaCaja

	"Hacemos andar el extractor, asi deja un carbon en la cinta.
	Luego hacemos andar la cinta (con algun mensaje) y deberia dejar el carbon en la caja.	"
	
	ExtractorDeCarbon extraer.
	CintaAzul descargar.! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'AA 10/25/2020 14:10:22'!
test02ExtractorCintaCaja
	self configurarCircuitoExtractorCintaCaja.
	
	self hacerAndarCircuitoExtractorCintaCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 1.
	Assert that: CintaAzul cantidadDeMenas isEqualTo: 0.
	Assert that: (CintaAzul cantidadDe: #carbon) isEqualTo: 0.
	"Tambien tenemos que chequear que en la cinta no haya nada. Cero carbon."! !


!FactorioTest class methodsFor: 'escenario 3' stamp: 'AA 10/25/2020 14:20:20'!
configurarCircuitoExtractorExtractorCintaCintaCaja

	Contenedor vaciar.
	"Además de vaciar el Contenedor (arriba) también vaciamos las dos cintas"
	"Conectamos el extractor de carbon a una de las cintas"
	"Conectamos el extractor de hierro a la otra cinta"
	"Ahora conectamos la primer cinta al Contenedor"
	"Y conectamos la segunda cinta a la primer cinta"
	CintaAzul vaciar.
	CintaRoja vaciar.
	ExtractorDeCarbon conectarA: CintaAzul.
	ExtractorDeHierro conectarA: CintaRoja.	
	CintaAzul conectarA: Contenedor.
	CintaRoja conectarA: CintaAzul.! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'AA 10/25/2020 14:22:40'!
hacerAndarCircuitoExtractorExtractorCintaCintaCaja
	
	"Hacemos andar el extractor, asi deja un carbon en la cinta.
	Lo mismo con el otro extractor, asi deja una mena de hierro en la otra cinta.
	Hacemos andar la cinta con la mena de hierro, asi la deposita en la cinta que tiene el carbon.
	Ahora podemos hacer andar la ultima cinta, la que recibió primero el carbon 
	y ahora tambien tiene el hierro y que deje todo en el Contenedor."
	
	ExtractorDeCarbon extraer.
	ExtractorDeHierro extraer.
	CintaRoja descargar.
	CintaAzul descargar.! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'AA 10/25/2020 14:24:44'!
test03ExtractorExtractorCintaCintaCaja
	self configurarCircuitoExtractorExtractorCintaCintaCaja.
	
	self hacerAndarCircuitoExtractorExtractorCintaCintaCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: (Contenedor cantidadDe: #hierro) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 2.
	Assert that: CintaAzul cantidadDeMenas isEqualTo: 0.
	Assert that: (CintaAzul cantidadDe: #carbon) isEqualTo: 0.
	Assert that: (CintaAzul cantidadDe: #hierro) isEqualTo: 0.
	Assert that: CintaRoja cantidadDeMenas isEqualTo: 0.
	Assert that: (CintaRoja cantidadDe: #hierro) isEqualTo: 0.
	Assert that: (CintaRoja cantidadDe: #carbon) isEqualTo: 0.	! !

CintaAzul initializeAfterFileIn!
CintaRoja initializeAfterFileIn!
Contenedor initializeAfterFileIn!
ExtractorDeCarbon initializeAfterFileIn!
ExtractorDeHierro initializeAfterFileIn!