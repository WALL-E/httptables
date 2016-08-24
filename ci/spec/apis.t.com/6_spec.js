var frisby = require('frisby');
var async = require('async');
var config = require('../config');

async.series([

  function(callback){
    frisby.create('api.t.com-case-5-1-1')
      .patch('http://{httptables_manager}:8080/apis/role_types/1/'.format(config), {
        optional: 0
      }, {json: true})
      .addHeader('Authorization', 'Token 5fcd69a386ae6e073e51edb941b367d703496f21')
      .expectStatus(200)
      //.inspectBody()
    .toss();
    callback(null, '1');
  },

  function(callback){
    frisby.create('api.t.com-case-5-1-2')
      .patch('http://{httptables_manager}:8080/apis/role_types/2/'.format(config), {
        optional: 0
      }, {json: true})
      .addHeader('Authorization', 'Token 5fcd69a386ae6e073e51edb941b367d703496f21')
      .expectStatus(200)
      //.inspectBody()
    .toss();
    callback(null, '2');
  },

  function(callback){
    frisby.create('api.t.com-case-5-2')
      .get('http://{httptables}:8000/test/user'.format(config))
      .addHeader('host', 'apis.t.com')
      .addHeader('X-User-ID', 'user_2')
      .expectStatus(200)
      .expectJSON({
        status: 400,
      })
      //.inspectBody()
    .toss();
    callback(null, '3');
  },

  function(callback){
    frisby.create('api.t.com-case-5-2')
      .get('http://{httptables}:8000/test/device'.format(config))
      .addHeader('host', 'apis.t.com')
      .addHeader('X-Device-ID', 'device_2')
      .expectStatus(200)
      .expectJSON({
        status: 400,
      })
      //.inspectBody()
    .toss();
    callback(null, '3');
  },

  function(callback){
    frisby.create('api.t.com-case-5-2')
      .get('http://{httptables}:8000/test/device'.format(config))
      .addHeader('host', 'apis.t.com')
      .addHeader('X-Device-ID', 'device_2')
      .addHeader('X-User-ID', 'user_2')
      .expectStatus(200)
      .expectJSON({
        status: 200,
      })
      //.inspectBody()
    .toss();
    callback(null, '3');
  },

  function(callback){
    frisby.create('api.t.com-case-5-2')
      .get('http://{httptables}:8000/test/user'.format(config))
      .addHeader('host', 'apis.t.com')
      .addHeader('X-Device-ID', 'device_2')
      .addHeader('X-User-ID', 'user_2')
      .expectStatus(200)
      .expectJSON({
        status: 200,
      })
      //.inspectBody()
    .toss();
    callback(null, '3');
  },

  function(callback){
    frisby.create('api.t.com-case-5-1-1')
      .patch('http://{httptables_manager}:8080/apis/role_types/1/'.format(config), {
        optional: 0
      }, {json: true})
      .addHeader('Authorization', 'Token 5fcd69a386ae6e073e51edb941b367d703496f21')
      .expectStatus(200)
      //.inspectBody()
    .toss();
    callback(null, '1');
  },

  function(callback){
    frisby.create('api.t.com-case-5-1-2')
      .patch('http://{httptables_manager}:8080/apis/role_types/2/'.format(config), {
        optional: 0
      }, {json: true})
      .addHeader('Authorization', 'Token 5fcd69a386ae6e073e51edb941b367d703496f21')
      .expectStatus(200)
      //.inspectBody()
    .toss();
    callback(null, '2');
  },






], function(error, result){
  //console.log(result);
})
