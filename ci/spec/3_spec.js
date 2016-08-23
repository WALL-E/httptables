var frisby = require('frisby');

frisby.create('case-3-1')
  .get('http://127.0.0.1:8000/test/origin')
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-3-2')
  .get('http://127.0.0.1:8000/test/user')
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-3-3')
  .get('http://127.0.0.1:8000/test/device')
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-3-4')
  .get('http://127.0.0.1:8000/test/origin')
  .addHeader('X-User-ID', 'user_1') 
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-3-5')
  .get('http://127.0.0.1:8000/test/user')
  .addHeader('X-User-ID', 'user_1') 
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-3-6')
  .get('http://127.0.0.1:8000/test/device')
  .addHeader('X-User-ID', 'user_1') 
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();
