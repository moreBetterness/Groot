const { Connection } = require('tedious');
const { response } = require('../common');

// Configuration for the database.
const config = {
  userName: 'grootadmin',
  password: 'Groot1iot',
  server: 'grootserver.database.windows.net',
  options: {
    database: 'grootdb',
    encrypt: true,
  },
};

/**
 * The Data function is responsible for receiving data from the
 * Particle WebHook and storing it in the appropriate SQL Server Table.
 * @param {Object} context The context object is passed in via the Azure Functions
 * runtime.  It includes methods for responding to the user's request.
 * @param {Object} req The request object is passed in via the Azure Functions runtime.
 * It includes the HTTP request.
 */
module.exports = function data(context, req) {
  context.log(req.body);

  // Create the connection to the database.
  const connection = new Connection(config);

  // Listen for the connection to be established.
  connection.on('connect', (err) => {
    // Failed to connect.
    if (err) {
      context.res = response(false, 500, 'Failed to Connect');
      context.done();
    // Connected
    } else {
      context.res = response(true, 200, 'Successfull Connected.');
      context.done();
    }
  });
};

