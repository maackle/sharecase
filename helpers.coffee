
models = require './models'
settings = require './settings'
{constants} = settings

throw500 = (res, err) ->
	console.error err
	if res
		res.status(500)
		res.render '500.jade',
			error: err

exports.randInt = (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

exports.arrayRand = (a) ->
	index = this.randInt(0, a.length - 1)
	a[index]

exports.requireUser = (req, res, next) ->
	if req.user
		next()
	else
		req.flash 'warn', 'Please log in first'
		res.redirect '/login'

exports.or500 = (res, fn) ->
	(err, obj) ->
		if err
			throw500 res, err
		else
			fn(obj)

exports.geoNear = (model, geo, callback) ->
	opts = 
		spherical: true
		distanceMultiplier: constants.RADIUS_EARTH_KM * constants.MILES_PER_KM
		# maxDistance: 10000
	[lon, lat] = geo
	model.collection.geoNear lon, lat, opts, callback
