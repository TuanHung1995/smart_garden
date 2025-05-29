package com.sg.ddd.infrastructure.weather.impl;

import com.sg.ddd.infrastructure.payload.WeatherResponse;
import com.sg.ddd.infrastructure.weather.WeatherApiClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class WeatherApiClientImpl implements WeatherApiClient {

    @Value("${weather.api.key}")
    private String apiKey;

    private final RestTemplate restTemplate;

    public WeatherApiClientImpl(RestTemplateBuilder builder) {
        this.restTemplate = builder.build();
    }

    @Override
    public WeatherResponse getForecast(String location) {
        String url = String.format(
                "http://api.weatherapi.com/v1/forecast.json?key=%s&q=%s&days=3",
                apiKey, location
        );
        return restTemplate.getForObject(url, WeatherResponse.class);
    }

}
