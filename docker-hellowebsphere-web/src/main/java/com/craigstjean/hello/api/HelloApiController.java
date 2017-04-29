package com.craigstjean.hello.api;

import io.swagger.annotations.ApiParam;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.constraints.NotNull;

@Controller
public class HelloApiController implements HelloApi {

    public ResponseEntity<String> getHello(
            @NotNull @ApiParam(value = "Name") @RequestParam(value = "name", required = true) String name) {

        return new ResponseEntity<String>("Hello, " + name, HttpStatus.OK);

    }

}
