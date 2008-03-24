require 'socket'
@number = ARGV[0]
@number = @number+"||92"
puts "Sending: "+@number
socket = UDPSocket.open
socket.send( @number, 0, "localhost", 40000)
socket.close
