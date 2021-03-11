package app;

public class ProductResponse {
  private String name;
  private String price;

  public ProductResponse(String name, String price) {
    this.name = name;
    this.price = price;
  }

  public String getName() {
    return this.name;
  }
  
  public String getPrice() {
    return this.price;
  }
  
  public void setName(String name) {
    this.name = name;
  }
  
  public void setPrice(String price) {
    this.price = price;
  }
}