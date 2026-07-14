"
I build DrTest trees from the tests stored in `DTTSDTestData`
"
Class {
	#name : 'DTTSDResult',
	#superclass : 'DTPluginResult',
	#instVars : [
		'detectedTests'
	],
	#category : 'DrTests-TestSmellsDetector-Presenters',
	#package : 'DrTests-TestSmellsDetector',
	#tag : 'Presenters'
}

{ #category : 'instance creation' }
DTTSDResult class >> detectedTests: aTestData [

	^ self new detectedTests: aTestData; yourself
]

{ #category : 'accessing' }
DTTSDResult >> buildTreeForUI [
	<dtTestSmellsResultTreeNamed: 'All Smells Found' order: 1>
	^ self treeNode subResults: { 
		(self buildTreeForUIAssertionless
			name: 'Tests with no assertions';
			yourself).
		(self buildTreeForUIOverwrittenSetup
			name: 'Tests that overwrite setup variables';
			yourself).
		(self buildTreeForUIUselessSetup
			name: 'Tests not fully using their set up';
			yourself).
		(self buildTreeForUIManyClassReferences
			name: 'Tests references classes too many times';
			yourself).
		(self buildTreeForUITooManyAssertions
			name: 'Tests with too many assertions';
			yourself).
		(self buildTreeForUIMagicLiteral
			name: 'Tests with magic literals';
			yourself).
		(self buildTreeForUILiteralPollution
			name: 'Tests with literal pollution';
			yourself) }
]

{ #category : 'accessing' }
DTTSDResult >> buildTreeForUIAssertionless [

	<dtTestTSDResultTreeNamed: 'Tests without assertions' order: 5>
	^ self buildTreeFrom: self detectedTests assertionlessTests
]

{ #category : 'as yet unclassified' }
DTTSDResult >> buildTreeForUILiteralPollution [

	<dtTestTSDResultTreeNamed: 'Tests with literal pollution' order: 8>
	^ self buildTreeFrom: self detectedTests literalPollutionTests
]

{ #category : 'as yet unclassified' }
DTTSDResult >> buildTreeForUIMagicLiteral [

	<dtTestTSDResultTreeNamed: 'Tests with magic literals' order: 7>
	^ self buildTreeFrom: self detectedTests magicLiteralTests
]

{ #category : 'accessing' }
DTTSDResult >> buildTreeForUIManyClassReferences [

	<dtTestTSDResultTreeNamed: 'Tests references classes too many times' order: 3>
	^ self buildTreeFrom: self detectedTests manyClassReferencesTests 
]

{ #category : 'accessing' }
DTTSDResult >> buildTreeForUIOverwrittenSetup [
	
	<dtTestTSDResultTreeNamed: 'Tests that overwrite setup' order: 2>
	^ self buildTreeFrom: self detectedTests overwrittenSetupTests 
]

{ #category : 'as yet unclassified' }
DTTSDResult >> buildTreeForUITooManyAssertions [

	<dtTestTSDResultTreeNamed: 'Tests with too many assertions' order: 6>
	^ self buildTreeFrom: self detectedTests tooManyAssertionsTests
]

{ #category : 'accessing' }
DTTSDResult >> buildTreeForUIUselessSetup [ 

	<dtTestTSDResultTreeNamed: 'Tests not fully using their set up' order: 4>
	^ self buildTreeFrom: self detectedTests uselessSetupTests 
]

{ #category : 'private' }
DTTSDResult >> buildTreeFrom: testCases [

	^ self treeNode subResults: (testCases collect: #asResultForDrTest )
]

{ #category : 'accessing' }
DTTSDResult >> detectedTests [

	^ detectedTests
]

{ #category : 'accessing' }
DTTSDResult >> detectedTests: anObject [

	detectedTests := anObject
]

{ #category : 'factory' }
DTTSDResult >> treeNode [

	^ DTTreeNode new
		  subResultsAggregator: [ :subResults | subResults size ];
		  yourself
]
