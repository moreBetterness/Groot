const app = require('express')();
const http = require('http').Server(app);
const io = require('socket.io')(http);

app.post('/', function(req, res){
  io.sockets.emit('data', req.body);
  res.end();
});

io.on('connection', function(socket){
  console.log('a user connected');
});

http.listen(3000, function(){
  console.log('listening on *:3000');
});
    