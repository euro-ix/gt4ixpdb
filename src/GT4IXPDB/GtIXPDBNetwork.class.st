Class {
	#name : #GtIXPDBNetwork,
	#superclass : #GtIXPDBEntity,
	#instVars : [
		'addresses',
		'name',
		'routeServerAsns'
	],
	#category : #'GT4IXPDB-Model'
}

{ #category : #accessing }
GtIXPDBNetwork >> addresses [
	^ addresses
]

{ #category : #accessing }
GtIXPDBNetwork >> addresses: anObject [
	addresses := anObject
]

{ #category : #accessing }
GtIXPDBNetwork >> gtIPAddressesFor: aView [
	<gtView>
	^ aView list
		title: 'Adresses';
		priority: 1;
		items: [ self addresses ]
]

{ #category : #accessing }
GtIXPDBNetwork >> name [
	^ name
]

{ #category : #accessing }
GtIXPDBNetwork >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtIXPDBNetwork >> onRawData [
	self
		addresses: (rawData at: 'addresses');
		name: (rawData at: 'name');
		routeServerAsns: (rawData at: 'route_server_asns')
]

{ #category : #accessing }
GtIXPDBNetwork >> printOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #accessing }
GtIXPDBNetwork >> routeServerAsns [
	^ routeServerAsns
]

{ #category : #accessing }
GtIXPDBNetwork >> routeServerAsns: anObject [
	routeServerAsns := anObject
]
