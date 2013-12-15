models = require './models'

exports.setup = (app, conn, passport) ->

	(require './routes/pages').setup app, conn, passport
	(require './routes/auth').setup app, conn, passport
