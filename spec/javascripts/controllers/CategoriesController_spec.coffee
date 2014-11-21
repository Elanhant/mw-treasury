describe "CategoriesController", ->
	scope = null
	ctrl = null
	location = null
	routeParams = null
	resource = null

	httpBackend = null

	setupController = ->
		inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
			scope = $rootScope.$new()
			location = $location
			resource = $resource
			routeParams = $routeParams

			httpBackend = $httpBackend

			ctrl = $controller('CategoriesController', $scope: scope, $location: location)
		)

	beforeEach(module("mwTreasury"))

	afterEach ->
		httpBackend.verifyNoOutstandingExpectation()
		httpBackend.verifyNoOutstantingRequest()