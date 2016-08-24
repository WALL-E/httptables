var frisby = require('frisby');
var async = require('async');
var config = require('../config');

async.series([

  function(callback){
    frisby.create('apis.z.com-case-5-1-1')
      .patch('http://127.0.0.1:8080/apis/role_types/5/', {
        enable: 1
      }, {json: true})
      .addHeader('Authorization', 'Token 5fcd69a386ae6e073e51edb941b367d703496f21')
      .expectStatus(200)
      //.inspectBody()
    .toss();
    callback(null, '1');
  },

  function(callback){
    frisby.create('apis.z.com-case-5-1-2')
      .patch('http://127.0.0.1:8080/apis/role_types/4/', {
        optional: 1
      }, {json: true})
      .addHeader('Authorization', 'Token 5fcd69a386ae6e073e51edb941b367d703496f21')
      .expectStatus(200)
      //.inspectBody()
    .toss();
    callback(null, '2');
  },

  function(callback){
    frisby.create('apis.z.com-case-5-2')
      .get('http://127.0.0.1:8000/test/user')
      .addHeader('host', 'apis.z.com')
      .addHeader('X-User-ID', 'user_1')
      .expectStatus(200)
      .expectJSON({
        status: 4102,
      })
      //.inspectBody()
    .toss();
    callback(null, '3');
  },

  function(callback){
    frisby.create('apis.z.com-case-5-3')
      .patch('http://127.0.0.1:8080/apis/role_types/5/', {
        enable: 0
      }, {json: true})
      .addHeader('Authorization', 'Token 5fcd69a386ae6e073e51edb941b367d703496f21')
      .expectStatus(200)
      //.inspectBody()
    .toss();
    callback(null, '4');
  },

  function(callback){
    frisby.create('apis.z.com-case-5-4')
      .get('http://127.0.0.1:10983/admin/notify')
      .expectStatus(200)
      .expectJSON({
        status: 200,
      })
      //.inspectBody()
    .toss();
    callback(null, '6');
  },

  function(callback){
    frisby.create('apis.z.com-case-5-5')
      .get('http://127.0.0.1:8000/test/device')
      .addHeader('host', 'apis.z.com')
      .addHeader('X-User-ID', 'user_1')
      .expectStatus(200)
      .expectJSON({
        status: 200,
      })
      //.inspectBody()
    .toss();
    callback(null, '7');
  },

  function(callback){
    frisby.create('apis.z.com-case-5-6-1')
      .patch('http://127.0.0.1:8080/apis/role_types/5/', {
        enable: 1
      }, {json: true})
      .addHeader('Authorization', 'Token 5fcd69a386ae6e073e51edb941b367d703496f21')
      .expectStatus(200)
      //.inspectBody()
    .toss();
    callback(null, '8');
  },

  function(callback){
    frisby.create('apis.z.com-case-5-7')
      .get('http://127.0.0.1:10983/admin/notify')
      .expectStatus(200)
      .expectJSON({
        status: 200,
      })
      //.inspectBody()
    .toss();
    callback(null, '9');
  },

  function(callback){
    frisby.create('apis.z.com-case-5-8')
      .get('http://127.0.0.1:8000/test/user')
      .addHeader('host', 'apis.z.com')
      .addHeader('X-User-ID', 'user_1')
      .expectStatus(200)
      .expectJSON({
        status: 4102,
      })
      //.inspectBody()
    .toss();
    callback(null, '10');
  },

  function(callback){
    frisby.create('apis.z.com-case-5-6-2')
      .patch('http://127.0.0.1:8080/apis/role_types/4/', {
        optional: 0
      }, {json: true})
      .addHeader('Authorization', 'Token 5fcd69a386ae6e073e51edb941b367d703496f21')
      .expectStatus(200)
      //.inspectBody()
    .toss();
    callback(null, '11');
  },

], function(error, result){
  //console.log(result);
})
