# ruby_http_1.1

generate self signed certificate
`openssl req -x509 -newkey rsa:2048 -keyout server.key -out server.crt -days 365 -nodes`

make http request 
`curl -k https://localhost:3000`

you can make multiple requests to same server as it will spawn new thread for each request 

