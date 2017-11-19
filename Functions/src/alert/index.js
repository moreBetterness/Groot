const Twilio = require('twilio');
const { response } = require('../common');
const {
  twilioKey,
  twilioSid,
  telephoneTo,
  telephoneFrom,
} = require('../../env');

const client = new Twilio(twilioSid, twilioKey);

/**
 * The Trigger function is responsible for receiving data from the
 * Particle WebHook and sending it to the user via SMS.
 * @param {Object} context The context object is passed in via the Azure Functions
 * runtime.  It includes methods for responding to the user's request.
 * @param {Object} req The request object is passed in via the Azure Functions runtime.
 * It includes the HTTP request.
 */
module.exports = function data(context, req) {
  context.log(req.body);
  // Create the SMS and send it.
  client.messages.create({
    body: 'Your Groot Sensor Moisture Levels are Elevated.',
    to: telephoneTo, // Text this number
    from: telephoneFrom, // From a valid Twilio number
  })
    .then((message) => {
      context.log(message.sid);
      context.res = response(true, 200, 'Sent Alert');
      context.done();
    })
    .catch((err) => {
      context.log(err);
      context.res = response(false, 500, 'Failed to Send Alert');
      context.done();
    });
};
