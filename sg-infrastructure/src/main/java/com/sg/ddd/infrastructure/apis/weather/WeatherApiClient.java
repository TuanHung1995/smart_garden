package com.sg.ddd.infrastructure.apis.weather;

import com.sg.ddd.infrastructure.payload.WeatherResponse;

public interface WeatherApiClient {

    WeatherResponse getForecast(String location);

}
