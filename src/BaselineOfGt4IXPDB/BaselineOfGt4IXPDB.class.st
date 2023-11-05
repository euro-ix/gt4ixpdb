Class {
	#name : #BaselineOfGt4IXPDB,
	#superclass : #BaselineOf,
	#category : #BaselineOfGt4IXPDB
}

{ #category : #baseline }
BaselineOfGt4IXPDB >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'GT4IXPDB'
		]
]
