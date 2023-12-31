Class {
	#name : #GtIXPDBProvider,
	#superclass : #GtIXPDBEntity,
	#instVars : [
		'city',
		'country',
		'locationCount',
		'lookingGlass',
		'manrs',
		'name',
		'organizationId',
		'participantCount',
		'pdbId',
		'updated',
		'website',
		'trafficApi',
		'organization',
		'ixfExportApi',
		'networks',
		'participants'
	],
	#category : #'GT4IXPDB-Model'
}

{ #category : #accessing }
GtIXPDBProvider >> city [
	^ city
]

{ #category : #accessing }
GtIXPDBProvider >> city: anObject [
	city := anObject
]

{ #category : #accessing }
GtIXPDBProvider >> country [
	^ country
]

{ #category : #accessing }
GtIXPDBProvider >> country: anObject [
	country := anObject
]

{ #category : #accessing }
GtIXPDBProvider >> gtGraphFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Graph';
		priority: 3;
		painting: [ :m | 
			| aParticipantsList |
			aParticipantsList := self participants.
			m nodes
				stencil: [ :aParticipant | 
					| element |
					element := BlTextElement new.
					element
						when: BlClickEvent
							do: [ :e | 
								e consumed: true.
								element phlow spawnObject: aParticipant ];
						text: (aParticipant name asRopedText foreground: Color gray) ];
				with: aParticipantsList.
			m nodes
				stencil: [ :aProvider | 
					| element |
					element := BlTextElement new.
					element
						when: BlClickEvent
							do: [ :e | 
								e consumed: true.
								element phlow spawnObject: aProvider ];
						text: aProvider name asRopedText ];
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
				connect: aParticipantsList
					from: [ :x | self ]
					to: #yourself.
			m layout horizontalDominanceTree
				nodeDistance: 10;
				levelDistance: 20 ]
]

{ #category : #accessing }
GtIXPDBProvider >> gtNetworksFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Networks';
		priority: 1;
		items: [ self networks ];
		column: 'Name' text: #name;
		column: '# of addresses' text: [ :aNetwork | aNetwork addresses size ]
]

{ #category : #accessing }
GtIXPDBProvider >> gtParticipantsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Participants';
		priority: 1;
		items: [ self participants ];
		column: 'Name' text: #name;
		column: 'ASN' text: #asn;
		column: 'Provider Count' text: #providerCount;
		column: 'IPv6' text: #ipv6;
		column: 'MANRS' text: #manrs
]

{ #category : #accessing }
GtIXPDBProvider >> gtSearchParticipants: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Participants';
		priority: 2;
		items: [ self participants ];
		itemsLimit: Float infinity;
		itemName: #name;
		filterBySubstring
]

{ #category : #accessing }
GtIXPDBProvider >> ixfExportApi [
	^ ixfExportApi
]

{ #category : #accessing }
GtIXPDBProvider >> ixfExportApi: anObject [
	ixfExportApi := anObject
]

{ #category : #accessing }
GtIXPDBProvider >> locationCount [
	^ locationCount
]

{ #category : #accessing }
GtIXPDBProvider >> locationCount: anObject [
	locationCount := anObject
]

{ #category : #accessing }
GtIXPDBProvider >> lookingGlass [
	^ lookingGlass
]

{ #category : #accessing }
GtIXPDBProvider >> lookingGlass: anObject [
	lookingGlass := anObject
]

{ #category : #accessing }
GtIXPDBProvider >> manrs [
	^ manrs
]

{ #category : #accessing }
GtIXPDBProvider >> manrs: anObject [
	manrs := anObject
]

{ #category : #accessing }
GtIXPDBProvider >> name [
	^ name
]

{ #category : #accessing }
GtIXPDBProvider >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtIXPDBProvider >> networks [
	^ networks
		ifNil: [ networks := self client
					get: '/provider/' , self id asString , '/networks'
					into: GtIXPDBNetwork ]
]

{ #category : #accessing }
GtIXPDBProvider >> onRawData [
	self
		ixfExportApi: (rawData
				at: 'apis'
				at: 'ixfexport'
				ifAbsent: [ nil ]);
		trafficApi: (rawData
				at: 'apis'
				at: 'traffic'
				ifAbsent: [ nil ]);
		city: (rawData at: 'city');
		country: (rawData at: 'country');
		locationCount: (rawData at: 'location_count' ifAbsent: [ nil ]);
		lookingGlass: (rawData at: 'looking_glass' ifAbsent: [ nil ]);
		manrs: (rawData at: 'manrs' ifAbsent: [ nil ]);
		name: (rawData at: 'name');
		organizationId: (rawData at: 'organization_id' ifAbsent: [ nil ]);
		participantCount: (rawData at: 'participant_count' ifAbsent: [ nil ]);
		pdbId: (rawData at: 'pdb_id' ifAbsent: [ nil ]);
		updated: (rawData
				at: 'updated'
				ifPresent: [ :aString | DateAndTime fromString: aString ]
				ifAbsent: [ nil ]);
		website: (rawData at: 'website' ifAbsent: [ nil ])
]

{ #category : #accessing }
GtIXPDBProvider >> organization [
	organization ifNotNil: [ ^ organization ].

	organizationId ifNil: [ ^ nil ].

	^ organization := self client getOrganization: organizationId
]

{ #category : #accessing }
GtIXPDBProvider >> organizationId [
	^ organizationId
]

{ #category : #accessing }
GtIXPDBProvider >> organizationId: anObject [
	organizationId := anObject
]

{ #category : #accessing }
GtIXPDBProvider >> participantCount [
	^ participantCount
]

{ #category : #accessing }
GtIXPDBProvider >> participantCount: anObject [
	participantCount := anObject
]

{ #category : #accessing }
GtIXPDBProvider >> participants [
	^ participants
		ifNil: [ participants := self client
					get: '/provider/' , self id asString , '/participants'
					into: GtIXPDBParticipant ]
]

{ #category : #accessing }
GtIXPDBProvider >> pdbId [
	^ pdbId
]

{ #category : #accessing }
GtIXPDBProvider >> pdbId: anObject [
	pdbId := anObject
]

{ #category : #accessing }
GtIXPDBProvider >> printOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #accessing }
GtIXPDBProvider >> trafficApi [
	^ trafficApi
]

{ #category : #accessing }
GtIXPDBProvider >> trafficApi: anObject [
	trafficApi := anObject
]

{ #category : #accessing }
GtIXPDBProvider >> updated [
	^ updated
]

{ #category : #accessing }
GtIXPDBProvider >> updated: anObject [
	updated := anObject
]

{ #category : #accessing }
GtIXPDBProvider >> website [
	^ website
]

{ #category : #accessing }
GtIXPDBProvider >> website: anObject [
	website := anObject
]
