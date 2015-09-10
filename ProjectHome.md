![http://transfer.allink.ch/googlecode/call_notify_icon.jpg](http://transfer.allink.ch/googlecode/call_notify_icon.jpg)

AsteriskNotifcationClient is an OS X Application which displays a message when it is notified by a Asterisk PBX.

It searches the local address book and if no contact was found the database for swiss telephone numbers: tel.search.ch


To be able to display call notifications you must install growl:

http://growl.info/

Your Asterisk PBX must be running «Notify application module for the Asterisk PBX» It is open source and can be downloaded here:

http://www.mezzo.net/asterisk/app_notify.html

To build this app you need Xcode version 3.1 or greater.

To run the app you need OS X 10.5 Leopard or greater.


To test the app without an Asterisk PBX please use the ruby script called udpserver.rb

just type this in your command line:

ruby udpserver.rb 00070707


00070707 is the calling number