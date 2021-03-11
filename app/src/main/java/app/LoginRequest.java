package app;

public class LoginRequest {
  private String username;
  private String password;

  public LoginRequest() {}

  public String getUsername() {
    return username;
  }
  
  public String getPassword() {
    return password;
  }
  
  public void setUsername(String username) {
    this.username = username;
  }
  
  public void getPassword(String password) {
    this.password = password;
  }
}