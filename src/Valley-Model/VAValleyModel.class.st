"
I am a small valley where irrigation canals carry water from a spring to the fields, footpaths join fields both ways, and farmers who trust each other share water. I am the example model of the reference page on links on cormas.org.

## Responsibility:

- I build the valley: a grid of fields, the spring, the canals, the footpaths, three farmers and the trust between them.
- At each step, I let water flow one canal further, and let farmers get water from the farmers they trust.
- I give access to the named fields and farmers, so that the examples of the reference page can find them.

## Collaborators:

- `VAField`: the cells of my grid, some of them named, holding water or not.
- `VAFarmer`: the agents standing on their fields.
- `VACanal`, `VAFootpath` and `VATrust`: the three kinds of links between them.

## Public API and Key Messages

- `initValley`: the init method, which builds the valley.
- `step`: the control method.
- `field:` and `farmer:` answer a field or a farmer by its name.
- `exampleValley` on my class side answers a valley ready to use, and the `script…` methods open it for the screenshots of the reference page.

The valley, as drawn on the reference page:

```
Canals:     Spring → A,  A → B,  A → C,  C → D
Footpaths:  B — E,  E — D
Farmers:    Ana on B,  Ben on E,  Carl on D
Trust:      Ben → Ana,  Ana → Carl,  Carl → Ana
```

```
VAValleyModel scriptOpenSimulation
```

### Implementation Points

- Water moves synchronously: the fields to water are chosen first, then watered, so that water never moves more than one link per step.
"
Class {
	#name : 'VAValleyModel',
	#superclass : 'CMModel',
	#category : 'Valley-Model',
	#package : 'Valley-Model'
}

