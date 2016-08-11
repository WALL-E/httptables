var frisby = require('frisby');

function getIPAdress(){  
    var interfaces = require('os').networkInterfaces();  
    for(var devName in interfaces){  
          var iface = interfaces[devName];  
          for(var i=0;i<iface.length;i++){  
               var alias = iface[i];  
               if(alias.family === 'IPv4' && alias.address !== '127.0.0.1' && !alias.internal){  
                     return alias.address;  
               }  
          }  
    }  
}  

frisby.create('origin')
  .get('http://127.0.0.1:8000/test/origin')
  .expectStatus(200)
  .expectJSON({
        status: 4001,
  })
.toss();


frisby.create('origin')
  .get('http://' + getIPAdress() + ':8000/test/origin')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();


frisby.create('origin')
  .post('http://127.0.0.1:8000/test/origin')
  .expectStatus(200)
  .expectJSON({
        status: 4001,
  })
.toss();

frisby.create('origin')
  .put('http://127.0.0.1:8000/test/origin')
  .expectStatus(200)
  .expectJSON({
        status: 200,
  })
.toss();


