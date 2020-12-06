!classDefinition: #MarsRoverTests category: 'MarsRover-Ejercicio'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: 'north south east west'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!MarsRoverTests methodsFor: 'setUp/tearDown' stamp: 'MS 12/5/2020 19:37:40'!
setUp

	north := North new.
	south := South new.
	east := East new.
	west := West new.! !


!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:09:06'!
test01ThePositionAndTheDirectionOfAMarsRoverCanBeVerified

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: north.
	
	self assert: (marsRover currentPosition) equals: 0@0.
	self assert: (marsRover isFacing: north).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:09:44'!
test02AMarsRoverFacingNorthCanMoveForward

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: north.
	
	marsRover executeCommand: 'f'.
	
	self assert: (marsRover currentPosition) equals: 0@-1.
	self assert: (marsRover isFacing: north).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:10:14'!
test03AMarsRoverFacingNorthCanMoveBackwards

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: north.
	
	marsRover executeCommand: 'b'.
	
	self assert: (marsRover currentPosition) equals: 0@1.
	self assert: (marsRover isFacing: north).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:10:32'!
test04AMarsRoverFacingNorthCanMoveTurnLeft

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: north.
	
	marsRover executeCommand: 'l'.
	
	self assert: (marsRover currentPosition) equals: 0@0.
	self assert: (marsRover isFacing: west).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:10:52'!
test05AMarsRoverFacingNorthCanTurnRight

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: north.
	
	marsRover executeCommand: 'r'.
	
	self assert: (marsRover currentPosition) equals: 0@0.
	self assert: (marsRover isFacing: east).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:11:21'!
test06AMarsRoverFacingSouthCanMoveForward

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: south.
	
	marsRover executeCommand: 'f'.
	
	self assert: (marsRover currentPosition) equals: 0@1.
	self assert: (marsRover isFacing: south).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:11:37'!
test07AMarsRoverFacingSouthCanMoveBackwards

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: south.
	
	marsRover executeCommand: 'b'.
	
	self assert: (marsRover currentPosition) equals: 0@-1.
	self assert: (marsRover isFacing: south).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:11:59'!
test08AMarsRoverFacingSouthCanTurnLeft

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: south.
	
	marsRover executeCommand: 'l'.
	
	self assert: (marsRover currentPosition) equals: 0@0.
	self assert: (marsRover isFacing: east).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:12:20'!
test09AMarsRoverFacingSouthCanTurnRight

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: south.
	
	marsRover executeCommand: 'r'.
	
	self assert: (marsRover currentPosition) equals: 0@0.
	self assert: (marsRover isFacing: west).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:12:49'!
test10AMarsRoverFacingEastCanMoveForward

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: east.
	
	marsRover executeCommand: 'f'.
	
	self assert: (marsRover currentPosition) equals: 1@0.
	self assert: (marsRover isFacing: east).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:13:03'!
test11AMarsRoverFacingEastCanMoveBackwards

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: east.
	
	marsRover executeCommand: 'b'.
	
	self assert: (marsRover currentPosition) equals: -1@0.
	self assert: (marsRover isFacing: east).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:13:27'!
test12AMarsRoverFacingEastCanTurnLeft

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: east.
	
	marsRover executeCommand: 'l'.
	
	self assert: (marsRover currentPosition) equals: 0@0.
	self assert: (marsRover isFacing: north).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:13:56'!
test13AMarsRoverFacingEastCanTurnRight

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: east.
	
	marsRover executeCommand: 'r'.
	
	self assert: (marsRover currentPosition) equals: 0@0.
	self assert: (marsRover isFacing: south).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:14:14'!
test14AMarsRoverFacingWestCanMoveForward

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: west.
	
	marsRover executeCommand: 'f'.
	
	self assert: (marsRover currentPosition) equals: -1@0.
	self assert: (marsRover isFacing: west).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:14:27'!
test15AMarsRoverFacingWestCanMoveBackwards

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: west.
	
	marsRover executeCommand: 'b'.
	
	self assert: (marsRover currentPosition) equals: 1@0.
	self assert: (marsRover isFacing: west).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:14:49'!
