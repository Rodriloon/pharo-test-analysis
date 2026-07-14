Class {
	#name : 'TSDLiteralPollutionDetector',
	#superclass : 'TSDSmellDetector',
	#category : 'TestSmellsDetector',
	#package : 'TestSmellsDetector'
}

{ #category : 'api' }
TSDLiteralPollutionDetector >> buildResult: aResult [

	super buildResult: aResult.
	aResult hasLiteralPollution: self detects
]

{ #category : 'testing' }
TSDLiteralPollutionDetector >> detects [
	^ self hasLiteralPollution
]

{ #category : 'testing' }
TSDLiteralPollutionDetector >> hasLiteralPollution [
	| literalsCount |
	literalsCount := self compiledMethod ast statements isNotEmpty
		ifTrue: [ 
			self compiledMethod ast allChildren count: [ :node | 
				node isLiteralNode ] ]
		ifFalse: [ 0 ].
	^ literalsCount > self maxLiterals
]

{ #category : 'accessing' }
TSDLiteralPollutionDetector >> maxLiterals [
	^ 3 "If it has more than 3 literal numbers or strings, it is considered polluted"
]

{ #category : 'accessing' }
TSDLiteralPollutionDetector >> smellResultClass [
	^ TSDLiteralPollutionResult
]
