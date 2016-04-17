'use strict';

const Hapi = require('hapi');
const Good = require('good');
const ig = require('instagram-node').instagram();

ig.use({ client_id: 'f2d80cb6f512485bbd8dd449d25bd187',
         client_secret: '93786c55caf140ccb59a02dd1501c4dc' });

// Create a server with a host and port
const server = new Hapi.Server();
server.connection({
    host: '0.0.0.0',
    port: process.env.NODE_PORT || 8004
});

// Add the route
server.route({
    method: 'GET',
    path:'/instagram',
    handler: function (request, reply) {
      const lat = request.query.lat;
      const lon = request.query.lon;

      if (!lat || !lon) {
        return reply({
          err: 'Missing lat and lon arguments'
        }).code(404);
      }

      console.log("lat : " + Number(lat));
      console.log("lon : " + Number(lon));

      ig.media_search(Number(lat), Number(lon),  { distance: 100 }, function(err, medias, remaining, limit) {
        if (err) {
          console.log("err : " + err);
          return reply(err).code(401);
        }
        const images = medias.map(function(media) {
          return {
            text: media.caption.text,
            images: media.images
          }
        });
        return reply(images).code(200);
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
