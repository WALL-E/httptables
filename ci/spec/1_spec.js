var frisby = require('frisby');

frisby.create('默认策略是通过')
  .get('http://127.0.0.1:8000/')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();

