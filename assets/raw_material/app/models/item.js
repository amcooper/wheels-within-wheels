var mongoose = require('mongoose');

var itemSchema = new mongoose.Schema({
	attr0: DataType0,
	attr1: DataType1,
	attr2: DataType2
});

module.exports = mongoose.model('Item', itemSchema);