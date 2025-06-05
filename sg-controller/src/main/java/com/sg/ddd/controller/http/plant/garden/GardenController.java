package com.sg.ddd.controller.http.plant.garden;

import com.sg.ddd.application.payload.plant.garden.GardenRequest;
import com.sg.ddd.application.service.plant.garden.GardenAppService;
import com.sg.ddd.controller.model.enums.ResultUtil;
import com.sg.ddd.controller.model.vo.ResultMessage;
import com.sg.ddd.domain.model.entity.Garden;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/garden")
@Slf4j
public class GardenController {

    private final GardenAppService gardenAppService;

    public GardenController(GardenAppService gardenAppService) {
        this.gardenAppService = gardenAppService;
    }

    @GetMapping("/get-all-gardens")
    public ResultMessage<List<Garden>> getAllGardens() {
        List<Garden> gardens = gardenAppService.findAllGardensByUserId();
        return ResultUtil.data(gardens);
    }

    @PostMapping("/add-garden")
    public ResultMessage<List<Garden>> addGarden(@RequestBody GardenRequest request) {
        List<Garden> gardens = gardenAppService.addGarden(request.getName(), request.getDescription());
        return ResultUtil.data(gardens);
    }
}
