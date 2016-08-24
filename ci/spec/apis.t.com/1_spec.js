var frisby = require('frisby');
var config = require('../config');

frisby.create('api.t.com-case-1-1')
  .get(config.httptables_url)
  .addHeader('host', 'apis.t.com')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.t.com-case-1-2')
  .get(config.httptables_url + 'test/user')
  .addHeader('host', 'apis.t.com')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.t.com-case-1-3')
  .get(config.httptables_url + 'test/device')
  .addHeader('host', 'apis.t.com')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.t.com-case-1-4')
  .get(config.httptables_url + 'test/origin')
  .addHeader('host', 'apis.t.com')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

