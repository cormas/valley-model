Class {
	#name : 'BaselineOfValleyModel',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfValleyModel',
	#package : 'BaselineOfValleyModel'
}

{ #category : 'baselines' }
BaselineOfValleyModel >> baseline: spec [

	<baseline>
	spec for: #common do: [
			spec
				package: 'Valley-Model';
				package: 'Valley-Tests'
				with: [ spec requires: #( 'Valley-Model' ) ] ]
]
