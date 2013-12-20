
_ = require 'lodash'

settings = 
	constants:
		RADIUS_EARTH_KM: 6371
		MILES_PER_KM: 0.621371

module.exports = _.extend settings, (require './local/settings')