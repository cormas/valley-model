"
I am a farmer of the valley, standing on my field. I give water to the farmers who trust me.

## Responsibility:

- I know my name and the field I stand on.
- I know who I trust, through my `VATrust` links.
- I tell whether my field should get water from a farmer I trust.

## Collaborators:

- `VAField`: the field I stand on.
- `VATrust`: links from me to the farmers I trust.

## Public API and Key Messages

- `name`, `trustedFarmers`, `canGetWaterFromTrustedFarmers`.

```
(VAValleyModel exampleValley farmer: 'Ben') trustedFarmers
```
"
Class {
	#name : 'VAFarmer',
	#superclass : 'CMAgent',
	#instVars : [
		'name'
	],
	#category : 'Valley-Model',
	#package : 'Valley-Model'
}

{ #category : 'testing' }
VAFarmer >> canGetWaterFromTrustedFarmers [
	"A farmer I trust shares water with me when their field has water."

	^ self trustedFarmers anySatisfy: [ :farmer | farmer cell hasWater ]
]

{ #category : 'accessing' }
VAFarmer >> name [

	^ name
]

{ #category : 'accessing' }
VAFarmer >> name: aString [

	name := aString
]

{ #category : 'pov' }
VAFarmer >> pov [

	<pov>
	^ CMPointOfView color: (Color fromHexString: '3B2F2F') size: 0.5
]

{ #category : 'accessing' }
VAFarmer >> trustedFarmers [
	"The farmers I trust. Trust goes one way: they may not trust me."

	^ self nextEntitiesLinkedBy: VATrust
]
