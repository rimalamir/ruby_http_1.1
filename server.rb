require 'socket'
require 'openssl'

def handle_connection(socket)
count = 0
  ctx = OpenSSL::SSL::SSLContext.new
  ctx.cert = OpenSSL::X509::Certificate.new(File.open("server.crt"))
  ctx.key = OpenSSL::PKey::RSA.new(File.open("server.key"))

  ssl_socket = OpenSSL::SSL::SSLSocket.new(socket, ctx)
  ssl_socket.accept

  # Handle the incoming request and send the response
  request = ssl_socket.gets
  puts request

  # Send the response
  loop do
    sleep 2
    count += 1
    response = "HTTP/1.1 200 OK\r\n"
    response += "Content-Type: text/html\r\n"
    response += "Link: </style.css>; rel=preload; as=style\r\n"
    response += "\r\n"
    response += "Handling multi threaded request #{count}"
    ssl_socket.write(response)
end

  # Close the socket
  ssl_socket.close
end

server = TCPServer.new(3000)

while true
  socket = server.accept
  Thread.new { handle_connection(socket) }
end
