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
                item.title = req.body.title; // SUBTHIS and below
                item.attr01 = req.body.attr01;
                item.attr02 = req.body.attr02;
                item.attr03 = req.body.attr03;
                item.save().then(function(item) {
                    res.json(item);
                });
            }
        });
    });

    app.post('/api/items', function (req, res) {
        Item.create({
            title: req.body.title, // SUBTHIS and below
            attr01: req.body.attr01,
            attr02: req.body.attr02,
            attr03: req.body.attr03,
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
        res.sendFile(__dirname + '/public/index.html'); 
    });
};