Class {
	#name : #RBParserFacade,
	#superclass : #Object,
	#instVars : [
		'plugins',
		'beForExpression',
		'beFaulty',
		'environment',
		'class'
	],
	#category : #ParserMOP
}

{ #category : #accessing }
RBParserFacade >> addPlugin: aPlugin [

	plugins add: aPlugin
]

{ #category : #parsing }
RBParserFacade >> basicParse: aString [ 
	
	^ beForExpression
		ifTrue: [ self basicParseExpression: aString ]
		ifFalse: [ self basicParseMethod: aString ]
]

{ #category : #parsing }
RBParserFacade >> basicParseExpression: aString [ 
	
	^ RBParser parseExpression: aString onError: self errorBlock
]

{ #category : #parsing }
RBParserFacade >> basicParseMethod: aString [ 
	
	^ RBParser parseMethod: aString onError: self errorBlock
]

{ #category : #accessing }
RBParserFacade >> beFaulty [
	
	self beFaulty: true
]

{ #category : #accessing }
RBParserFacade >> beFaulty: aBoolean [
	beFaulty := aBoolean
]

{ #category : #accessing }
RBParserFacade >> beForExpression [
	
	self beForExpression: true
]

{ #category : #accessing }
RBParserFacade >> beForExpression: aBoolean [
	
	beForExpression := aBoolean
]

{ #category : #accessing }
RBParserFacade >> beForMethod [
	
	self beForExpression: false
]

{ #category : #accessing }
RBParserFacade >> beStrict [
	
	self beFaulty: false
]

{ #category : #accessing }
RBParserFacade >> class: aClass [ 
	"Class/context where the parsing happens"
	class := aClass
]

{ #category : #accessing }
RBParserFacade >> environment: aCollection [ 
	"Environment to use for semantic analysis"
	environment := aCollection
]

{ #category : #parsing }
RBParserFacade >> errorBlock [

	beFaulty ifFalse: [ ^ nil ].
	^ [ :aString :position :parser |
		| errorNode |
		errorNode := parser parseErrorNode: aString.
		"Keep parsing after the error"
		parser step.
		errorNode next: parser parsePrimitiveObject ].
]

{ #category : #accessing }
RBParserFacade >> initialize [

	super initialize.
	beFaulty := false.
	beForExpression := false.
	plugins := OrderedCollection new
]

{ #category : #parsing }
RBParserFacade >> parse: aString [ 
	
	| ast |
	ast := self basicParse: aString.
	plugins do: [ :pl | 
		ast := pl transform: ast ].
	^ ast
]

{ #category : #parsing }
RBParserFacade >> parseExpression: aString [ 
	
	self beForExpression.
	^ self parse: aString
]

{ #category : #api }
RBParserFacade >> parseFaultyMethod: aString [ 
	
	self beFaulty.
	^ self parseMethod: aString
]

{ #category : #parsing }
RBParserFacade >> parseLiterals: asd [

	^ RBParser parseLiterals: asd
]

{ #category : #api }
RBParserFacade >> parseMethod: aString [ 
	
	self beForMethod.
	^ self parse: aString
]

{ #category : #accessing }
RBParserFacade >> plugins [
	^ plugins
]

{ #category : #accessing }
RBParserFacade >> plugins: anObject [
	plugins := anObject
]
