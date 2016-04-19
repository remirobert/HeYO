'use_strict!'

const request = require('request');
const Q = require('q');

const requests = [
  {
    query: "geo",
    port: 8001
  },
  {
    query: "venues",
    port: 8002
  },
  {
    query: "instagram",
    port: 8003
  },
  {
    query: "weather",
    port: 8004
  }
]

module.exports = function(io) {
  io.on('connection', function (socket) {

    var fetchData = function(lat, lon, req) {
      return new Promise(function(fulfill, reject) {
        request.get({url: 'http://127.0.0.1:' + req.port + '/' + req.query,
        qs: {lat: lat, lon: lon}},
        function(error, response, body) {
          console.log(response)
          console.log(body);
          if (!error && response.statusCode == 200) {
            fulfill(body);
          }
          else {
            reject(error);
          }
        });
      });
    }

    socket.on('location', function (location) {
      const lat  = location.lat;
      const lon  = location.lon;

      console.log("lat : " + lat);
      console.log("lon : " + lon);

      // request.get({url: 'http://127.0.0.1:8001/geo',
      // qs: {lat: lat, lon: lon}},
      // function(error, response, body) {
      //   console.log(response)
      //   console.log(body);
      //   if (!error && response.statusCode == 200) {
      //     socket.emit("geo", body);
      //   }
      //   else {
      //     reject(error);
      //   }
      // });

      requests.forEach(function(req) {
        fetchData(lat, lon, req).then(function(body) {
          socket.emit(req.query, body);
        });
      });

      // socket.emit('geo', {'geo': 45.808});
      // socket.emit('venues', {'addr': "45.808"});
      // socket.emit('images', {'images': ['ok', 'kl']});
      // socket.emit('weather', {'weather': 32});
    });
  });
}
