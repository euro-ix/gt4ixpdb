Class {
	#name : #GtIXPDBTraffic,
	#superclass : #GtIXPDBEntity,
	#instVars : [
		'url',
		'ixpId',
		'ixp'
	],
	#category : #'GT4IXPDB-Client'
}

{ #category : #accessing }
GtIXPDBTraffic >> ixpId [
	^ ixpId
]

{ #category : #accessing }
GtIXPDBTraffic >> ixpId: anObject [
	ixpId := anObject
]

{ #category : #accessing }
GtIXPDBTraffic >> onRawData [
	self
		url: (rawData at: 'url');
		ixpId: (rawData at: 'ixp')
]

{ #category : #accessing }
GtIXPDBTraffic >> printOn: aStream [
	aStream
		nextPutAll: self ixpId asString;
		nextPutAll: ': ';
		nextPutAll: self url
]

{ #category : #accessing }
GtIXPDBTraffic >> url [
	^ url
]

{ #category : #accessing }
GtIXPDBTraffic >> url: anObject [
	url := anObject
]
