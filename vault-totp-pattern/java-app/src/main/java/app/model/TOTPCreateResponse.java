package app.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class TOTPCreateResponse {

  private TOTPCreateResponseData data;

  public TOTPCreateResponse() {}

  public void setData(TOTPCreateResponseData data) {
    this.data = data;
  }
  
  public TOTPCreateResponseData getData() {
    return data;
  }


  @JsonIgnoreProperties(ignoreUnknown = true)
  public class TOTPCreateResponseData {
    private String barcode;
    private String url;

    public TOTPCreateResponseData() {}

    public String getBarcode() {
      return barcode;
    }
  
    public void setBarcode(String barcode) {
      this.barcode = barcode;
    }
  
    public String getUrl() {
      return url;
    }
  
    public void setUrl(String url) {
      this.url = url;
    }
  }
}