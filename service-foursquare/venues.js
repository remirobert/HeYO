'use strict';

const Q = require('q');

const foursquare = require('node-foursquare-venues')(
  'AREWTY4KWJEDLALROY0VZWTJ5XFTCITLH2LXZU3WP2OJ1MQW',
  'M2JLJHXBY2CO2V1F05XZMCH3U143BO5MTFDK3MRV0WB5DSG0'
);

const getPictureVenue = function(venue) {
  return new Promise(function(fulfill, reject) {
    foursquare.venues.photos(venue.id, {group: "venue"}, function(err, resp) {
      if (err) {
        reject(err);
      }
      else {
        const responsePicture = resp.response.photos;
        console.log(responsePicture);
        fulfill({
          venue: venue,
          pictures: responsePicture.items
        });
      }
    });
  });
}

const searchVenues = function(lat, lon) {
  const param = lat + ',' + lon;

  return new Promise(function(fulfill, reject) {
    foursquare.venues.search({ll: param, radius: 20}, function(err, resp) {
      if (err) {
        reject(err);
      }
      const venues = resp.response.venues
      const promises = venues.map(function(venue) {
        return getPictureVenue(venue);
      });

      Q.all(promises).then(function(result) {
        fulfill(result);
      })
      .catch(function(err) {
        reject(err);
      });
    });
  });
}

module.exports.search = searchVenues;
