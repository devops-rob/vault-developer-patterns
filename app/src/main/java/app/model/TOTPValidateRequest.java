package app.model;

public class TOTPValidateRequest {
  private String code;

  public TOTPValidateRequest() {}
  
  public String getCode() {
    return code;
  }
  
  public void setCode(String code) {
    this.code = code;
  }
}