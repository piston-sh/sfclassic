// NOTE: This runs on nodejs 4.2.6

var express = require('express');
var bodyParser = require('body-parser');
var app = express();
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var router = express.Router();
router.get('/version', function(req, res) {
    res.json({
        os: 'ubuntu-16.04',
        build: process.env.VERSION,
    });
});

var Rcon = require('srcds-rcon');
router.post('/command', function(req, res) {
    var rcon = Rcon({
        address: 'localhost',
        password: req.body.password,
    });

    rcon.connect().then(function() {
        rcon.command(req.body.command)
            .catch(console.error);
    }).catch(console.error);

    res.send(200);
})

// TODO; secure with HTTPS
app.use('/api/v1/', router);
app.listen(80);
