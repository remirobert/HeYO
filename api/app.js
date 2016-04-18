'use strict';

const Hapi = require('hapi');
const Good = require('good');
const req = require('request');

const server = new Hapi.Server();
server.connection({
  host: '127.0.0.1',
  port: process.env.NODE_PORT || 8000
});

const io = require('socket.io')(server.listener);
require('./sockets')(io);

server.route({
    method: 'POST',
    path:'/geo',
    handler: function (request, reply) {

      const lat = request.params.lat;
      const lon = request.params.lon;

      if (!lat || !lon) {
        return reply({
          err: 'Missing lat and lon arguments'
        }).code(404);
      }

      req.get({url: 'http://127.0.0.1:8001/geo',
      qs: {lat: lat, lon: lon}},
      function(error, response, body) {
        if (!error && response.statusCode == 200) {
          return reply(body).code(200);
        }
        else {
          console.log(error);
          return reply({
            err: error
          }).code(401);
        }
      });
    }
});

// io.on('connection', function (socket) {
//   socket.on('location', function () {
//     socket.emit('geo', {'geo': 45.808});
//     socket.emit('venues', {'addr': "45.808"});
//     socket.emit('images', {'images': ['ok', 'kl']});
//     socket.emit('weather', {'weather': 32});
//   });
// });

server.register({
  register: Good,
  options: {
    reporters: [{
      reporter: require('good-console'),
      events: {
        response: '*',
        log: '*'
      }
    }]
  }
}, (err) => {
  if (err) {
    throw err;
  }
  server.start((err) => {
    if (err) {
      throw err;
    }
    server.log('info', 'Server running at: ' + server.info.uri);
  });
});
