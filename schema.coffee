
bcrypt = require 'bcrypt'
mongoose = require 'mongoose'

settings = 	require './local/settings'

request = new mongoose.Schema
	name: String
	description: String
	geo: { type: [Number], index: '2dsphere' }

offer = new mongoose.Schema
	name: String
	description: String
	geo: { type: [Number], index: '2dsphere' }

user = new mongoose.Schema
	email: String
	password: String
	googleId: String
	googleToken: String
	geo: { type: [Number], index: '2dsphere' }



user.methods.checkPassword = (password) ->
	"TODO"

exports.user = user
exports.request = request
exports.offer = offer