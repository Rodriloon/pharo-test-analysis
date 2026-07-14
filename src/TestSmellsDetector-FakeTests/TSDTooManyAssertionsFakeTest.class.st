Class {
	#name : 'TSDTooManyAssertionsFakeTest',
	#superclass : 'TestCase',
	#category : 'TestSmellsDetector-FakeTests',
	#package : 'TestSmellsDetector-FakeTests'
}

{ #category : 'as yet unclassified' }
TSDTooManyAssertionsFakeTest >> assertionHelper [
	"A private helper method containing 10 assertions"
	self assert: true.
	self assert: true.
	self assert: true.
	self assert: true.
	self assert: true.
	self assert: true.
	self assert: true.
	self assert: true.
	self assert: true.
	self assert: true
]

{ #category : 'tests' }
TSDTooManyAssertionsFakeTest >> testUsingHelperAssertions [
	"A fake test calling a helper. 2 direct assertions + 10 in helper = 12 total (smell)"
	self assert: true.
	self assertionHelper.
	self assert: true
]

{ #category : 'tests' }
TSDTooManyAssertionsFakeTest >> testWithMixedAssertions [
	"A fake test containing exactly 12 assertions of different types"
	self assert: true.
	self deny: false.
	self assert: 1 equals: 1.
	self assert: 2 equals: 2.
	self assert: 3 equals: 2 + 1.
	self assert: 4 equals: 4.
	self assert: 5 equals: 5.
	self assert: 6 equals: 6.
	self assert: 7 equals: 7.
	self assert: 8 equals: 8.
	self assert: 9 equals: 9.
	self assert: 10 equals: 10
]

{ #category : 'tests' }
TSDTooManyAssertionsFakeTest >> testWithTooManyAssertions [
    self assert: true.
    self assert: true.
    self assert: true.
    self assert: true.
    self assert: true.
    self assert: true.
    self assert: true.
    self assert: true.
    self assert: true.
    self assert: true.
]
