require 'socket'
@number = ARGV[0]
if(!@number) then
	@number = "";
end
@number = @number+"||92"
#puts "Sending: "+@number
#@number = "||92"
socket = UDPSocket.open
socket.send( @number, 0, "localhost", 40000)
socket.close
