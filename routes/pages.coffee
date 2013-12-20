async = require 'async'

models = require '../models'
helpers = require '../helpers'
{requireUser, or500} = helpers

exports.setup = (app, conn, passport) ->

	app.get '/', (req, res) ->
		if req.user?
			async.parallel [
				(done) ->
					helpers.geoNear models.Request, req.user.geo, done
				(done) ->
					helpers.geoNear models.Offer, req.user.geo, done
			], or500 res, (data) ->

				# make really small distances go to zero
				[requestsNear, offersNear] = data.map (d) ->
					d.results = d.results.map (r) -> 
						r.dis = if r.dis >= 0.01 then r.dis else 0
						return r
					return d
					
				res.render 'dashboard.jade',
					requestsNear: requestsNear.results
					offersNear: offersNear.results
		else
			res.render 'home.jade'
