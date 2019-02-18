Extension { #name : #CompilationContext }

{ #category : #'*ParserMOP' }
CompilationContext >> parserClass [
	^ parserClass ifNil: [ parserClass := class parser ]
]
