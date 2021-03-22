package app.model;

public class VaultErrorResponse {
  String[] errors;

  public VaultErrorResponse() {}  

  public void setErrors(String[] errors) {
    this.errors = errors;
  }
  
  public String[] getErrors() {
    return errors;
  }
}
