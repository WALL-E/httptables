var frisby = require('frisby');
var config = require('../config');

frisby.create('api.z.com-case-2-1')
  .get("http://{httptables}:8001/test/origin".format(config))
  .addHeader('host', 'apis.z.com')
  .addHeader('X-Device-ID', 'device_1')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 4101,
  })
.toss();

frisby.create('api.z.com-case-2-2')
  .get("http://{httptables}:8001/test/user".format(config))
  .addHeader('host', 'apis.z.com')
  .addHeader('X-Device-ID', 'device_1')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 4102,
  })
.toss();

frisby.create('api.z.com-case-2-3')
  .get("http://{httptables}:8001/test/device".format(config))
  .addHeader('host', 'apis.z.com')
  .addHeader('X-Device-ID', 'device_1')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 4103,
  })
.toss();
