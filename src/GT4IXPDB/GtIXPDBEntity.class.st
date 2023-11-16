Class {
	#name : #GtIXPDBEntity,
	#superclass : #Object,
	#instVars : [
		'rawData',
		'id',
		'client'
	],
	#category : #'GT4IXPDB-Model'
}

{ #category : #accessing }
GtIXPDBEntity >> = other [
	^ self class = other class and: [ self id = other id ]
]

{ #category : #accessing }
GtIXPDBEntity >> client [
	^ client
]

{ #category : #accessing }
GtIXPDBEntity >> client: anObject [
	client := anObject
]

{ #category : #accessing }
GtIXPDBEntity >> fromRawData: aDictionary [
	self rawData: aDictionary.

	(aDictionary includesKey: 'id') ifTrue: [ self id: (aDictionary at: 'id') ].

	self onRawData
]

{ #category : #accessing }
GtIXPDBEntity >> hash [
	^ self id hash
]

{ #category : #accessing }
GtIXPDBEntity >> id [
	^ id
]

{ #category : #accessing }
GtIXPDBEntity >> id: anObject [
	id := anObject
]

{ #category : #accessing }
GtIXPDBEntity >> onRawData [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtIXPDBEntity >> rawData [
	^ rawData
]

{ #category : #accessing }
GtIXPDBEntity >> rawData: anObject [
	rawData := anObject
]
