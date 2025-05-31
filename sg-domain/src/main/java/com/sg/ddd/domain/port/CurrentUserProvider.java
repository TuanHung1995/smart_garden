package com.sg.ddd.domain.port;

import java.util.Optional;

public interface CurrentUserProvider {

    Optional<String> getCurrentUserEmail();

}
