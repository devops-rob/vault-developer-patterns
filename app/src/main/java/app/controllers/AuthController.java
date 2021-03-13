package app.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.ResponseStatus;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;
import java.net.http.HttpClient;
import java.net.URI;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import app.model.LoginRequest;
import app.model.TOTPValidateRequest;
import app.model.TOTPValidateResponse;
import app.model.TOTPCreateRequest;
import app.model.TOTPCreateResponse;
import app.model.VaultErrorResponse;

@RestController
public class AuthController {

    Logger logger = LoggerFactory.getLogger(AuthController.class);
    
    @ResponseStatus(code = HttpStatus.INTERNAL_SERVER_ERROR)
    class CustomException extends RuntimeException {
      /**
       *
       */
      private static final long serialVersionUID = 1L;

      public CustomException(String message) {  
        super(message);
      }
    }
    
    @ResponseStatus(code = HttpStatus.UNAUTHORIZED)
    class AuthenticationException extends RuntimeException {
      /**
       *
       */
      private static final long serialVersionUID = 1L;

      public AuthenticationException(String message) {  
        super(message);
      }
    }

    @PostMapping("/auth")
    @ResponseBody
    public TOTPValidateResponse authenticate(@RequestBody LoginRequest login) throws JsonProcessingException, IOException, InterruptedException {
        logger.info("Validate TOTP key for {}", login.getUsername());

        TOTPValidateRequest req = new TOTPValidateRequest();
        req.setCode(login.getCode());

        ObjectMapper objectMapper = new ObjectMapper();
        String requestBody = objectMapper
                .writeValueAsString(req);

        String uri = "http://localhost:8200/v1/totp/code/" + login.getUsername();
    
        HttpClient client = HttpClient.newHttpClient();

        HttpRequest request = HttpRequest.newBuilder()
          .uri(URI.create(uri))
          .POST(HttpRequest.BodyPublishers.ofString(requestBody))
          .header("x-vault-token", "root")
          .build();

        HttpResponse<String> body = client.send(
          request,
          HttpResponse.BodyHandlers.ofString()
        );

        if (body.statusCode() != 200) {
          VaultErrorResponse errors = objectMapper.readValue(body.body(), VaultErrorResponse.class);

          logger.info("Unable to validate TOTP key in Vault: {}", errors.getErrors());
          throw new CustomException("Unable to validate TOTP key in Vault");
        }
        
        TOTPValidateResponse response = objectMapper.readValue(body.body(), TOTPValidateResponse.class);

        if (!response.getData().getValid()) {
          logger.info("Invalid TOTP code");
          throw new AuthenticationException("TOTP code invalid");
        }

        return response;
    }
    

    @PostMapping("/auth/2fa")
    @ResponseBody
    public TOTPCreateResponse create2FA(@RequestBody LoginRequest login) throws JsonProcessingException, IOException, InterruptedException{
        TOTPCreateRequest req = new TOTPCreateRequest();
        req.setAccountName(login.getUsername());
        req.setIssuer("devopsrob");
        
        ObjectMapper objectMapper = new ObjectMapper();
        String requestBody = objectMapper
                .writeValueAsString(req);

        logger.info("Creating TOTP key for {}", login.getUsername());

        String uri = "http://localhost:8200/v1/totp/keys/" + login.getUsername();
    
        HttpClient client = HttpClient.newHttpClient();

        HttpRequest request = HttpRequest.newBuilder()
          .uri(URI.create(uri))
          .POST(HttpRequest.BodyPublishers.ofString(requestBody))
          .header("x-vault-token", "root")
          .build();

        HttpResponse<String> body = client.send(
          request,
          HttpResponse.BodyHandlers.ofString()
        );

        if (body.statusCode() != 200) {
          VaultErrorResponse errors = objectMapper.readValue(body.body(), VaultErrorResponse.class);

          logger.info("Unable to generate TOTP key in Vault: {}", errors.getErrors());
          throw new CustomException("Unable to create TOTP key in Vault");
        }

        TOTPCreateResponse response = objectMapper.readValue(body.body(), TOTPCreateResponse.class);

        return response;
    }
}