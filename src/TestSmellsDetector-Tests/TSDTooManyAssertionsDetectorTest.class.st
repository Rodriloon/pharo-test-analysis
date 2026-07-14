Class {
	#name : 'TSDTooManyAssertionsDetectorTest',
	#superclass : 'TSDDetectorTest',
	#category : 'TestSmellsDetector-Tests',
	#package : 'TestSmellsDetector-Tests'
}

{ #category : 'accessing' }
TSDTooManyAssertionsDetectorTest >> detectorClass [
	"Returns the detector class that this test class is responsible for testing"
	^ TSDTooManyAssertionsDetector
]

{ #category : 'as yet unclassified' }
TSDTooManyAssertionsDetectorTest >> fixtureClass [
	"Returns the fake test class containing the scenarios for this detector"
	^ TSDTooManyAssertionsFakeTest
]

{ #category : 'tests' }
TSDTooManyAssertionsDetectorTest >> testTooManyAssertionsWithHelper [
	"Verify that the detector successfully hunts down and counts assertions hidden inside helper methods"
	self assert: (self detector detectSelector: #testUsingHelperAssertions)
]

{ #category : 'tests' }
TSDTooManyAssertionsDetectorTest >> testTooManyAssertionsWithMixed [
	"Verify that the detector catches tests exceeding the assert limit using mixed assertion types"
	self assert: (self detector detectSelector: #testWithMixedAssertions)
]
