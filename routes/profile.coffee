models = require '../models'
helpers = require '../helpers'

exports.setup = (app, conn, passport) ->

	app.get '/profile', helpers.requireUser, (req, res) ->
		res.render 'profile.jade'

	app.post '/profile', helpers.requireUser, (req, res) ->
		{email, firstName, lastName, latitude, longitude} = req.body
		req.user.update
			email: email
			firstName: firstName
			lastName: lastName
			geo: [longitude, latitude]
		, (err, user) ->
			if err
				console.error err
				req.flash 'error', 'problem!!'
			else
				req.flash 'success', 'Profile updated!'
			res.redirect '/profile'