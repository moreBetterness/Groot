
/**
 * The Alert function is responsible for receiving data from the
 * Particle WebHook for the alert event and sending an SMS via the Twilio SDK.
 * @param {Object} context The context object is passed in via the Azure Functions
 * runtime.  It includes methods for responding to the user's request.
 * @param {Object} req The request object is passed in via the Azure Functions runtime.
 * It includes the HTTP request.
 */
module.exports = function data(context, req) {
  context.log(req.body);
  context.res = {
    status: 200,
  };
  context.done();
};

