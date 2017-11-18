const chai = require('chai');
const chaiHttp = require('chai-http');

chai.use(chaiHttp);
const { expect } = chai;
const app = 'https://groot-function.azurewebsites.net/api/HttpTriggerJS1?code=T8OkaZeEjox8FA78sxfGNal4tR0wzspFeE/1E9AtaE2RgTFGcMA2kQ==';

describe('Azure Function: Data Tests', () => {
  it('Should return a 200 status code when provided a proper body.', () => {
    chai.request(app)
      .post('/')
      .send({})
      .end((err, res) => {
        expect(err).to.be.null;
        expect(res).to.have.status(200);
      });
  });
});
