package com.sg.ddd.application.service.weather;

import com.sg.ddd.application.payload.apis.dto.WeatherDto;

public interface WeatherService {

    WeatherDto getWeather(String location);

}
