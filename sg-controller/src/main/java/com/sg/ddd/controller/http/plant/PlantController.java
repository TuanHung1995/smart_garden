package com.sg.ddd.controller.http.plant;

import com.sg.ddd.application.service.plant.grow.PlantGrowInfoAppService;
import com.sg.ddd.controller.model.enums.ResultUtil;
import com.sg.ddd.controller.model.vo.ResultMessage;
import com.sg.ddd.domain.model.entity.PlantGrowInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/plant")
@Slf4j
public class PlantController {

    private final PlantGrowInfoAppService plantGrowInfoAppService;

    public PlantController(PlantGrowInfoAppService plantGrowInfoAppService) {
        this.plantGrowInfoAppService = plantGrowInfoAppService;
    }

//    @PostMapping("/add-plant-grow-info")
//    public ResultMessage<List<PlantGrowInfo>> addPlantGrowInfo() {
//        log.info("Adding plant grow info");
//        List<PlantGrowInfo> plantGrowInfos = plantGrowInfoAppService.addPlant();
//        return ResultMessage.success(plantGrowInfos);
//    }


    @GetMapping("/get-all-plant-grow-info/{email}")
    public ResultMessage<List<PlantGrowInfo>> getAllPlantGrowInfo(@PathVariable("email") String email) {
        log.info("Retrieving all plant grow info");
        List<PlantGrowInfo> plantGrowInfoListByEmail= plantGrowInfoAppService.getAllPlantGrowInfoByEmail(email);
        return ResultUtil.data(plantGrowInfoListByEmail);
    }

}
