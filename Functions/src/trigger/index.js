
/**
 * The Trigger function is responsible for receiving data from the
 * web application and sending a message to Particle for a specific device.
 * @param {Object} context The context object is passed in via the Azure Functions
 * runtime.  It includes methods for responding to the user's request.
 * @param {Object} req The request object is passed in via the Azure Functions runtime.
 * It includes the HTTP request.
 */
module.exports = function trigger(context, req) {
  context.log(req.body);
  context.res = {
    status: 200,
  };
  context.done();
};
