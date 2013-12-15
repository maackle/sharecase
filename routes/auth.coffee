models = require '../models'

exports.setup = (app, conn, passport) ->

	app.get '/signup', (req, res) ->
		console.log res.locals.messages
		res.render('auth/signup.jade')

	app.post '/signup', (req, res) ->
		{email, password, password2} = req.body
		errors = []
		if not email
			errors.push 'email is required'

		if not password
			errors.push 'password is required'
		else if password.length < 6
			errors.push 'password must be at least 6 characters'

		if not password2 
			errors.push 'password2 is required'

		if password and password2 and password isnt password2
			errors.push 'passwords do not match'

		if errors.length
			for e in errors
				req.flash 'error', e
			res.redirect '/signup'
		else
			models.User.create
				email: email
				password: password
			, (err, user) ->
				req.flash 'success', 'You have signed up!  Now log in.'
				res.redirect '/login'

	app.get '/login', (req, res) ->
		res.render('auth/login.jade')

	app.post '/login', passport.authenticate 'local',
		successRedirect: '/'
		failureRedirect: '/login'
		failureFlash: true

	app.get '/logout', (req, res) ->
		req.logout()
		res.redirect '/'

	app.get '/auth/google', passport.authenticate 'google', scope: 'email'

	app.get '/auth/google/callback', passport.authenticate('google', failureRedirect: '/login'), (req, res) ->
		res.redirect('/')
