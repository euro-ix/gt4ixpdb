Class {
	#name : #GtIXPDBAddress,
	#superclass : #GtIXPDBEntity,
	#instVars : [
		'address',
		'city',
		'country',
		'email',
		'name',
		'phone'
	],
	#category : #'GT4IXPDB-Model'
}

{ #category : #accessing }
GtIXPDBAddress >> address [
	^ address
]

{ #category : #accessing }
GtIXPDBAddress >> address: anObject [
	address := anObject
]

{ #category : #accessing }
GtIXPDBAddress >> city [
	^ city
]

{ #category : #accessing }
GtIXPDBAddress >> city: anObject [
	city := anObject
]

{ #category : #accessing }
GtIXPDBAddress >> country [
	^ country
]

{ #category : #accessing }
GtIXPDBAddress >> country: anObject [
	country := anObject
]

{ #category : #accessing }
GtIXPDBAddress >> email [
	^ email
]

{ #category : #accessing }
GtIXPDBAddress >> email: anObject [
	email := anObject
]

{ #category : #accessing }
GtIXPDBAddress >> name [
	^ name
]

{ #category : #accessing }
GtIXPDBAddress >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtIXPDBAddress >> onRawData [
	self
		address: (rawData at: 'address');
		city: (rawData at: 'city');
		country: (rawData at: 'country');
		email: (rawData at: 'email');
		name: (rawData at: 'name');
		phone: (rawData at: 'phone')
]

{ #category : #accessing }
GtIXPDBAddress >> phone [
	^ phone
]

{ #category : #accessing }
GtIXPDBAddress >> phone: anObject [
	phone := anObject
]
