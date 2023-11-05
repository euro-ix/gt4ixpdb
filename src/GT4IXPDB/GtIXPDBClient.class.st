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

{ #category : #view }
GtIXPDBClient >> gtParticipantsFor: aView [
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

{ #category : #view }
GtIXPDBClient >> gtProvidersFor: aView [
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
