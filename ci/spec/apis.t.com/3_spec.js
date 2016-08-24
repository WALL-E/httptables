var frisby = require('frisby');
var config = require('../config');

frisby.create('api.t.com-case-3-1')
  .get(config.httptables_url + 'test/origin')
  .addHeader('host', 'apis.t.com')
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.t.com-case-3-2')
  .get(config.httptables_url + 'test/user')
  .addHeader('host', 'apis.t.com')
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.t.com-case-3-3')
  .get(config.httptables_url + 'test/device')
  .addHeader('host', 'apis.t.com')
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 4003,
  })
.toss();

frisby.create('api.t.com-case-3-4')
  .get(config.httptables_url + 'test/origin')
  .addHeader('host', 'apis.t.com')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.t.com-case-3-5')
  .get(config.httptables_url + 'test/user')
  .addHeader('host', 'apis.t.com')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.t.com-case-3-6')
  .get(config.httptables_url + 'test/device')
  .addHeader('host', 'apis.t.com')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();
