Extension { #name : #Behavior }

{ #category : #'*ParserMOP' }
Behavior >> parser [
	"Answer a compiler appropriate for source methods of this class."

	^ RBParserFacade new
		environment: self environment;
		class: self
]
