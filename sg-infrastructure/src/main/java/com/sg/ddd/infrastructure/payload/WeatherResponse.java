package com.sg.ddd.infrastructure.payload;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class WeatherResponse {
    private Location location;
    private Current current;
    private Forecast forecast;

    @Getter @Setter
    public static class Location {
        private String name;
        private String region;
        private String country;
        private String localtime;
    }

    @Getter @Setter
    public static class Current {
        private double temp_c;
        private Condition condition;

        @Getter @Setter
        public static class Condition {
            private String text;
            private String icon;
        }
    }

    @Getter @Setter
    public static class Forecast {
        private List<ForecastDay> forecastday;

        @Getter @Setter
        public static class ForecastDay {
            private String date;
            private Day day;

            @Getter @Setter
            public static class Day {
                private double maxtemp_c;
                private double mintemp_c;
                private Condition condition;

                @Getter @Setter
                public static class Condition {
                    private String text;
                    private String icon;
                }
            }
        }
    }
}
