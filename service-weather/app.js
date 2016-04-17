'use strict';

const Hapi = require('hapi');
const Good = require('good');
const Forecast = require('forecast');

const forecast = new Forecast({
  service: 'forecast.io',
  key: 'c7af59b0d3844affcd40b5697bf7d111',
  units: 'celcius',
  cache: false
});

// Create a server with a host and port
const server = new Hapi.Server();
server.connection({
    host: '0.0.0.0',
    port: process.env.NODE_PORT || 8003
});

// Add the route
server.route({
    method: 'GET',
    path:'/weather',
    handler: function (request, reply) {
      const lat = request.query.lat;
      const lon = request.query.lon;

      if (!lat || !lon) {
        return reply({
          err: 'Missing lat and lon arguments'
        }).code(404);
      }

      forecast.get([lat, lon], function(err, weather) {
        if (err) {
          return reply(err).code(404);
        }
        return reply(weather.currently).code(200);
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
