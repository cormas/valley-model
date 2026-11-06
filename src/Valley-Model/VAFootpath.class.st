"
I am a footpath between two fields. People walk along me both ways, so I am not directed. Water never flows along me.

## Responsibility:

- I join two fields, in both directions.
- I show as a thin sandy line, with no arrowhead.

## Collaborators:

- `VAField`: my two ends.

## Public API and Key Messages

- `isDirected` answers false.

```
(VAValleyModel exampleValley field: 'E') entitiesLinkedBy: VAFootpath
```
"
Class {
	#name : 'VAFootpath',
	#superclass : 'CMLink',
	#category : 'Valley-Model',
	#package : 'Valley-Model'
}

{ #category : 'testing' }
VAFootpath >> isDirected [
	"People walk along me both ways."

	^ false
]

{ #category : 'pov' }
VAFootpath >> pov [

	<pov>
	^ CMPointOfView color: (Color fromHexString: '9B7653') size: 0.15
]