test16AMarsRoverFacingWestCanTurnLeft

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: west.
	
	marsRover executeCommand: 'l'.
	
	self assert: (marsRover currentPosition) equals: 0@0.
	self assert: (marsRover isFacing: south).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:15:09'!
test17AMarsRoverFacingWestCanTurnRight

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: west.
	
	marsRover executeCommand: 'r'.
	
	self assert: (marsRover currentPosition) equals: 0@0.
	self assert: (marsRover isFacing: north).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:15:33'!
test18AMarsRoverCanExecuteMultipleCommands

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: north.
	
	marsRover executeCommand: 'frflbrf'.
	
	self assert: (marsRover currentPosition) equals: 2@0.
	self assert: (marsRover isFacing: east).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'MS 12/6/2020 18:16:02'!
test19AMarsRoverStopsExecutionOnInvalidCommand

	| marsRover |
	marsRover := MarsRover at: 0@0 facing: north.
	
	marsRover executeCommand: 'frflabrf'.
	
	self assert: (marsRover currentPosition) equals: 1@-1.
	self assert: (marsRover isFacing: north).! !


!classDefinition: #CardinalDirections category: 'MarsRover-Ejercicio'!
Object subclass: #CardinalDirections
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!CardinalDirections methodsFor: 'commands' stamp: 'MS 12/5/2020 21:28:04'!
moveBackwards

	self subclassResponsibility.! !

!CardinalDirections methodsFor: 'commands' stamp: 'MS 12/5/2020 21:27:54'!
moveForward

	self subclassResponsibility.! !

!CardinalDirections methodsFor: 'commands' stamp: 'MS 12/5/2020 21:28:16'!
turnLeft

	self subclassResponsibility.! !

!CardinalDirections methodsFor: 'commands' stamp: 'MS 12/5/2020 21:28:22'!
turnRight

	self subclassResponsibility.! !


!classDefinition: #East category: 'MarsRover-Ejercicio'!
CardinalDirections subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!East methodsFor: 'commands' stamp: 'MS 12/5/2020 20:09:21'!
moveBackwards

	^-1@0.! !

!East methodsFor: 'commands' stamp: 'MS 12/5/2020 20:09:39'!
moveForward

	^1@0.! !

!East methodsFor: 'commands' stamp: 'MS 12/5/2020 20:15:07'!
turnLeft

	^North new.! !

!East methodsFor: 'commands' stamp: 'MS 12/5/2020 20:14:58'!
turnRight

	^South new.! !


!classDefinition: #North category: 'MarsRover-Ejercicio'!
CardinalDirections subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!North methodsFor: 'commands' stamp: 'MS 12/5/2020 20:10:13'!
moveBackwards

	^0@1.! !

!North methodsFor: 'commands' stamp: 'MS 12/5/2020 20:10:30'!
moveForward

	^0@-1.! !

!North methodsFor: 'commands' stamp: 'MS 12/5/2020 20:15:38'!
turnLeft

	^West new.! !

!North methodsFor: 'commands' stamp: 'MS 12/5/2020 20:15:49'!
turnRight

	^East new.! !


!classDefinition: #South category: 'MarsRover-Ejercicio'!
CardinalDirections subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!South methodsFor: 'commands' stamp: 'MS 12/5/2020 20:11:17'!
moveBackwards

	^0@-1.! !

!South methodsFor: 'commands' stamp: 'MS 12/5/2020 20:11:07'!
moveForward

	^0@1.! !

!South methodsFor: 'commands' stamp: 'MS 12/5/2020 20:15:58'!
turnLeft

	^East new.! !

!South methodsFor: 'commands' stamp: 'MS 12/5/2020 20:16:09'!
turnRight

	^West new.! !


!classDefinition: #West category: 'MarsRover-Ejercicio'!
CardinalDirections subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!West methodsFor: 'commands' stamp: 'MS 12/5/2020 20:11:42'!
moveBackwards

	^1@0.! !

!West methodsFor: 'commands' stamp: 'MS 12/5/2020 20:11:55'!
moveForward

	^-1@0.! !

!West methodsFor: 'commands' stamp: 'MS 12/5/2020 20:16:24'!
turnLeft

	^South new.! !

