package app.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class TOTPValidateResponse {

  private TOTPValidateResponseData data;

  public TOTPValidateResponse() {}

  public void setData(TOTPValidateResponseData data) {
    this.data = data;
  }
  
  public TOTPValidateResponseData getData() {
    return data;
  }


  @JsonIgnoreProperties(ignoreUnknown = true)
  public class TOTPValidateResponseData {
    private Boolean valid;

    public TOTPValidateResponseData() {}

    public Boolean getValid() {
      return valid;
    }
  
    public void setValid(Boolean valid) {
      this.valid = valid;
    }
  }
}