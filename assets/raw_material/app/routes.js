var Item = require('./models/item');

function getItems(res) {
    Item.find(function (err, items) {
        if (err) {
            res.send(err);
        }
        res.json(items); 
    });
};

module.exports = function (app) {
    app.get('/api/items', function (req, res) {
        getItems(res);
    });

    app.get('/api/items/:item_id', function (req, res) {
        Item.findById(req.params.item_id, function (err, item) {
            if (err)
                res.send(err);
            res.json(item);
        });
    });

    app.put('/api/items/:item_id', function (req, res) {
        Item.findById(req.params.item_id, function (err, item) {
            if (err) {
                res.send(err);
            } else {
                item.attr0 = req.body.attr0;
                item.attr1 = req.body.attr1;
                item.attr2 = req.body.attr2;
                item.save().then(function(item) {
                    res.json(item);
                });
            }
        });
    });

    app.post('/api/items', function (req, res) {
        Item.create({
            attr0: req.body.attr0,
            attr1: req.body.attr1,
            attr2: req.body.attr2,
            done: false
        }, function (err, item) {
            if (err)
                res.send(err);
            res.json(item);
        });
    });

    app.delete('/api/items/:item_id', function (req, res) {
        Item.remove({
            _id: req.params.item_id
        }, function (err, item) {
            if (err)
                res.send(err);
            res.json(item);

        });
    });

    app.get('*', function (req, res) {
        res.sendFile(__dirname + '../public/index.html'); 
    });
};