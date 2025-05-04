package com.sg.ddd.controller.resource;

import com.sg.ddd.application.service.event.EventAppService;
import io.github.resilience4j.ratelimiter.annotation.RateLimiter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/hi")
public class HiController {

    @Autowired
    private EventAppService eventAppService;

    @GetMapping("/hello")
    @RateLimiter(name = "backendA", fallbackMethod = "helloFallback")
    public String hello() {
        return eventAppService.sayHi("World");
    }

    public String helloFallback(Exception e) {
        return "Too many requests, please try again later.";
    }

    @GetMapping("/hi-circuit-breaker")
    public String circuitBreaker() {
        return eventAppService.sayHi("World");
    }

}
