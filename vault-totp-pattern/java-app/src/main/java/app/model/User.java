package app.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="TBL_USERS")
public class User {
  
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(name="username")
  private String username;

  @Column(name="password")
  private String password;

  public User() {}
  
  public Long getId() {
    return id;
  }

  public String getUsername() {
    return username;
  }
  
  public String getPassword() {
    return password;
  }
  
  public void setId(Long id) {
    this.id = id;
  }

  public void setUsername(String username) {
    this.username = username;
  }
  
  public void getPassword(String password) {
    this.password = password;
  }

   @Override
    public String toString() {
        return "Users [id=" + id + ", username=" + username + 
                ", password=" + password + "]";
    }
}