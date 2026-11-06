"
I am a field of the valley. I hold water or I am dry, and a few of us have a name so that people can find us.

## Responsibility:

- I know whether I have water, and whether I am the spring, which always has water.
- I know my name, if I have one.
- I show fresh green when I have water, the color of wheat when I am dry, and clear blue when I am the spring.

## Collaborators:

- `VAValleyModel`: creates me, names me and waters me.
- `VACanal` and `VAFootpath`: the links that join me to other fields.

## Public API and Key Messages

- `hasWater`, `water`, `name`.

```
(VAValleyModel exampleValley field: 'A') hasWater
```
"
Class {
	#name : 'VAField',
	#superclass : 'CMCell',
	#instVars : [
		'name',
		'hasWater',
		'isSpring'
	],
	#category : 'Valley-Model',
	#package : 'Valley-Model'
}

{ #category : 'actions' }
VAField >> beSpring [
	"I am the spring: water rises here, so I always have water."

	isSpring := true.
	hasWater := true
]

{ #category : 'accessing' }
VAField >> hasWater [

	^ hasWater
]

{ #category : 'initialization' }
VAField >> initialize [

	super initialize.
	hasWater := false.
	isSpring := false
]

{ #category : 'accessing' }
VAField >> isSpring [

	^ isSpring
]

{ #category : 'accessing' }
VAField >> name [

	^ name
]

{ #category : 'accessing' }
VAField >> name: aString [

	name := aString
]

{ #category : 'pov' }
VAField >> pov [
	"A clear blue spring, fresh green fields with water, and soft wheat fields that are dry."

	<pov>
	^ (CMPointOfView color: (Color fromHexString: (isSpring
						     ifTrue: [ '4FA3D9' ]
						     ifFalse: [
								     hasWater
									     ifTrue: [ 'A3CF7E' ]
									     ifFalse: [ 'EFE3C4' ] ])))
		  borderWidth: 0;
		  yourself
]

{ #category : 'actions' }
VAField >> water [
	"Water reaches me, and I keep it."

	hasWater := true
]
