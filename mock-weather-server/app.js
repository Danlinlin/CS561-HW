"use strict"

var express = require('express')
var app = express()

app.listen(8080)
console.log('Node.js Express server id is running on port 8080...')

app.get('/data/2.5/weather', get_weather)

function get_weather(request, response) {
    response.json({
        "coord": {
          "lon": -123.262,
          "lat": 44.5646
        },
        "weather": [
          {
            "id": 804,
            "main": "Clouds",
            "description": "overcast clouds",
            "icon": "04d"
          }
        ],
        "base": "stations",
        "main": {
          "temp": 293.72,
          "feels_like": 293.69,
          "temp_min": 290.29,
          "temp_max": 295.45,
          "pressure": 1022,
          "humidity": 71
        },
        "visibility": 10000,
        "wind": {
          "speed": 4.12,
          "deg": 280
        },
        "clouds": {
          "all": 100
        },
        "dt": 1664495067,
        "sys": {
          "type": 2,
          "id": 2005452,
          "country": "US",
          "sunrise": 1664460511,
          "sunset": 1664503079
        },
        "timezone": -25200,
        "id": 5720727,
        "name": "Corvallis",
        "cod": 200
      })
}
