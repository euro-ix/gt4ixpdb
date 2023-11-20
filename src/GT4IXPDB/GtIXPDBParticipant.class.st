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
GtIXPDBParticipant >> gtGraphFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Graph';
		priority: 3;
		painting: [ :m | 
			| aProvidersList |
			aProvidersList := self providers.
			m nodes
				stencil: [ :aProvider | 
					| element |
					element := BlTextElement new.
					element
						when: BlClickEvent
							do: [ :e | 
								e consumed: true.
								element phlow spawnObject: aProvider ];
						text: (aProvider name asRopedText foreground: Color gray) ];
				with: aProvidersList.
			m nodes
				stencil: [ :aParticipant | 
					| element |
					element := BlTextElement new.
					element
						when: BlClickEvent
							do: [ :e | 
								e consumed: true.
								element phlow spawnObject: aParticipant ];
						text: aParticipant name asRopedText ];
				with: {self}.
			m edges
				stencil: [ :x | 
					BlManhattanLineElement new
						zIndex: 0;
						beFixedTo;
						cornerRadius: 10;
						fixedDistance: 10;
						border: (BlBorder paint: (Color gray alpha: 0.2) width: 2);
						toHead: (BlArrowheadSimpleArrow new
								border: (BlBorder builder
										paint: (Color gray alpha: 0.2);
										width: 2;
										build)) ];
				fromRightCenter;
				toLeftCenter;
				connect: aProvidersList
					from: [ :x | self ]
					to: #yourself.
			m layout horizontalDominanceTree
				nodeDistance: 10;
				levelDistance: 20 ]
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
		column: 'City' text: #city;
		column: 'Country' text: #country
]

{ #category : #accessing }
GtIXPDBParticipant >> gtSearchProviders: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Providers';
		priority: 1;
		items: [ self providers ];
		itemsLimit: Float infinity;
		itemName: #name;
		filterBySubstring
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
