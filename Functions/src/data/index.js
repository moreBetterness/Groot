const azure = require('azure-storage');
const uuid = require('uuid');
const moment = require('moment');
const { response } = require('../common');

const entGen = azure.TableUtilities.entityGenerator;

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
  try {
    const tableService = azure.createTableService('DefaultEndpointsProtocol=https;AccountName=grootsto;AccountKey=YoJkh87E2Q5G1tPhEf2k0FzJPmjp3GpvgZ6Sl7w8xhn9r94XtF8gfDRmpLHT2bdYGRfJcelZKAr1cdivgZ4mUg==;EndpointSuffix=core.windows.net');
    const task = {
      PartitionKey: entGen.String('0'),
      RowKey: entGen.String(uuid()),
      Timestamp: entGen.DateTime(moment.now()),
      Message: entGen.String(JSON.stringify(req.body)),
    };
    tableService.insertEntity('sensordata', task, (error) => {
      if (!error) {
        context.res = response(false, 200, 'Stored');
        context.done();
      } else {
        context.res = response(false, 500, 'Failed to Store');
        context.done();
      }
    });
  } catch (err) {
    context.res = response(false, 500, 'Failed to Connect');
    context.done();
  }
};

