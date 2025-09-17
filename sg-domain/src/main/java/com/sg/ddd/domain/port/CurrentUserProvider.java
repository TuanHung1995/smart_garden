package com.sg.ddd.domain.port;

import java.util.Objects;
import java.util.Optional;

public interface CurrentUserProvider {

     Optional<String> getCurrentUserEmail();

     Optional<Long> getCurrentUserId();

//    Optional<String> getCurrentUserInfo(String userInfoType);

}
