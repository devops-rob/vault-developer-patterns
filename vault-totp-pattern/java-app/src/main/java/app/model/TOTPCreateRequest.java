package app.model;

import com.fasterxml.jackson.annotation.JsonProperty;

public class TOTPCreateRequest {
  private Boolean generate;
  private String issuer;
  private String accountName;

  public TOTPCreateRequest() {
    this.generate  = true;
  }

  @JsonProperty("account_name")
  public String getAccountName() {
    return accountName;
  }
  
  public Boolean getGenerate() {
    return generate;
  }
  
  public String getIssuer() {
    return issuer;
  }
  
  public void setAccountName(String accountName) {
    this.accountName = accountName;
  }
  
  public void setIssuer(String issuer) {
    this.issuer = issuer;
  }
}