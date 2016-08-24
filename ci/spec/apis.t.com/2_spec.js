var frisby = require('frisby');
var config = require('../config');

frisby.create('api.t.com-case-2-1')
  .get("http://{httptables}:8000/test/origin".format(config))
  .addHeader('host', 'apis.t.com')
  .addHeader('X-Device-ID', 'device_1')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 4001,
  })
.toss();

frisby.create('api.t.com-case-2-2')
  .get("http://{httptables}:8000/test/user".format(config))
  .addHeader('host', 'apis.t.com')
  .addHeader('X-Device-ID', 'device_1')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 4002,
  })
.toss();

frisby.create('api.t.com-case-2-3')
  .get("http://{httptables}:8000/test/device".format(config))
  .addHeader('host', 'apis.t.com')
  .addHeader('X-Device-ID', 'device_1')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 4003,
  })
.toss();
