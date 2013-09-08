var express = require('express')
  , routes = require('./routes')
  , user = require('./routes/user')
  , http = require('http')
  , path = require('path');

var app = express()
  , server = http.createServer(app)
  , io = require('socket.io').listen(server);

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'ejs');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser('your secret here'));
  app.use(express.session());
  app.use(app.router);
  app.use(express.static(path.join(__dirname, 'public')));
});

app.configure('development', function(){
  app.use(express.errorHandler());
});

server.listen(app.get('port'));

//Realtime - API
app.post('/api/broadcast', function(req, res){
  params = req.body;
  io.sockets.sockets[params.origin_socket].broadcast.emit('todo_broadcast', { message: params.message, id: params.message_id });
  res.send("Response");
});

//Socket.io
io.sockets.on('connection', function (socket) {
  socket.emit('connected', { message: 'Socket connected to server', id: socket.id });
});












