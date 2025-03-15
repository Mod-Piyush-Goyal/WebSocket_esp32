# WebSocket_esp32
This is an demo websocket between an esp32 module and android app(made via flutter)

SETTING UP::
>> Both app and esp32 should be connected to a same network i.e same wifi which could be created using laptop hopspot or use the same router.
>> check for the IP of the esp32 which is dynamic currently and update it in main.dart of the app before using app
  example- { if the ip of esp32 is 156.38.45.157 then replace "ws://192.168.137.157:81/" with "ws://156.38.45.157:81/" (81 is the port used for communication) }
>> used libraries is to be installed in the arduino ide before uploading the code i.e for now are "WebSockets" by "Markus" and Wifi.
>> if an error of "dissconnected while uploading" pop up while uploading code on esp32 try reducing the upload speed. ArduinoIde > Tools > UploadSpeed > 115200.
>> set the baud rate of Serial Monitor to the baud rate set in the code (failure in doing so will return corrupted data). baud rate is set inside "Serial.begin(baudrate)".

This is just a DEMO and require a lot of changes so help is always appreciated
