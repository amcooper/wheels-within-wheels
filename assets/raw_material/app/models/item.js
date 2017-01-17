var mongoose = require('mongoose');

var itemSchema = new mongoose.Schema({
	title: String, // SUBTHIS and below
	attr01: String,
	attr02: String,
	attr03: String
});

module.exports = mongoose.model('Item', itemSchema);