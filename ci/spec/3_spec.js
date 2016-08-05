var frisby = require('frisby');

frisby.create('origin')
  .get('http://127.0.0.1:8000/test/origin')
  .addHeader('X-Device-ID', 'device_1')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 4001,
  })
.toss();

frisby.create('origin')
  .post('http://127.0.0.1:8000/test/origin')
  .addHeader('X-Device-ID', 'device_1')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 4001,
  })
.toss();

frisby.create('origin')
  .put('http://127.0.0.1:8000/test/origin')
  .addHeader('X-Device-ID', 'device_1')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

