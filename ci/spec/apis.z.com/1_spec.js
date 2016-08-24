var frisby = require('frisby');
var config = require('../config');

frisby.create('api.z.com-case-1-1')
  .get('http://127.0.0.1:8001/')
  .addHeader('host', 'apis.z.com')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.z.com-case-1-2')
  .get('http://127.0.0.1:8001/test/user')
  .addHeader('host', 'apis.z.com')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.z.com-case-1-3')
  .get('http://127.0.0.1:8001/test/device')
  .addHeader('host', 'apis.z.com')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.z.com-case-1-4')
  .get('http://127.0.0.1:8001/test/origin')
  .addHeader('host', 'apis.z.com')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

