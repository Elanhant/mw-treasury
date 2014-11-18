describe "PluginController", ->
	scope 			= null
	ctrl 				= null
	routeParams = null
	httpBackend = null
	flash				= null
	location		= null
	pluginId 		= 42

	fakePlugin 	= 
		id: pluginId
		name: "Mountaineous Red Mountain"
		description: "Makes the Red Mountain more edgy and high"

	setupController =(pluginExists=true,pluginId=42)->
		inject(($location, $routeParams, $rootScope, $httpBackend, $controller, _flash_)->
			scope 			= $rootScope.$new()
			location 		= $location
			httpBackend = $httpBackend
			routeParams = $routeParams
			routeParams.pluginId = pluginId if pluginId
			flash = _flash_

			if pluginId
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
			it 'loads the given plugin', ->
				httpBackend.flush()
				expect(scope.plugin).toBe(null)
				expect(flash.error).toBe("There is no plugin with ID #{pluginId}")

	describe 'create', ->
		newPlugin = 
			id: 42
			name: 'Better Almalexia'
			description: 'Improves Almalexia\'s appearance, making her look up to Better Bodies standart'

		beforeEach ->
			setupController(false,false)
			request = new RegExp("\/plugins")
			httpBackend.expectPOST(request).respond(201, newPlugin)

		it 'posts to the backend', ->
			scope.plugin.name = newPlugin.name
			scope.plugin.description = newPlugin.description
			scope.save()
			httpBackend.flush()
			expect(location.path()).toBe("/plugins/#{newPlugin.id}")

	describe 'update', ->
		updatedPlugin = 
			name: 'Morrowind Graphic Extender'
			description: 'Overhauls graphics - distant land, shaders support, antialaising'

		beforeEach ->
			setupController()
			httpBackend.flush()
			request = new RegExp("\/plugins")
			httpBackend.expectPUT(request).respond(204)

		it 'posts to the backend', ->
			scope.plugin.name = updatedPlugin.name
			scope.plugin.description = updatedPlugin.description
			scope.save()
			httpBackend.flush()
			expect(location.path()).toBe("/plugins/#{scope.plugin.id}")

	describe 'delete', ->
		beforeEach ->
			setupController()
			httpBackend.flush()
			request = new RegExp("\/plugins/#{scope.plugin.id}")
			httpBackend.expectDELETE(request).respond(204)

		it 'posts to the backend', ->
			scope.delete()
			httpBackend.flush()
			expect(location.path()).toBe("/")

