var frisby = require('frisby');

frisby.create('device')
  .get('http://127.0.0.1:8000/test/device')
  .addHeader('X-Device-ID', 'device_1')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('device')
  .post('http://127.0.0.1:8000/test/device')
  .addHeader('X-Device-ID', 'device_1')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 4003,
  })
.toss();

frisby.create('device')
  .post('http://127.0.0.1:8000/test/device')
  .addHeader('X-Device-ID', 'device_2')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('device')
  .put('http://127.0.0.1:8000/test/device')
  .addHeader('X-Device-ID', 'device_1')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

