models = require '../models'
{requireUser, or500} = require '../helpers'

exports.setup = (app, conn, passport) ->

	app.get '/requests', requireUser, (req, res) ->
		# models.Request.find {user_id: req.user.id}, or500 res, (requests) ->
		models.Request.find or500 res, (requests) ->
			res.render 'requests.jade',
				allRequests: requests
				userRequests: requests.filter (r) -> r.user_id is req.user.id

	app.get '/requests/:id/edit', (req, res) ->
		{id} = req.params
		models.Request.findById id, or500 res, (request) ->
			res.render 'requests-edit.jade',
				request: request


	app.post '/requests', requireUser, (req, res) ->
		{name, description} = req.body
		req.user.addRequest
			name: name
			description: description
		, or500 res, (request) ->
			req.flash 'success', "added a request: #{ name }"
			res.redirect '/requests'

	app.post '/requests/:id/edit', (req, res) ->
		{id} = req.params
		models.Request.findByIdAndUpdate id, req.body, or500 res, (request) ->
			req.flash 'success', "<strong>#{ request.name }</strong> updated!"
			res.redirect '/requests'
