'use strict';

const Hapi = require('hapi');
const Good = require('good');
const geocoder = require('geocoder');

// Create a server with a host and port
const server = new Hapi.Server();
server.connection({
    host: '0.0.0.0',
    port: process.env.NODE_PORT || 8001
});

// Add the route
server.route({
    method: 'GET',
    path:'/geo',
    handler: function (request, reply) {
      const lat = request.query.lat;
      const lon = request.query.lon;

      if (!lat || !lon) {
        return reply({
          err: 'Missing lat and lon arguments'
        }).code(404);
      }
      geocoder.reverseGeocode(Number(lat), Number(lon), function ( err, data ) {
        if (err) {
          return reply({err}).code(401);
        }
        const formattedAddr = data.results.map(function(component) {
          return component.formatted_address
        });
        return reply(formattedAddr).code(200);
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
