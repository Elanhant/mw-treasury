describe "PluginsController", ->
	scope 			= null
	ctrl 				= null
	location 		= null
	routeParams = null
	resource 		= null

	setupController =(keywords)->
		inject(($location, $routeParams, $rootScope, $resource, $controller)->
			scope 								= $rootScope.$new()
			location 							= $location
			resource 							= $resource
			routeParams 					= $routeParams
			routeParams.keywords 	= keywords

			ctrl = $controller('PluginsController', $scope: scope, $location: location)
		)

	beforeEach(module("mwTreasury"))
	beforeEach(setupController())

	it 'defaults to no plugins', ->
		expect(scope.plugins).toEqualData([])