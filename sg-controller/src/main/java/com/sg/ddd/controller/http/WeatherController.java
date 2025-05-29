package com.sg.ddd.controller.http;

import com.sg.ddd.application.payload.WeatherDto;
import com.sg.ddd.application.payload.WeatherRequest;
import com.sg.ddd.application.service.weather.WeatherService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/weather")
public class WeatherController {

    private final WeatherService weatherService;

    public WeatherController(WeatherService weatherService) {
        this.weatherService = weatherService;
    }

    @GetMapping
    public ResponseEntity<WeatherDto> getForecast(@RequestBody WeatherRequest weatherRequest) {

        String location = weatherRequest.getLocation();

        return ResponseEntity.ok(weatherService.getWeather(location));
    }
}
