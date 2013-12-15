models = require '../models'
helpers = require '../helpers'

exports.setup = (app, conn, passport) ->

	app.get '/', (req, res) ->
		res.render 'home.jade'

	app.get '/requests', helpers.requireUser, (req, res) ->
		res.render 'requests.jade'

	app.get '/offers', helpers.requireUser, (req, res) ->
		res.render 'offers.jade'

	app.get '/profile', helpers.requireUser, (req, res) ->
		res.render 'profile.jade'

	app.post '/profile', helpers.requireUser, (req, res) ->
		req.flash 'success', 'Profile updated (NOT!)'
		res.redirect '/profile'