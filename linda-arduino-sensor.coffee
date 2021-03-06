process.env.LINDA_BASE  ||= 'http://linda-server.herokuapp.com'
process.env.LINDA_SPACE ||= 'test'

## Linda
LindaClient = require('linda').Client
socket = require('socket.io-client').connect(process.env.LINDA_BASE)
linda = new LindaClient().connect(socket)
ts = linda.tuplespace(process.env.LINDA_SPACE)

linda.io.on 'connect', ->
  console.log "connect!! <#{process.env.LINDA_BASE}/#{ts.name}>"

linda.io.on 'disconnect', ->
  console.log "socket.io disconnect.."


## Arduino
ArduinoFirmata = require('arduino-firmata')
arduino = new ArduinoFirmata().connect(process.env.ARDUINO)

arduino.once 'connect', ->
  setInterval ->
    light = arduino.analogRead 0
    console.log "light : #{light}"
    ts.write {type: "sensor", name: "light", value: light}
    temp = arduino.analogRead(1)*5*100/1024
    console.log "temprature : #{temp}"
    ts.write {type: "sensor", name: "temperature", value: temp}
  , 1000
