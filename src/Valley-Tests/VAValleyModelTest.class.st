"
I check how water moves through the valley: along canals one step at a time, never along footpaths, and between farmers who trust each other.
"
Class {
	#name : 'VAValleyModelTest',
	#superclass : 'TestCase',
	#instVars : [
		'valley',
		'simulation'
	],
	#category : 'Valley-Tests',
	#package : 'Valley-Tests'
}

{ #category : 'running' }
VAValleyModelTest >> runSteps: aNumber [

	aNumber timesRepeat: [ simulation runStep ]
]

{ #category : 'running' }
VAValleyModelTest >> setUp [

	super setUp.
	valley := VAValleyModel new.
	simulation := CMSimulation for: valley.
	simulation
		activeInitSelector: #initValley;
		activeControlSelector: #step;
		initializeSimulation
]

{ #category : 'tests' }
VAValleyModelTest >> testOnlyTheSpringHasWaterAtTheStart [

	self assert: self wateredFieldNames equals: #( 'Spring' ) asSet
]

{ #category : 'tests' }
VAValleyModelTest >> testTrustIsNotReturned [
	"Without the canal from A to B, Ana's field B can only get water from a farmer Ana trusts. Carl trusts Ana, but once Ana no longer trusts Carl, B stays dry."

	((valley field: 'A') outgoingLinksOfClass: VACanal) do: [ :canal |
		canal to = (valley field: 'B') ifTrue: [ canal delete ] ].
	((valley farmer: 'Ana') outgoingLinksOfClass: VATrust) do: [ :trust |
		trust delete ].
	self runSteps: 10.
	self deny: (valley field: 'B') hasWater
]

{ #category : 'tests' }
VAValleyModelTest >> testTrustedFarmerSharesWaterWithTheFarmerWhoTrustsThem [
	"Ben trusts Ana. Ana's field B gets water at step 2, so Ben's field E gets it at step 3."

	self runSteps: 2.
	self deny: (valley field: 'E') hasWater.
	self runSteps: 1.
	self assert: (valley field: 'E') hasWater
]

{ #category : 'tests' }
VAValleyModelTest >> testWaterFlowsOneCanalPerStep [

	self runSteps: 1.
	self assert: self wateredFieldNames equals: #( 'Spring' 'A' ) asSet.
	self runSteps: 1.
	self
		assert: self wateredFieldNames
		equals: #( 'Spring' 'A' 'B' 'C' ) asSet
]

{ #category : 'tests' }
VAValleyModelTest >> testWaterNeverFlowsAlongAFootpath [
	"E is joined to B and D only by footpaths. Without Ben's trust in Ana, it stays dry."

	((valley farmer: 'Ben') outgoingLinksOfClass: VATrust) do: [ :trust |
		trust delete ].
	self runSteps: 10.
	self deny: (valley field: 'E') hasWater
]

{ #category : 'tests' }
VAValleyModelTest >> testWaterReachesAFieldThroughAChainOfTrust [
	"Without the canal from A to B, water reaches Carl's field D, then Ana's field B because Ana trusts Carl, then Ben's field E because Ben trusts Ana."

	((valley field: 'A') outgoingLinksOfClass: VACanal) do: [ :canal |
		canal to = (valley field: 'B') ifTrue: [ canal delete ] ].
	self runSteps: 3.
	self deny: (valley field: 'B') hasWater.
	self runSteps: 1.
	self assert: (valley field: 'B') hasWater.
	self deny: (valley field: 'E') hasWater.
	self runSteps: 1.
	self assert: (valley field: 'E') hasWater
]

{ #category : 'tests' }
VAValleyModelTest >> testWaterReachesEveryNamedFieldAfterThreeSteps [

	self runSteps: 3.
	self
		assert: self wateredFieldNames
		equals: #( 'Spring' 'A' 'B' 'C' 'D' 'E' ) asSet
]

{ #category : 'running' }
VAValleyModelTest >> wateredFieldNames [

	^ (valley cells select: [ :field |
		   field hasWater and: [ field name isNotNil ] ])
		  collect: [ :field | field name ]
		  as: Set
]
