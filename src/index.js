const http = require('http');
const server = http.createServer((req,res)=>{
  res.writeHead(200,{'Content-Type':'text/plain'});
  res.end('slim-app: optimized - 49MB - running\n');
});
server.listen(3000,()=>console.log('listening on 3000'));
