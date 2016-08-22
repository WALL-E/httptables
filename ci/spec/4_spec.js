var frisby = require('frisby');

frisby.create('user')
  .get('http://127.0.0.1:8000/test/user')
  .addHeader('X-Device-ID', 'device_1')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 4002,
  })
.toss();

frisby.create('user')
  .get('http://127.0.0.1:8000/test/user')
  .addHeader('X-Device-ID', 'device_1')
  .addHeader('X-User-ID', 'user_2')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();



frisby.create('user')
  .post('http://127.0.0.1:8000/test/user')
  .addHeader('X-Device-ID', 'device_1')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('user')
  .put('http://127.0.0.1:8000/test/user')
  .addHeader('X-Device-ID', 'device_1')
  .addHeader('X-User-ID', 'user_1')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('user')
  .post('http://127.0.0.1:8000/test/user')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

