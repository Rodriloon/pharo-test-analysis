Class {
	#name : 'TSDLiteralPollutionFakeTest',
	#superclass : 'TestCase',
	#category : 'TestSmellsDetector-FakeTests',
	#package : 'TestSmellsDetector-FakeTests'
}

{ #category : 'tests' }
TSDLiteralPollutionFakeTest >> testWithLiteralPollution [
	"A fake test polluted with integers, floats, strings, symbols, and literal arrays"
	| temp |
	temp := 42.                 "Integer"
	temp := 3.14.               "Float"
	temp := 'stefan'.           "String"
	temp := #rottenTest.        "Symbol"
	temp := #(first second)     "Literal Array"
]
