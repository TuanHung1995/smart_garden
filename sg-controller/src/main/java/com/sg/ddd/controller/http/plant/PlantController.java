package com.sg.ddd.controller.http.plant;

import com.sg.ddd.application.service.plant.grow.PlantGrowInfoAppService;
import com.sg.ddd.controller.model.enums.ResultUtil;
import com.sg.ddd.controller.model.vo.ResultMessage;
import com.sg.ddd.domain.model.entity.PlantGrowInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/plant")
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


    /**
     * Retrieves all plant grow information for the current user.
     *
     * @return a ResultMessage containing a list of PlantGrowInfo objects
     */
    @GetMapping("/get-all-plant-grow-info")
    public ResultMessage<List<PlantGrowInfo>> getAllPlantGrowInfo() {
        List<PlantGrowInfo> plantGrowInfoListByEmail= plantGrowInfoAppService.getAllPlantGrowInfoByEmail();
        return ResultUtil.data(plantGrowInfoListByEmail);
    }

}
