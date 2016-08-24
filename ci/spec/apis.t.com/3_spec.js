var frisby = require('frisby');
var config = require('../config');

frisby.create('api.t.com-case-3-1')
  .get("http://{httptables}:8000/test/origin".format(config))
  .addHeader('host', 'apis.t.com')
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.t.com-case-3-2')
  .get("http://{httptables}:8000/test/user".format(config))
  .addHeader('host', 'apis.t.com')
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.t.com-case-3-3')
  .get("http://{httptables}:8000/test/device".format(config))
  .addHeader('host', 'apis.t.com')
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 4003,
  })
.toss();

frisby.create('api.t.com-case-3-4')
  .get("http://{httptables}:8000/test/origin".format(config))
  .addHeader('host', 'apis.t.com')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.t.com-case-3-5')
  .get("http://{httptables}:8000/test/user".format(config))
  .addHeader('host', 'apis.t.com')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.t.com-case-3-6')
  .get("http://{httptables}:8000/test/device".format(config))
  .addHeader('host', 'apis.t.com')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();
