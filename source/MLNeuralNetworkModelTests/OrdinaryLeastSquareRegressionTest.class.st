Class {
	#name : 'OrdinaryLeastSquareRegressionTest',
	#superclass : 'TestCase',
	#category : 'MLNeuralNetworkModelTests'
}

{ #category : 'Tests' }
OrdinaryLeastSquareRegressionTest >> testPredict [

	| x y betas |

	x := TFTensor fromFloats: #((1 2 3) (6 7 8) (4 5 6) (9 2 3) (1 10 2)).
	y := TFTensor fromFloats: #((14) (44) (32) (22) (27)).

	betas := (OrdinaryLeastSquareRegression new findWeightsThatFits: x toPredict: y) allFloats.
	self
		assert: (betas first closeTo: 1);
		assert: (betas second closeTo: 2);
		assert: (betas third closeTo: 3)



]
