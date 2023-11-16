Class {
	#name : #GtIXPDBParticipant,
	#superclass : #GtIXPDBEntity,
	#instVars : [
		'asn',
		'ipv6',
		'manrs',
		'providerCount',
		'ipAddresses',
		'name',
		'providers'
	],
	#category : #'GT4IXPDB-Model'
}

{ #category : #accessing }
GtIXPDBParticipant >> = other [
	^ self class = other class and: [ self asn = other asn ]
]

{ #category : #accessing }
GtIXPDBParticipant >> asn [
	^ asn
]

{ #category : #accessing }
GtIXPDBParticipant >> asn: anObject [
	asn := anObject
]

{ #category : #accessing }
GtIXPDBParticipant >> gtIPAddressesFor: aView [
	<gtView>
	^ aView list
		title: 'IP Adresses';
		priority: 1;
		items: [ self ipAddresses ]
]

{ #category : #accessing }
GtIXPDBParticipant >> gtProvidersFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Providers';
		priority: 2;
		items: [ self providers ];
		column: 'ID' text: #id;
		column: 'Name' text: #name;
		column: 'Website' text: #website;
		column: 'Updated' text: #updated
]

{ #category : #accessing }
GtIXPDBParticipant >> hash [
	^ self asn hash
]

{ #category : #accessing }
GtIXPDBParticipant >> ipAddresses [
	^ ipAddresses
]

{ #category : #accessing }
GtIXPDBParticipant >> ipAddresses: anObject [
	ipAddresses := anObject
]

{ #category : #accessing }
GtIXPDBParticipant >> ipv6 [
	^ ipv6
]

{ #category : #accessing }
GtIXPDBParticipant >> ipv6: anObject [
	ipv6 := anObject
]

{ #category : #accessing }
GtIXPDBParticipant >> manrs [
	^ manrs
]

{ #category : #accessing }
GtIXPDBParticipant >> manrs: anObject [
	manrs := anObject
]

{ #category : #accessing }
GtIXPDBParticipant >> name [
	^ name
]

{ #category : #accessing }
GtIXPDBParticipant >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtIXPDBParticipant >> onRawData [
	self
		asn: (rawData at: 'asn');
		ipv6: (rawData at: 'ipv6');
		manrs: (rawData at: 'manrs' ifAbsent: 'unknown');
		name: (rawData at: 'name');
		providerCount: (rawData at: 'provider_count' ifAbsent: 'unknown');
		ipAddresses: (rawData at: 'ip_addresses')
]

{ #category : #accessing }
GtIXPDBParticipant >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #accessing }
GtIXPDBParticipant >> providerCount [
	^ providerCount
]

{ #category : #accessing }
GtIXPDBParticipant >> providerCount: anObject [
	providerCount := anObject
]

{ #category : #accessing }
GtIXPDBParticipant >> providers [
	^ providers
		ifNil: [ providers := self client
					get: '/participant/' , self asn asString , '/providers'
					into: GtIXPDBProvider ]
]
