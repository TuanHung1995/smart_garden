package com.sg.ddd.controller.http.apis;

import com.sg.ddd.application.payload.apis.dto.WeatherDto;
import com.sg.ddd.application.payload.apis.req.WeatherRequest;
import com.sg.ddd.application.service.weather.WeatherService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/weather")
@Slf4j
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
