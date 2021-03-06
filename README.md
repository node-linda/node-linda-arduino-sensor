arduino-sensor
==============
Share Arduino's sensor values with [linda-socket.io](https://github.com/node-linda/linda-socket.io)

- write {type: "sensor", name: "light", value: value}
- write {type: "sensor", name: "temperature", value: value}
- https://github.com/node-linda/arduino-sensor


## Install Dependencies

    % npm install


## Setup Arduino

Install Arduino Firmata v2.2

    Arduino IDE -> [File] -> [Examples] -> [Firmata] -> [StandardFirmata]

sensors
- light
  - analog input 0
  - CdS and 330Ω
- temperature
  - analog input 1
  - [LM35DZ](http://akizukidenshi.com/catalog/g/gi-00116/)

![schema](hardware/linda-arduino-sensor.png)

![arduino schema](http://farm6.staticflickr.com/5443/8952129460_3ed3003697_z.jpg)


## Run

    % npm start

=> http://linda-server.herokuapp.com/test?type=sensor


## Run with your [linda-server](https://github.com/node-linda/linda)

    % export LINDA_BASE=http://linda-server.herokuapp.com
    % export LINDA_SPACE=test
    % export ARDUINO=/dev/cu.usbdevice-name
    % npm start


## Install as Service

    % gem install foreman

for launchd (Mac OSX)

    % sudo foreman export launchd /Library/LaunchDaemons/ --app node-linda-arduino-sensor -u `whoami`
    % sudo launchctl load -w /Library/LaunchDaemons/node-linda-arduino-sensor-main-1.plist


for upstart (Ubuntu)

    % sudo foreman export upstart /etc/init/ --app node-linda-arduino-sensor -d `pwd` -u `whoami`
    % sudo service node-linda-arduino-sensor start
