

_ = require 'lodash'
mongoose = require 'mongoose'
bcrypt = require 'bcrypt'

settings = 	require './local/settings'

tinyid = (objectid) ->
	objectid.substring(0, 8)

geo = 
	geo: { type: [Number], index: '2dsphere' }

thing = _.assign geo,
	user_id: String
	name: String
	description: String

request = new mongoose.Schema _.assign thing, {}
offer = new mongoose.Schema _.assign thing, {}

user = new mongoose.Schema _.assign geo,
	email: String
	firstName: String
	lastName: String
	password: String
	googleId: String
	googleToken: String

for s in [user, request, offer]
	s.virtual('tinyid').get -> tinyid(this.id)

Request = mongoose.model 'Request', request, 'requests'
Offer = mongoose.model 'Offer', offer, 'offers'

user.methods.addRequest = (request, callback) ->
	console.assert this.id
	console.assert this.geo
	Request.create
		user_id: this.id
		name: request.name
		description: request.description
		geo: this.geo
	, callback

user.methods.addOffer = (offer, callback) ->
	Offer.create
		user_id: this.id
		name: offer.name
		description: offer.description
		geo: this.geo
	, callback

User = mongoose.model 'User', user, 'users'

exports.User = User
exports.Request = Request
exports.Offer = Offer