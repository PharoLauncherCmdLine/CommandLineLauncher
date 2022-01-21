"
A ConsoleListFormatterTest is a test class for testing the behavior of ConsoleListFormatter
"
Class {
	#name : #ConsoleListFormatterTest,
	#superclass : #TestCase,
	#instVars : [
		'formatter',
		'command'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #running }
ConsoleListFormatterTest >> setUp [
	
	super setUp.
	command := PhLCliCommandMock new. 
	formatter := ConsoleListFormatter on: command.
]

{ #category : #test }
ConsoleListFormatterTest >> testAttributeValuesFrom [

	formatter attributeValueBlocks: { [:a |a asString  ]. [:a |(a ** 2) asString  ]. [:a |(a ** 3) asString  ] }.

	self assert: (formatter attributeValuesFrom: 2) equals: #('2' '4' '8').
]

{ #category : #test }
ConsoleListFormatterTest >> testGetColumnWidthsFrom [
		formatter attributeLabels: #('1234567890' 'x' 'x').
		formatter attributeValueBlocks: { [:a |a asWords  ]. [:a |a asWords  ]. [:a |a asWords  ] }.
		self assert: (formatter getColumnWidthsFrom: #(1 2 3)) equals: #(10 5 5).
]

{ #category : #test }
ConsoleListFormatterTest >> testPrintAttributeHeadersBy [
	formatter
		printAttributeHeaders: #('label1' 'label2' 'label3')
		by: #(7 8 9).
	self
		assert: command outStream contents
		equals:
			(String
				streamContents: [ :aStream | 
					aStream
						nextPutAll: '# *label1 *label2  *label3   ';
						newLine;
						nextPutAll: '--*-------*--------*---------';
						newLine ])
]

{ #category : #test }
ConsoleListFormatterTest >> testPrintAttributeRowsBy [

	|expectedString|
	formatter attributeValueBlocks: { [:a |a asWords  ]. [:a |a squared asWords  ]. [:a |(a **3) asWords  ] }.
	formatter domainObjects: #(1 2 3).

	formatter printAttributeRows: formatter domainObjects by: #(10 10 13).
	
	expectedString := String streamContents: [:aStream | 
		aStream 
			nextPutAll: '1 *one       *one       *one          '; newLine;
			nextPutAll: '2 *two       *four      *eight        '; newLine;
			nextPutAll: '3 *three     *nine      *twenty-seven '; newLine
			].

	self assert: formatter outStream contents equals: expectedString.
]

{ #category : #test }
ConsoleListFormatterTest >> testPrintAttributeTable [

		|expectedString|
	formatter attributeLabels: #('Value' 'Squared' 'Raised to 3').
	formatter attributeValueBlocks: { [:a |a asWords  ]. [:a |a squared asWords  ]. [:a |(a **3) asWords  ] }.
	formatter domainObjects: #(1 2 3).
	formatter printAttributeTable.
	
	expectedString := String streamContents: [:aStream | 
		aStream 
			nextPutAll: '# *Value*Squared*Raised to 3 '; newLine;
			nextPutAll: '--*-----*-------*------------'; newLine;
			nextPutAll: '1 *one  *one    *one         '; newLine;
			nextPutAll: '2 *two  *four   *eight       '; newLine;
			nextPutAll: '3 *three*nine   *twenty-seven'; newLine
	].

	self assert: formatter outStream contents equals: expectedString.

]

{ #category : #test }
ConsoleListFormatterTest >> testPrintCellWidth [

	formatter printCell: 'value' width: 10.
	self assert: command outStream contents equals: 'value     '.
	command resetOutStream.
	formatter printCell: 'value' width: 0.
	self assert: command outStream contents equals: 'value'.
]

{ #category : #test }
ConsoleListFormatterTest >> testPrintDelimiter [

	formatter printDelimiter.
	self assert: command outStream contents equals: command delimiter.
]

{ #category : #test }
ConsoleListFormatterTest >> testPrintHeaderLinesBy [

	formatter printHeaderLinesBy: #(1 1 2 2).
	self assert: command outStream contents equals: (String streamContents: [:aStream | aStream nextPutAll: '--*-*-*--*--'; newLine]).
]

{ #category : #test }
ConsoleListFormatterTest >> testPrintLineSized [

	formatter printLineSized: 5.
	self assert: command outStream contents equals: '-----'.
]

{ #category : #test }
ConsoleListFormatterTest >> testPrintListAsSton [

	formatter domainObjects: {PhLImagesMock atRandom. PhLImagesMock atRandom. PhLImagesMock atRandom.}.
	formatter printListAsSton.

	self assert: (formatter outStream contents includesSubstring: 'PhLImagesMock').
]

{ #category : #test }
ConsoleListFormatterTest >> testPrintListAttributes [

		|actualTableString actualRowString expectedString actualString |
	formatter attributeLabels: #('Value' 'Squared' 'Raised to 3').
	formatter attributeValueBlocks: { [:a |a asWords  ]. [:a |a squared asWords  ]. [:a |(a **3) asWords  ] }.
	formatter domainObjects: #(1 2 3).
	command rowMode: true.
	
	formatter listPrintAttributes.
	actualString := formatter outStream contents.

	formatter resetOutStream.
	command rowMode: false.		

]

{ #category : #test }
ConsoleListFormatterTest >> testPrintOneAttrPerRow [
	|expectedString|
	formatter attributeLabels: #('Value' 'Squared' 'Raised to 3').
	formatter attributeValueBlocks: { [:a |a asWords  ]. [:a |a squared asWords  ]. [:a |(a **3) asWords  ] }.
	formatter domainObjects: #(1 2 3).
	command rowMode: true.

	formatter printOneAttrPerRow.

	expectedString := String streamContents: [:aStream | 
		aStream 
			nextPutAll: 'Nr.: 1 '; newLine;
			nextPutAll: 'Value: one'; newLine;
		 	nextPutAll: 'Squared: one'; newLine;
			nextPutAll: 'Raised to 3: one'; newLine; newLine;
			nextPutAll: 'Nr.: 2 '; newLine;
			nextPutAll: 'Value: two'; newLine;
		 	nextPutAll: 'Squared: four'; newLine;
			nextPutAll: 'Raised to 3: eight'; newLine; newLine;
			nextPutAll: 'Nr.: 3 '; newLine;
			nextPutAll: 'Value: three'; newLine;
		 	nextPutAll: 'Squared: nine'; newLine;
			nextPutAll: 'Raised to 3: twenty-seven'; newLine; newLine].
		
	self assert: formatter outStream contents equals: expectedString.
]

{ #category : #test }
ConsoleListFormatterTest >> testPrintRowValuesBy [

	formatter printRowValues: #('One' 'Two' 'Three') by: #(5 3 5).
	self assert: command outStream contents equals: (String streamContents: [:aStream | aStream nextPutAll: 'One  *Two*Three'; newLine]).
]