!West methodsFor: 'commands' stamp: 'MS 12/5/2020 20:16:40'!
turnRight

	^North new.! !


!classDefinition: #Commands category: 'MarsRover-Ejercicio'!
Object subclass: #Commands
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!Commands methodsFor: 'commands' stamp: 'MS 12/5/2020 21:31:41'!
followCommand: aMarsRover

	self subclassResponsibility.! !


!classDefinition: #Backwards category: 'MarsRover-Ejercicio'!
Commands subclass: #Backwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!Backwards methodsFor: 'commands' stamp: 'MS 12/5/2020 20:47:47'!
followCommand: aMarsRover

	aMarsRover moveBackwards.! !


!classDefinition: #Forward category: 'MarsRover-Ejercicio'!
Commands subclass: #Forward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!Forward methodsFor: 'commands' stamp: 'MS 12/5/2020 20:48:50'!
followCommand: aMarsRover

	aMarsRover moveForward.! !


!classDefinition: #Left category: 'MarsRover-Ejercicio'!
Commands subclass: #Left
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!Left methodsFor: 'commands' stamp: 'MS 12/5/2020 20:49:10'!
followCommand: aMarsRover

	aMarsRover turnLeft.! !


!classDefinition: #Right category: 'MarsRover-Ejercicio'!
Commands subclass: #Right
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!Right methodsFor: 'commands' stamp: 'MS 12/5/2020 20:49:23'!
followCommand: aMarsRover

	aMarsRover turnRight.! !


!classDefinition: #MarsRover category: 'MarsRover-Ejercicio'!
Object subclass: #MarsRover
	instanceVariableNames: 'position cardinalDirection commands'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!MarsRover methodsFor: 'initialization' stamp: 'MS 12/5/2020 20:44:26'!
generateCommandsDictionary

	| aCommandsDictionary |
	aCommandsDictionary := Dictionary new.
	aCommandsDictionary at: #f put: Forward new.
	aCommandsDictionary at: #b put: Backwards new.
	aCommandsDictionary at: #l put: Left new.
	aCommandsDictionary at: #r put: Right new.
	^aCommandsDictionary.! !

!MarsRover methodsFor: 'initialization' stamp: 'MS 12/5/2020 21:36:59'!
initializeAt: aPosition facing: aCardinalDirection 
	
	position := aPosition.
	cardinalDirection := aCardinalDirection.
	commands := self generateCommandsDictionary.! !


!MarsRover methodsFor: 'accessing' stamp: 'MS 12/5/2020 21:33:25'!
currentPosition
	
	^position.! !

!MarsRover methodsFor: 'accessing' stamp: 'MS 12/5/2020 19:45:47'!
isFacing: aCardinalDirection 
	
	^cardinalDirection class = aCardinalDirection class.! !


!MarsRover methodsFor: 'commands' stamp: 'MS 12/6/2020 18:40:57'!
executeCommand: aCommand
 
	aCommand do: [ :aChar |
		(commands at: aChar asSymbol ifAbsent: [ ^false ])
		followCommand: self
	].! !


!MarsRover methodsFor: 'commands - private' stamp: 'MS 12/5/2020 21:33:25'!
moveBackwards

	position := position + cardinalDirection moveBackwards.! !

!MarsRover methodsFor: 'commands - private' stamp: 'MS 12/5/2020 21:33:25'!
moveForward

	position := position + cardinalDirection moveForward.! !

!MarsRover methodsFor: 'commands - private' stamp: 'MS 12/5/2020 20:13:25'!
turnLeft

	cardinalDirection := cardinalDirection turnLeft.! !

!MarsRover methodsFor: 'commands - private' stamp: 'MS 12/5/2020 20:13:43'!
turnRight

	cardinalDirection := cardinalDirection turnRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Ejercicio'!
MarsRover class
	instanceVariableNames: 'commands'!

!MarsRover class methodsFor: 'instance creation' stamp: 'MS 12/5/2020 22:24:57'!
at: aPosition facing: aCardinalDirection 
	
	^self new initializeAt: aPosition facing: aCardinalDirection.! !
