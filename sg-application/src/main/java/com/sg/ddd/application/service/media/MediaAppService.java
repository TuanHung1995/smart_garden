package com.sg.ddd.application.service.media;

import com.sg.ddd.domain.model.entity.Media;
import org.springframework.web.multipart.MultipartFile;

public interface MediaAppService {

    Media uploadMedia(MultipartFile file);
}
