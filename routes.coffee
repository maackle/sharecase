async = require 'async'

models = require './models'
helpers = require './helpers'

exports.setup = (app, conn, passport) ->

	(require './routes/pages').setup app, conn, passport
	(require './routes/requests').setup app, conn, passport
	(require './routes/offers').setup app, conn, passport
	(require './routes/profile').setup app, conn, passport
	(require './routes/auth').setup app, conn, passport

	app.get '/dev/load-fixtures', (req, res) ->
		async.parallel [
			(done) -> conn.collection('users').remove done
			(done) -> conn.collection('requests').remove done
			(done) -> conn.collection('offers').remove done
		], (err, data) ->
			console.log 'cleared all collections'

			locations =
				michael: 	[-122.609007, 45.501890]
				erin: 		[-122.623148, 45.494656]
				jerry:		[-122.639208, 45.564443]
				kym:		[-122.633908, 45.555624]

			items = """
				Oaken Staff
				Kiddie Pool
				Garden Hose
				Beanbag
				Potato Gun
				Yo-yo
				Table
				6-string bass
				Bicycle
			""".split(/\n/)

			userFixtures = [
				{
					email: 'maackle.d@gmail.com'
					password: 'sam1am'
					geo: locations.michael
				}
				{
					email: 'erineroyburger@gmail.com'
					password: '123456'
					geo: locations.erin
				}
				{
					email: 'jerry@tess.com'
					password: '123456'
					geo: locations.jerry
				}
				{
					email: 'kym@kline.com'
					password: '123456'
					geo: locations.kym
				}
			]
			
			models.User.create userFixtures, (err, users...) ->
				console.log 'created ' + users.length + ' new users'

				for item in items
					user = helpers.arrayRand(users)
					addee = name: item
					cb = (err) -> if err? then console.error "couldn't create item: ", item, " because: ", err
					if Math.random() < 0.5
						adder = user.addRequest addee, cb
					else 
						adder = user.addOffer addee, cb
					console.log item, " -> ", user.email
				console.log "*** done adding items"

				res.json
					message: 'loaded fixtures'
