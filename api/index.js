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
router.post('/request-update', function(req, res) {
    var rcon = Rcon({
        address: 'localhost',
        password: process.env.SRCDS_RCONPW,
    });

    rcon.connect().then(function() {
        rcon.command(`say [BOT] New server version detected.`);
        rcon.command(`say [BOT] new: ${req.body.message}, current: ${process.env.VERSION}`);
        rcon.command(`say [BOT] restarting on next map...`);
    }).catch(console.error);

    res.send(200);
})

// TODO; secure with HTTPS
app.use('/api/v1/', router);
app.listen(55555);
