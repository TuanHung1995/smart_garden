package com.sg.ddd.application.service.media.impl;

import com.sg.ddd.application.service.media.MediaAppService;
import com.sg.ddd.domain.model.entity.Media;
import com.sg.ddd.domain.port.MediaRepository;
import com.sg.ddd.infrastructure.persistence.file.FileStorageServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
@Slf4j
public class MediaAppServiceImpl implements MediaAppService {

    private final MediaRepository mediaRepository;
    private final FileStorageServiceImpl fileStorageService;

    public MediaAppServiceImpl(MediaRepository mediaRepository, FileStorageServiceImpl fileStorageService) {
        this.mediaRepository = mediaRepository;
        this.fileStorageService = fileStorageService;
    }

    @Override
    public Media uploadMedia(MultipartFile file) {
        String fileName = fileStorageService.store(file);
        String fileUrl = fileStorageService.getUrl(fileName);
        String fileType = file.getContentType().startsWith("image") ? "image" : "video";

        Media media = new Media();
        media.setUrl(fileUrl);
        media.setType(fileType);

        return mediaRepository.save(media);
    }
}