{ #category : 'accessing' }
VAValleyModel class >> aboutThisModel [

	^ 'A small valley on a 10x10 grid. Irrigation canals carry water one way from a spring to the fields, one canal per step, and footpaths join fields both ways but never carry water. Three farmers stand on their fields, and a farmer gets water from any farmer they trust. It is the example model of the reference page on links on cormas.org.'
]

{ #category : 'examples' }
VAValleyModel class >> exampleValley [

	<sampleInstance>
	^ self valleyAfterSteps: 0
]

{ #category : 'accessing' }
VAValleyModel class >> modelName [

	^ 'Valley'
]

{ #category : 'scripts' }
VAValleyModel class >> scriptOpenSimulation [

	<script>
	^ CMSimulationApplication new
		  cormasModel: self new;
		  start
]

{ #category : 'scripts' }
VAValleyModel class >> scriptPointsOfView [
	"After one step, the canals leaving the spring and A carry water and look wide, and the canal from C to D is still dry and looks thin and grey. Trust is hidden."

	<script>
	| valley |
	valley := self valleyAfterSteps: 1.
	self useDefaultPointsOfView.
	VACanal activePovSelector: #povWater.
	VATrust activePovSelector: #povInvisible.
	^ valley openSpacePresenter
]

{ #category : 'scripts' }
VAValleyModel class >> scriptValley [
	"The valley before any step: fields, the spring, canals with arrowheads, footpaths, farmers and trust."

	<script>
	| valley |
	valley := self valleyAfterSteps: 0.
	self useDefaultPointsOfView.
	^ valley openSpacePresenter
]

{ #category : 'scripts' }
VAValleyModel class >> scriptWaterFlowing [
	"After two steps, water has reached A, B and C, while D and E are still dry."

	<script>
	| valley |
	valley := self valleyAfterSteps: 2.
	self useDefaultPointsOfView.
	^ valley openSpacePresenter
]

{ #category : 'examples' }
VAValleyModel class >> useDefaultPointsOfView [
	"Points of view are chosen per class and kept between simulations, so the scripts start from the same choice."

	{
		VAField.
		VAFarmer.
		VACanal.
		VAFootpath.
		VATrust } do: [ :class | class activePovSelector: #pov ]
]

{ #category : 'examples' }
VAValleyModel class >> valleyAfterSteps: aNumber [
	"A valley initialized with initValley, then run for aNumber steps."

	| model simulation |
	model := self new.
	simulation := CMSimulation for: model.
	simulation
		activeInitSelector: #initValley;
		activeControlSelector: #step;
		initializeSimulation.
	aNumber timesRepeat: [ simulation runStep ].
	^ model
]

{ #category : 'map' }
VAValleyModel >> canalTable [
	"Each canal, from the field the water comes from to the field it goes to."

	^ #( #( 'Spring' 'A' ) #( 'A' 'B' ) #( 'A' 'C' ) #( 'C' 'D' ) )
]

{ #category : 'init' }
VAValleyModel >> createFarmers [

	self farmerTable do: [ :row |
			(self newEntity: VAFarmer locatedAt: (self field: row second))
				name: row first ].
	self trustTable do: [ :pair |
			self
				newEntity: VATrust
				from: (self farmer: pair first)
				to: (self farmer: pair second) ]
]

{ #category : 'init' }
VAValleyModel >> createLinksOfClass: aLinkClass betweenFields: aTable [

	aTable do: [ :pair |
			self
				newEntity: aLinkClass
				from: (self field: pair first)
				to: (self field: pair second) ]
]

{ #category : 'accessing' }
VAValleyModel >> farmer: aName [
	"Answer the farmer with this name. It is an error if there is none."

	^ self @@ VAFarmer detect: [ :farmer | farmer name = aName ]
]

{ #category : 'map' }
VAValleyModel >> farmerTable [
	"Each farmer, and the field they stand on."

	^ #( #( 'Ana' 'B' ) #( 'Ben' 'E' ) #( 'Carl' 'D' ) )
]

{ #category : 'accessing' }
VAValleyModel >> field: aName [
	"Answer the field with this name. It is an error if there is none."

	^ self cells detect: [ :field | field name = aName ]
]

{ #category : 'map' }
VAValleyModel >> fieldTable [
	"The named fields: a name, then the row and the column of the field."

	^ #( #( 'Spring' 2 2 ) #( 'A' 2 5 ) #( 'B' 2 9 ) #( 'C' 6 4 )
	     #( 'D' 9 6 ) #( 'E' 9 9 ) )
]

{ #category : 'map' }
VAValleyModel >> footpathTable [

	^ #( #( 'B' 'E' ) #( 'E' 'D' ) )
]

{ #category : 'init' }
VAValleyModel >> initValley [

	<init>
	self
		createGridNumberOfRows: 10
		numberOfColumns: 10
		neighbourhood: 4
		closed: true.
	self nameFields.
	(self field: 'Spring') beSpring.
	self createLinksOfClass: VACanal betweenFields: self canalTable.
	self createLinksOfClass: VAFootpath betweenFields: self footpathTable.
	self createFarmers
]

{ #category : 'init' }
VAValleyModel >> nameFields [

	self fieldTable do: [ :row |
		(self cellAt: row second at: row third) name: row first ]
]

{ #category : 'control' }
VAValleyModel >> step [
	"Water moves one canal further from every field that has it, and a farmer's field gets water when a farmer they trust has water. All the fields are chosen first and watered after, so water never moves more than one link per step."

	<control>
	| fieldsToWater |
	fieldsToWater := Set new.
	(self cells select: [ :field | field hasWater ]) do: [ :field |
		fieldsToWater addAll: (field nextEntitiesLinkedBy: VACanal) ].
	self @@ VAFarmer do: [ :farmer |
			farmer canGetWaterFromTrustedFarmers ifTrue: [
				fieldsToWater add: farmer cell ] ].
	fieldsToWater do: [ :field | field water ]
]

{ #category : 'map' }
VAValleyModel >> trustTable [
	"Each trust, from the farmer who trusts to the farmer who is trusted."

	^ #( #( 'Ben' 'Ana' ) #( 'Ana' 'Carl' ) #( 'Carl' 'Ana' ) )
]
