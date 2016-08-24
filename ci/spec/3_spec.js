var frisby = require('frisby');
var config = require('./config');

frisby.create('case-3-1')
  .get(config.httptables_url + 'test/origin')
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-3-2')
  .get(config.httptables_url + 'test/user')
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-3-3')
  .get(config.httptables_url + 'test/device')
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-3-4')
  .get(config.httptables_url + 'test/origin')
  .addHeader('X-User-ID', 'user_1') 
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-3-5')
  .get(config.httptables_url + 'test/user')
  .addHeader('X-User-ID', 'user_1') 
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-3-6')
  .get(config.httptables_url + 'test/device')
  .addHeader('X-User-ID', 'user_1') 
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();
