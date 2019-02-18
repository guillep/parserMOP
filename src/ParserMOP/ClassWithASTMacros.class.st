Class {
	#name : #ClassWithASTMacros,
	#superclass : #Object,
	#category : #'ParserMOP-Examples'
}

{ #category : #accessing }
ClassWithASTMacros class >> parser [

	^ super parser
		beFaulty;
		addPlugin: BacktickPlugin new;
		yourself
]

{ #category : #tests }
ClassWithASTMacros >> test [
	"self new test >> an OrderedCollection(RBMessageNode(1 + 2) RBLiteralValueNode(1) RBLiteralValueNode(2))"
	^ `(1+2) allChildren
]
