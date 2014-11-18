describe "PluginsController", ->
	scope 			= null
	ctrl 				= null
	location 		= null
	routeParams = null
	resource 		= null

	# access injected server later
	httpBackend = null

	setupController =(keywords, results)->
		inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
			scope 								= $rootScope.$new()
			location 							= $location
			resource 							= $resource
			routeParams 					= $routeParams
			routeParams.keywords 	= keywords

			#capture the injected server
			httpBackend = $httpBackend

			if results
				request = new RegExp("\/plugins.*keywords=#{keywords}")
				httpBackend.expectGET(request).respond(results)

			ctrl = $controller('PluginsController', $scope: scope, $location: location)
		)

	beforeEach(module("mwTreasury"))

	afterEach ->
		httpBackend.verifyNoOutstandingExpectation()
		httpBackend.verifyNoOutstandingRequest()

	describe 'controller initialization', ->
		describe 'when no keywords present', ->
			beforeEach(setupController())

			it 'defaults to no plugins', ->
				expect(scope.plugins).toEqualData([])

		describe 'with keywords', ->
			keywords = 'dagoth'
			plugins = [
				{
					id: 2, 
					name: 'Ashlander Tent'
				},
				{
					id: 4,
					name: 'Julan the Ashlander Companion'
				}
			]
			beforeEach ->
				setupController(keywords,plugins)
				httpBackend.flush()

			it 'calls the backend', ->
				expect(scope.plugins).toEqualData(plugins)

		describe 'search()', ->
			beforeEach ->
				setupController()

			it 'redirects to itself with a keyword param', ->
				keywords = 'dagoth'
				scope.search(keywords)
				expect(location.path()).toBe('/')
				expect(location.search()).toEqualData({keywords: keywords})