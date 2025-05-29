package com.sg.ddd.infrastructure.weather;

import com.sg.ddd.infrastructure.payload.WeatherResponse;

public interface WeatherApiClient {

    WeatherResponse getForecast(String location);

}
