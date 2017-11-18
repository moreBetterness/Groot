
/**
 * Format the reponse for a message to keep consistent.
 * @param {boolean} success The status of whether the operation succeeded.
 * @param {number} code The HTTP status code for the operation.
 * @param {string} message The message to send the caller.
 */
module.exports.response = (success, code, message) => {
  return {
    status: code,
    body: {
      message,
    },
  };
};
