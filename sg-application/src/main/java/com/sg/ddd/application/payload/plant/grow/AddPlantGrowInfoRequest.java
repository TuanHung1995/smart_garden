package com.sg.ddd.application.payload.plant.grow;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AddPlantGrowInfoRequest {

    String name;
    String description;
    String type;
    Long mediaId;
    String gardenId;
    Long userId;

}
