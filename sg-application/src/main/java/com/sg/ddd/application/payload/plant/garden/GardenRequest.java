package com.sg.ddd.application.payload.plant.garden;

import lombok.Data;

@Data
public class GardenRequest {

    private String name;
    private String description;
    private Long userId;

}
