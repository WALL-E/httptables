var frisby = require('frisby');
var async = require('async');

async.series([
  
  function(callback){
    frisby.create('api.t.com-case-4-1')
      .get('http://127.0.0.1:8000/test/device')
      .addHeader('host', 'apis.t.com')
      .addHeader('X-Device-ID', 'device_1')
      .expectStatus(200)
      .expectJSON({
        status: 4003,
      })
      .inspectBody()
    .toss();
    callback(null, '1');
  },

  function(callback){
    frisby.create('api.t.com-case-4-2')
      .patch('http://172.28.32.105:8080/apis/role_types/1/', {
        enable: 0
       }, {json: true})
       .addHeader('Authorization', 'Token 5fcd69a386ae6e073e51edb941b367d703496f21')
       .expectStatus(200)
       .inspectBody()
    .toss();
    callback(null, '2');
  },

  function(callback){
    frisby.create('api.t.com-case-4-2')
      .get('http://127.0.0.1:8888/admin/notify')
      .expectStatus(200)
      .expectJSON({
        status: 200,
      })
      .inspectBody()
    .toss();
    callback(null, '1');
  },

  function(callback){
    frisby.create('api.t.com-case-4-3')
      .get('http://127.0.0.1:8000/test/device')
      .addHeader('host', 'apis.t.com')
      .addHeader('X-Device-ID', 'device_1')
      .expectStatus(200)
      .expectJSON({
        status: 200,
      })
      .inspectBody()
    .toss();
    callback(null, '3');
  },

  function(callback){
    frisby.create('api.t.com-case-4-4')
      .patch('http://172.28.32.105:8080/apis/role_types/1/', {
        enable: 1
      }, {json: true})
      .addHeader('Authorization', 'Token 5fcd69a386ae6e073e51edb941b367d703496f21')
      .expectStatus(200)
      .inspectBody()
    .toss();
    callback(null, '4');
  },

  function(callback){
    frisby.create('api.t.com-case-4-4')
      .get('http://127.0.0.1:8888/admin/notify')
      .expectStatus(200)
      .expectJSON({
        status: 200,
      })
      .inspectBody()
    .toss();
    callback(null, '4');
  },

  function(callback){
    frisby.create('api.t.com-case-4-5')
      .get('http://127.0.0.1:8000/test/device')
      .addHeader('host', 'apis.t.com')
      .addHeader('X-Device-ID', 'device_1')
      .expectStatus(200)
      .expectJSON({
        status: 4003,
      })
      .inspectBody()
    .toss();
    callback(null, '5');
  },

], function(error, result){
  console.log(result);
})
