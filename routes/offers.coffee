models = require '../models'
helpers = require '../helpers'

exports.setup = (app, conn, passport) ->

	app.get '/offers', helpers.requireUser, (req, res) ->
		res.render 'offers.jade'
