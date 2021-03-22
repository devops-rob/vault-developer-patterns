package app.model;

public class LoginRequest {
  private String username;
  private String password;
  private String code;

  public LoginRequest() {}

  public String getUsername() {
    return username;
  }
  
  public String getPassword() {
    return password;
  }
  
  public String getCode() {
    return code;
  }
  
  public void setUsername(String username) {
    this.username = username;
  }
  
  public void setPassword(String password) {
    this.password = password;
  }
  
  public void setCode(String code) {
    this.code = code;
  }
}