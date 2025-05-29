package com.sg.ddd.application.service.weather.impl;

import com.sg.ddd.application.payload.WeatherDto;
import com.sg.ddd.application.service.weather.WeatherService;
import com.sg.ddd.infrastructure.payload.WeatherResponse;
import com.sg.ddd.infrastructure.weather.WeatherApiClient;
import org.springframework.stereotype.Service;

@Service
public class WeatherServiceImpl implements WeatherService {

    private final WeatherApiClient weatherApiClient;

    public WeatherServiceImpl(WeatherApiClient weatherApiClient) {
        this.weatherApiClient = weatherApiClient;
    }

    @Override
    public WeatherDto getWeather(String location) {
        WeatherResponse raw = weatherApiClient.getForecast(location);
        return WeatherDto.from(raw); // Chuyển về DTO phù hợp frontend
    }
}
