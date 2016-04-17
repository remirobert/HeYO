'use strict';

const Hapi = require('hapi');
const Good = require('good');
const venues = require('./venues');

// Create a server with a host and port
const server = new Hapi.Server();
server.connection({
    host: '0.0.0.0',
    port: process.env.NODE_PORT || 8002
});

// Add the route
server.route({
    method: 'GET',
    path:'/venues',
    handler: function (request, reply) {
      const lat = request.query.lat;
      const lon = request.query.lon;

      if (!lat || !lon) {
        return reply({
          err: 'Missing lat and lon arguments'
        }).code(404);
      }

      venues.search(lat, lon).then(function(venues) {
        return reply(venues).code(200);
      })
      .catch(function(err) {
        return reply(err).code(401);
      });
    }
});

// Start the server
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
