var frisby = require('frisby');
var config = require('./config');

frisby.create('case-3-1')
  .get("http://{httptables}:8000/test/origin".format(config))
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-3-2')
  .get("http://{httptables}:8000/test/user".format(config))
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-3-3')
  .get("http://{httptables}:8000/test/device".format(config))
  .addHeader('X-Device-ID', 'device_1')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-3-4')
  .get("http://{httptables}:8000/test/origin".format(config))
  .addHeader('X-User-ID', 'user_1') 
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-3-5')
  .get("http://{httptables}:8000/test/user".format(config))
  .addHeader('X-User-ID', 'user_1') 
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

frisby.create('case-3-6')
  .get("http://{httptables}:8000/test/device".format(config))
  .addHeader('X-User-ID', 'user_1') 
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();
