var frisby = require('frisby');
var config = require('../config');

frisby.create('api.z.com-case-1-1')
  .get("http://{httptables}:8001/".format(config))
  .addHeader('host', 'apis.z.com')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.z.com-case-1-2')
  .get("http://{httptables}:8001/test/user".format(config))
  .addHeader('host', 'apis.z.com')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.z.com-case-1-3')
  .get("http://{httptables}:8001/test/device".format(config))
  .addHeader('host', 'apis.z.com')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.z.com-case-1-4')
  .get("http://{httptables}:8001/test/origin".format(config))
  .addHeader('host', 'apis.z.com')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

