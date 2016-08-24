var frisby = require('frisby');
var config = require('../config');

frisby.create('api.z.com-case-3-1')
  .get('http://127.0.0.1:8001/test/origin')
  .addHeader('host', 'apis.z.com')
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.z.com-case-3-2')
  .get('http://127.0.0.1:8001/test/user')
  .addHeader('host', 'apis.z.com')
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.z.com-case-3-3')
  .get('http://127.0.0.1:8001/test/device')
  .addHeader('host', 'apis.z.com')
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 4103,
  })
.toss();

frisby.create('api.z.com-case-3-4')
  .get('http://127.0.0.1:8001/test/origin')
  .addHeader('host', 'apis.z.com')
  .addHeader('X-User-ID', 'user_1') 
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.z.com-case-3-5')
  .get('http://127.0.0.1:8001/test/user')
  .addHeader('host', 'apis.z.com')
  .addHeader('X-User-ID', 'user_1') 
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('api.z.com-case-3-6')
  .get('http://127.0.0.1:8001/test/device')
  .addHeader('host', 'apis.z.com')
  .addHeader('X-User-ID', 'user_1') 
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();
