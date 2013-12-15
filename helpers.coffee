
models = require './models'

exports.requireUser = (req, res, next) ->
	if req.user
		next()
	else
		req.flash 'warn', 'Please log in first'
		res.redirect '/login'
