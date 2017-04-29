package com.craigstjean.hello.api;

import io.swagger.annotations.*;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;

@Api(value = "hello", description = "the hello API")
public interface HelloApi {

    @ApiOperation(value = "Gets a hello", notes = "", response = String.class, tags = {})
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "successful operation", response = String.class)})
    @RequestMapping(value = "/api/v1/hello",
            produces = {"application/json"},
            method = RequestMethod.GET)
    ResponseEntity<String> getHello(
            @NotNull @ApiParam(value = "name") @RequestParam(value = "name", required = true) String name);

}
