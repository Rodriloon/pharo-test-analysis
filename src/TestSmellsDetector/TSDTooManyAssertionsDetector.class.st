Class {
	#name : 'TSDTooManyAssertionsDetector',
	#superclass : 'TSDSmellDetector',
	#category : 'TestSmellsDetector',
	#package : 'TestSmellsDetector'
}

{ #category : 'accessing' }
TSDTooManyAssertionsDetector >> assertionSelectors [
    ^ #(#assert: #deny: #assert:equals: #assert:description: #should:raise: #shouldnt:raise: #assert:identicalTo:)
]

{ #category : 'api' }
TSDTooManyAssertionsDetector >> buildResult: aResult [

	super buildResult: aResult.
	aResult hasTooManyAssertions: self detects
]

{ #category : 'testing' }
TSDTooManyAssertionsDetector >> detects [
    ^ self hasTooManyAssertions
]

{ #category : 'testing' }
TSDTooManyAssertionsDetector >> hasTooManyAssertions [
	| visitor helpersDict helperMethods methodsToAnalyze assertionsCount |
	"1. Create the helper visitor with assertable selectors configured"
	visitor := RTDHelperVisitor withAssertableSelectors. 
	visitor analyzeMethod: self compiledMethod.
	
	"2. Safely extract helper methods from the private dictionary in RTDHelpers"
	helpersDict := visitor helpers instVarNamed: #methodHelpers.
	helperMethods := OrderedCollection new.
	helpersDict valuesDo: [ :each |
		(each isCollection and: [ each isString not ])
			ifTrue: [ helperMethods addAll: each ]
			ifFalse: [ helperMethods add: each ] ].

	"3. Combine the main test method with all found helper methods"
	methodsToAnalyze := OrderedCollection with: self compiledMethod.
	methodsToAnalyze addAll: helperMethods.
	
	"4. Sum all assertion sends across the test and all its helper methods"
	assertionsCount := methodsToAnalyze sum: [ :each |
		| methodAst |
		methodAst := (each respondsTo: #ast) ifTrue: [ each ast ] ifFalse: [ each ].
		methodAst sendNodes count: [ :node | 
			self assertionSelectors includes: node selector ] ]
		ifEmpty: [ 0 ].
			
	"5. Check if the total exceeds the allowed maximum"
	^ assertionsCount > self maxAssertions
]

{ #category : 'accessing' }
TSDTooManyAssertionsDetector >> maxAssertions [
    ^ 5
]

{ #category : 'accessing' }
TSDTooManyAssertionsDetector >> smellResultClass [
    ^ TSDTooManyAssertionsResult
]
