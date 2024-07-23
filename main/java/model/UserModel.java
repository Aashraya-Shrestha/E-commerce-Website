package model;

public class UserModel{
	private String firstname;
	private String lastname;
	private String username;
	private String password;
	private String phone_number;
	private String email;
	
	public UserModel(String firstname, String lastname, String username, String password, String phone_number,
			String email) {
		this.firstname = firstname;
		this.lastname = lastname;
		this.username = username;
		this.password = password;
		this.phone_number = phone_number;
		this.email = email;
	}
	
	// fetching data from database. When fetching, we need to apply setAtribute()
	public UserModel() {}
	
	public String getFirstname() {
		return firstname;
	}
	
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	
	public String getLastname() {
		return lastname;
	}
	
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getPhoneNumber() {
		return phone_number;
	}
	
	public void setPhoneNumber(String phone_number) {
		this.phone_number = phone_number;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
//	public String getGender() {
//		return this.gender;
//	}
//	
//	public void setGender(String gender) {
//		this.gender = gender;
//	}
}