package com.sg.ddd.domain.port;

import com.sg.ddd.domain.model.entity.Media;

public interface MediaRepository {

    Media save(Media media);

}
