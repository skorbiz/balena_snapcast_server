# balena_snapcast_server
A project to use balena to deploy and manage multiroom music using snapcast.

The snapcast docker image is based on:
badaix/snapcast
saiyato/snapclient

This repo add a few changes to make it compatible with balena and work for my specific setup.


# A bit about the setup
Home assistant is running a spotify connect client.
It is also configured to be a snapcast server.
In home assistant remember to select the snapcast server as output and on the server select the spotif y connect as the input stream.

Raspbarry pi zero 2 w is configured to run the snapcast client. The zero has a usb dongle with soundcard. Its connected to a Beoplay A9. 

# Deploying using balena
Create the balena fleet.
Install balena cli

balena login
balena deploy <fleet>



# Things specific for me:
Home assistant / snapcast server ip: 192.168.1.38
balena fleet name: iotsound

Browser to the snapcast server:
http://192.168.1.38:1780