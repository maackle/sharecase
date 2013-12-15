
mongoose = require 'mongoose'
schema = require './schema'

exports.User = mongoose.model 'User', schema.user, 'users'
exports.Request = mongoose.model 'Request', schema.request, 'requests'
exports.Offer = mongoose.model 'Offer', schema.offer, 'offers'