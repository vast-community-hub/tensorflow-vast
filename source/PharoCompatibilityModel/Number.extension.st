Extension {
	#name : 'Number'
}

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Pharo-API'] }
Number >> adaptToCollection: rcvr andSend: selector [
	"If I am involved in arithmetic with a Collection, return a Collection of
	the results of each element combined with me in that expression."

	^ rcvr collect: [:element | element perform: selector with: self]
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Not categorized'] }
Number >> asFloat [

	self subclassResponsibility
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Not categorized'] }
Number >> closeTo: num [
	"Tell whether the receiver and arguments are close from each."

	num isFloat ifTrue: [^num closeTo: self asFloat].
	^self = num
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Not categorized'] }
Number >> closeTo: num precision: aPrecision [
	"are these two numbers close?"

	num isFloat ifTrue: [ ^ num closeTo: self asFloat precision: aPrecision ].
	^self = num 
]
