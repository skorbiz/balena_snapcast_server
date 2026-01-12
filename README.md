# balena_snapcast_server
A project to use Balena to deploy and manage multiroom music using snapcast.

The snapclient is installed from official pre-built packages from the snapcast repository:
https://github.com/snapcast/snapcast

The Dockerfile uses debian:bookworm-slim as the base image and installs the official snapclient .deb package for the appropriate architecture (armhf for Raspberry Pi Zero 2 W).

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



# Alternative imge
An alternative to the current docker file could be to use the prebuild image here:
image: docker.io/saiyato/snapclient:latest
The image is based on .... which is a much small image.


# About Snapcast
Todo add something here... 3-5 lines and a link

# About sendspin
Todo add something here... 3-5 lines and a link

# About Balena
Todo add somthing here... 3-5 lines and a link
