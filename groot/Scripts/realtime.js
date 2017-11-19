var Socket = (function(){
	var socket = io.connect('http://18.221.121.95:3000');
	socket.on('connect', function(){
		console.log('Connected.');
	});
	socket.on('data', function(data){
		console.log(data);
		$('#moistureCardValue').text(data.event);
		$('#moistureTableValue').text(data.event);
		$('#moistureMobileTableValue').text(data.event);
	});
	socket.on('disconnect', function(){
		console.log('Disconnected.');
	});
}());