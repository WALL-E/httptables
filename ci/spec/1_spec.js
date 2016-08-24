var frisby = require('frisby');
var config = require('./config');

frisby.create('case-1-1')
  .get(config.httptables_url)
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-1-2')
  .get(config.httptables_url + 'test/user')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-1-3')
  .get(config.httptables_url + 'test/device')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-1-4')
  .get(config.httptables_url + 'test/origin')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

