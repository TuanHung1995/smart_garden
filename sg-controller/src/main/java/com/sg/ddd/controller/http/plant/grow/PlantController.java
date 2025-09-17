package com.sg.ddd.controller.http.plant.grow;

import com.sg.ddd.application.payload.file.UploadMediaRequest;
import com.sg.ddd.application.payload.plant.grow.AddPlantGrowInfoRequest;
import com.sg.ddd.application.service.media.MediaAppService;
import com.sg.ddd.application.service.plant.grow.PlantGrowInfoAppService;
import com.sg.ddd.controller.model.enums.ResultUtil;
import com.sg.ddd.controller.model.vo.ResultMessage;
import com.sg.ddd.domain.model.entity.Media;
import com.sg.ddd.domain.model.entity.PlantGrowInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/api/v1/plant")
@Slf4j
public class PlantController {

    private final PlantGrowInfoAppService plantGrowInfoAppService;
    private final MediaAppService mediaAppService;

    public PlantController(PlantGrowInfoAppService plantGrowInfoAppService, MediaAppService mediaAppService) {
        this.plantGrowInfoAppService = plantGrowInfoAppService;
        this.mediaAppService = mediaAppService;
    }

    /**
     * Adds a new plant grow information entry.
     *
     * @param request the request containing plant grow information details
     * @return a ResultMessage containing a list of PlantGrowInfo objects
     */
    @PostMapping("/add-plant-grow-info")
    public ResultMessage<List<PlantGrowInfo>> addPlantGrowInfo(@RequestBody AddPlantGrowInfoRequest request) {
        List<PlantGrowInfo> plantGrowInfos = plantGrowInfoAppService.addPlantGrowInfo(request.getName(),
                request.getDescription(), request.getType(), request.getGardenId());
        return ResultUtil.data(plantGrowInfos);
    }

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

    /**
     * Deletes a plant grow information entry by its ID.
     *
     * @param id the ID of the plant grow information entry to delete
     * @return a ResultMessage containing a list of PlantGrowInfo objects after deletion
     */
    @DeleteMapping("/delete-plant-grow-info/{planGrowInfoId}")
    public ResultMessage<List<PlantGrowInfo>> deletePlantGrowInfo(@PathVariable("planGrowInfoId") Long id) {
        List<PlantGrowInfo> plantGrowInfoList = plantGrowInfoAppService.deletePlantGrowInfo(id);
        return ResultUtil.data(plantGrowInfoList);
    }

    @PostMapping("/upload")
    public ResultMessage<Media> uploadMedia(@RequestBody UploadMediaRequest request) {
        Media savedMedia = mediaAppService.uploadMedia(request.getFile());
        return ResultUtil.data(savedMedia);
    }

}
