# _ = require 'lodash'
# bcrypt = require 'bcrypt'
# mongoose = require 'mongoose'

# settings = 	require './local/settings'

# tinyid = (objectid) ->
# 	objectid.substring(0, 8)

# geo = 
# 	geo: { type: [Number], index: '2dsphere' }

# thing = _.assign geo,
# 	user_id: String
# 	name: String
# 	description: String

# request = new mongoose.Schema _.assign thing, {}
# offer = new mongoose.Schema _.assign thing, {}

# user = new mongoose.Schema _.assign geo,
# 	email: String
# 	firstName: String
# 	lastName: String
# 	password: String
# 	googleId: String
# 	googleToken: String


# user.methods.addRequest = (request, callback) ->
# 	models.Request.create
# 		user_id: this.id
# 		name: request.name
# 		description: request.description
# 		geo: this.geo
# 	, callback

# user.methods.addOffer = (offer, callback) ->
# 	models.Offer.create
# 		user_id: this.id
# 		name: offer.name
# 		description: offer.description
# 		geo: this.geo
# 	, callback

# for s in [user, request, offer]
# 	s.virtual('tinyid').get -> tinyid(this.id)

# exports.user = user
# exports.request = request
# exports.offer = offer