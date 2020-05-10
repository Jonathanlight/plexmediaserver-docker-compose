OS X or Linux

1- Open a Terminal window or your command prompt

2- Enter the following command 
(substituting the IP address of your server as appropriate):
ssh ip.address.of.server -L 8888:localhost:32400

3- Open a browser window

4- Type http://localhost:8888/web into the address bar

5- The browser will connect to the server as if it were 
local and load Plex Web App

Gateway: ip.address.of.server
Source Port: 8888
Destination: localhost:32400