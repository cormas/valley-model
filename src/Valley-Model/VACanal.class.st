"
I am an irrigation canal between two fields. Water flows through me in one direction only, from my `from` field to my `to` field.

## Responsibility:

- I carry water one way: I am a directed link.
- I know whether water is flowing through me at this moment.
- I show as a blue line, and my second point of view makes me wide when water flows through me.

## Collaborators:

- `VAField`: my two ends.

## Public API and Key Messages

- `isFlowing`, and the points of view `pov` and `povWater`.

```
VAValleyModel exampleValley links
```
"
Class {
	#name : 'VACanal',
	#superclass : 'CMLink',
	#category : 'Valley-Model',
	#package : 'Valley-Model'
}

{ #category : 'testing' }
VACanal >> isFlowing [
	"Water flows through me when my upstream field has water."

	^ self from hasWater
]

{ #category : 'pov' }
VACanal >> pov [

	<pov>
	^ CMPointOfView color: (Color fromHexString: '1F5FBF') size: 0.15
]

{ #category : 'pov' }
VACanal >> povWater [
	"Wide and blue when water flows through me, thin and grey when I am dry."

	<pov>
	self isFlowing ifTrue: [
		^ CMPointOfView color: (Color fromHexString: '1F5FBF') size: 0.4 ].
	^ CMPointOfView color: (Color fromHexString: '9A9A9A') size: 0.08
]
