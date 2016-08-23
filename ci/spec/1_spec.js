var frisby = require('frisby');

frisby.create('case-1-1')
  .get('http://127.0.0.1:8000/')
  .addHeader('host', 'apis.t.com')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('case-1-2')
  .get('http://127.0.0.1:8000/test/user')
  .addHeader('host', 'apis.t.com')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('case-1-3')
  .get('http://127.0.0.1:8000/test/device')
  .addHeader('host', 'apis.t.com')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

frisby.create('case-1-4')
  .get('http://127.0.0.1:8000/test/origin')
  .addHeader('host', 'apis.t.com')
  .expectStatus(200)
  .expectJSON({
        status: 400,
  })
.toss();

