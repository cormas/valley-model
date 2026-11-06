"
I am the trust of one farmer in another. I am directed: my `from` farmer trusts my `to` farmer, which does not mean that the trust is returned.

## Responsibility:

- I join two farmers, from the one who trusts to the one who is trusted.
- I show as a thin purple line with an arrowhead.

## Collaborators:

- `VAFarmer`: my two ends.

## Public API and Key Messages

- `from` trusts `to`.

```
(VAValleyModel exampleValley farmer: 'Ben') nextEntitiesLinkedBy: VATrust
```
"
Class {
	#name : 'VATrust',
	#superclass : 'CMLink',
	#category : 'Valley-Model',
	#package : 'Valley-Model'
}

{ #category : 'pov' }
VATrust >> pov [

	<pov>
	^ CMPointOfView color: (Color fromHexString: '8E44AD') size: 0.05
]
