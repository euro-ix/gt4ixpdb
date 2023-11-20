Class {
	#name : #GtIXPDBClient,
	#superclass : #Object,
	#instVars : [
		'baseUrl'
	],
	#category : #'GT4IXPDB-Client'
}

{ #category : #accessing }
GtIXPDBClient >> baseUrl [
	^ baseUrl
]

{ #category : #accessing }
GtIXPDBClient >> baseUrl: anObject [
	baseUrl := anObject
]

{ #category : #default }
GtIXPDBClient >> defaultBaseUrl [
	^ 'https://api.ixpdb.net/v1'
]

{ #category : #'as yet unclassified' }
GtIXPDBClient >> generateMap [
	^ GtIXPDBMap new
		client: self;
		generate
]

{ #category : #'api call' }
GtIXPDBClient >> get: aUrl [
	^ STONJSON fromString: (self newClientFor: aUrl) get
]

{ #category : #'api call' }
GtIXPDBClient >> get: aUrl byId: anId into: aClass [
	^ aClass new fromRawData: (self get: aUrl, anId asString)
]

{ #category : #'api call' }
GtIXPDBClient >> get: aUrl into: aClass [
	^ (self get: aUrl)
		collect: [ :aDictionary | 
			aClass new
				client: self;
				fromRawData: aDictionary ]
]

{ #category : #'api call' }
GtIXPDBClient >> getOrganization: anId [
	^ self get: '/organization/' byId: anId into: GtIXPDBOrganization
]

{ #category : #'api call' }
GtIXPDBClient >> getProvider: anId [
	^ self get: '/provider/' byId: anId into: GtIXPDBProvider
]

{ #category : #accessing }
GtIXPDBClient >> gtBuildMapActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons play;
		tooltip: 'Generate map';
		action: [ :aButton | aButton phlow spawnObject: self generateMap ]
]

{ #category : #view }
GtIXPDBClient >> gtParticipantsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Participants';
		priority: 1;
		items: [ self participants ];
		column: 'Name' text: #name weight: 3;
		column: 'ASN' text: #asn;
		column: 'Provider Count' text: #providerCount;
		column: 'IPv6' text: #ipv6;
		column: 'MANRS' text: #manrs
]

{ #category : #view }
GtIXPDBClient >> gtProvidersFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Providers';
		priority: 2;
		items: [ self providers ];
		column: 'ID' text: #id weight: 0.5;
		column: 'Name' text: #name;
		column: 'Website' text: #website;
		column: 'Updated' text: #updated
]

{ #category : #accessing }
GtIXPDBClient >> gtSearchParticipants: aSearch [
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
GtIXPDBClient >> gtSearchProviders: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Providers';
		priority: 1;
		items: [ self providers ];
		itemsLimit: Float infinity;
		itemName: #name;
		filterBySubstring
]

{ #category : #view }
GtIXPDBClient >> gtTrafficsFor: aView [
	<gtView>
	^ aView list
		title: 'Traffics';
		priority: 3;
		items: [ self traffics ]
]

{ #category : #initialization }
GtIXPDBClient >> initialize [
	baseUrl := self defaultBaseUrl
]

{ #category : #'api call' }
GtIXPDBClient >> newClientFor: aUrl [
	^ ZnClient new beOneShot url: self baseUrl , aUrl
]

{ #category : #'api call' }
GtIXPDBClient >> participants [
	^ self get: '/participant/list' into: GtIXPDBParticipant
]

{ #category : #'api call' }
GtIXPDBClient >> providers [
	^ self get: '/provider/list' into: GtIXPDBProvider
]

{ #category : #view }
GtIXPDBClient >> traffics [
	^ self get: '/traffic/list' into: GtIXPDBTraffic
]
