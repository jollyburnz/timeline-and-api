jQuery ->
	window.Timeline = {
		Model: {}
		Collection: {}
		View: {}
		Router: {}
	}

	class Timeline.Model.date extends Backbone.Model
		#url: 'https://api.github.com/users/jollyburnz'
		initialize: ->
			console.log('model was here')
		###
		parse: (resp) ->
			#console.log(resp)
			"startDate": resp.time
			"headline": resp.name
			"text": resp.description
			"assets": {
				"media": resp.photo_url
			}
		###

	class Timeline.Collection.timeline extends Backbone.Collection
		model: Timeline.Model.date
		url: "https://api.meetup.com/events?key=e65a3a6c7f5b2daf1b615c7c3846&sign=true&group_id=1768544&page=20"
		initialize: ->
			console.log('collection was here')
		parse: (resp) ->
			resp.results

	
	class Timeline.View.Viewer extends Backbone.View
		el: 'body'
		initialize: ->
			$(@el).append "<div id='timeline'></div>"
			$('#timeline').hide()
			$(@el).append "<a id='button' href='#'>Button</a>"
			#test = new Timeline.Collection.Events
			@render()
		render: ->
			#tests.fetch
				#dataType: 'jsonp'
				#success: ->
				#	console.log(tests.toJSON())
				#	console.log(tests)
				#error: ->
				#	console.log('fuck')
				
			#jsonData = "./data.json"
		showTimeline: ->
			$('#timeline').fadeIn()
			jsonData = "/test"
			timeline = new VMM.Timeline()
			timeline.init(jsonData)
		events: 
			"click #button": "showTimeline"
		

	#window.tests = new Timeline.Collection.timeline
	view = new Timeline.View.Viewer