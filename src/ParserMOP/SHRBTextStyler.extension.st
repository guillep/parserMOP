Extension { #name : #SHRBTextStyler }

{ #category : #'*ParserMOP' }
SHRBTextStyler >> parse: aText isMethod: isMethod [
	|root|
	
	isMethod 
		ifTrue: [
			[root := classOrMetaClass parser parseFaultyMethod: aText asString.
			root methodNode methodClass: classOrMetaClass.
			^root] 
				on: Error 
				do: [^RBParser parseFaultyExpression: aText asString]]
		ifFalse:[ ^RBParser parseFaultyExpression: aText asString ].
]
