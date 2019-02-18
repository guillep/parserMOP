Class {
	#name : #BacktickPlugin,
	#superclass : #Object,
	#category : #'ParserMOP-Examples'
}

{ #category : #transforming }
BacktickPlugin >> transform: anAST [
	anAST	nodesDo: [ :each |
		(each isParseError and: [ each value beginsWith: '`' ]) ifTrue: [ 
			| macroNode |
			macroNode := RBLiteralValueNode 
				value: each next
				start: each start
				stop: each stop.
			each replaceWith: macroNode ] ].
	^ anAST
]
