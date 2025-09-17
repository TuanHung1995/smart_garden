package com.sg.ddd.application.payload.apis.dto;

import com.sg.ddd.infrastructure.payload.WeatherResponse;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class WeatherDto {
    private String location;
    private String time;
    private double temperature;
    private String condition;
    private String iconUrl;

    private List<ForecastDto> forecast;

    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ForecastDto {
        private String date;
        private double maxTemp;
        private double minTemp;
        private String condition;
        private String iconUrl;
    }

    public static WeatherDto from(WeatherResponse res) {
        List<ForecastDto> forecastList = res.getForecast().getForecastday().stream()
                .map(day -> new ForecastDto(
                        day.getDate(),
                        day.getDay().getMaxtemp_c(),
                        day.getDay().getMintemp_c(),
                        day.getDay().getCondition().getText(),
                        day.getDay().getCondition().getIcon()
                )).toList();

        return new WeatherDto(
                res.getLocation().getName() + ", " + res.getLocation().getCountry(),
                res.getLocation().getLocaltime(),
                res.getCurrent().getTemp_c(),
                res.getCurrent().getCondition().getText(),
                res.getCurrent().getCondition().getIcon(),
                forecastList
        );
    }
}
