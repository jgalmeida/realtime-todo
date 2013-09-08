$(function(){

  var socket;
  if(typeof(io) != "undefined"){
    var socket = io.connect('http://localhost:3000');
  }

	$(document).on('click', '.todo-list li a',function(){
		$(this).parent().remove();
    alertify.success("Todo removed");
	});

	$('#newTodo').keypress(function(e){
    var _this = this;
		if(e.keyCode == 13){
			var value = this.value
			if (this.value){
        var socketId = (typeof(io) == "undefined") ? null : socket.id
        $.post("/messages", { message: value, socket_id: socketId }, function(data) {
          var newTodo = tmpl('todo-tmpl', data)
          $('.todo-list').append(newTodo)
          _this.value = ''
        })
			}
		}
	});

  if(typeof(io) != "undefined"){
    socket.on('connected', function (data) {
      socket.id = data.id;
      alertify.success(data.message);
    });

    socket.on('todo_broadcast', function (data){
      alertify.success("New todo received");
      $('.todo-list').append(tmpl('todo-tmpl', data));
    });
  }

});