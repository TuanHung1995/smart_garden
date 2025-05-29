package com.sg.ddd.application.payload;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class WeatherRequest {

    private String location; // Vị trí cần lấy thông tin thời tiết

}
