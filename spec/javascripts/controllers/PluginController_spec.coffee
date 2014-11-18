describe "PluginController", ->
	scope 			= null
	ctrl 				= null
	routeParams = null
	httpBackend = null
	flash				= null
	pluginId 		= 42

	fakePlugin 	= 
		id: pluginId
		name: "Mountaineous Red Mountain"
		description: "Makes the Red Mountain more edgy and high"

	setupController =(pluginExists=true)->
		inject(($location, $routeParams, $rootScope, $httpBackend, $controller, _flash_)->
			scope 			= $rootScope.$new()
			location 		= $location
			httpBackend = $httpBackend
			routeParams = $routeParams
			routeParams.pluginId = pluginId
			flash = _flash_

			request = new RegExp("\/plugins/#{pluginId}")
			results = if pluginExists
				[200, fakePlugin]
			else
				[404]

			httpBackend.expectGET(request).respond(results[0], results[1])

			ctrl = $controller('PluginController', $scope: scope)
		)

	beforeEach(module('mwTreasury'))

	afterEach ->
		httpBackend.verifyNoOutstandingExpectation()
		httpBackend.verifyNoOutstandingRequest()

	describe 'controller initialization', ->
		describe 'plugin is found', ->
			beforeEach(setupController())
			it 'loads the given plugin', ->
				httpBackend.flush()
				expect(scope.plugin).toEqualData(fakePlugin)
		describe 'plugin is not found', ->
			beforeEach(setupController(false))
			it 'loads the given recipe', ->
				httpBackend.flush()
				expect(scope.plugin).toBe(null)
				expect(flash.error).toBe("There is no plugin with ID #{pluginId}")