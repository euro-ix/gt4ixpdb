Class {
	#name : #GtIXPDBOrganization,
	#superclass : #GtIXPDBEntity,
	#instVars : [
		'associations',
		'city',
		'contacts',
		'country',
		'name',
		'website',
		'providers'
	],
	#category : #'GT4IXPDB-Model'
}

{ #category : #accessing }
GtIXPDBOrganization >> associations [
	^ associations
]

{ #category : #accessing }
GtIXPDBOrganization >> associations: anObject [
	associations := anObject
]

{ #category : #accessing }
GtIXPDBOrganization >> city [
	^ city
]

{ #category : #accessing }
GtIXPDBOrganization >> city: anObject [
	city := anObject
]

{ #category : #accessing }
GtIXPDBOrganization >> contacts [
	^ contacts
]

{ #category : #accessing }
GtIXPDBOrganization >> contacts: anObject [
	contacts := anObject
]

{ #category : #accessing }
GtIXPDBOrganization >> country [
	^ country
]

{ #category : #accessing }
GtIXPDBOrganization >> country: anObject [
	country := anObject
]

{ #category : #accessing }
GtIXPDBOrganization >> gtContactsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Contacts';
		priority: 1;
		items: [ self contacts ];
		column: 'Name' text: #name;
		column: 'Address' text: #address;
		column: 'email' text: #email;
		column: 'City' text: #city;
		column: 'Country' text: #country
]

{ #category : #accessing }
GtIXPDBOrganization >> gtProvidersFor: aView [
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
GtIXPDBOrganization >> name [
	^ name
]

{ #category : #accessing }
GtIXPDBOrganization >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtIXPDBOrganization >> onRawData [
	self
		associations: (rawData at: 'association');
		city: (rawData at: 'city');
		contacts: ((rawData at: 'contacts')
				collect: [ :aDictionary | GtIXPDBAddress new fromRawData: aDictionary ]);
		country: (rawData at: 'country');
		name: (rawData at: 'name');
		website: (rawData at: 'website')
]

{ #category : #accessing }
GtIXPDBOrganization >> providers [
	^ providers
		ifNil: [ providers := self client
					get: '/organization/' , self id , '/providers'
					into: GtIXPDBProvider ]
]

{ #category : #accessing }
GtIXPDBOrganization >> website [
	^ website
]

{ #category : #accessing }
GtIXPDBOrganization >> website: anObject [
	website := anObject
]
