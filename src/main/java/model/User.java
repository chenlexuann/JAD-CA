package model;

public class User {
	
	private int UserID;
	private String firstName;
	private String lastName;
	private String email;
	private String pwd;
	private String address;
	private String postalCode;
	
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	public User(int userID, String firstName, String lastName, String email, String pwd, String address,
			String postalCode) {
		super();
		this.UserID = userID;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.pwd = pwd;
		this.address = address;
		this.postalCode = postalCode;
	}
	
	public int getUserID() {
		return UserID;
	}
	public void setUserID(int userID) {
		this.UserID = userID;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPostalCode() {
		return postalCode;
	}
	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}
	
	
	
}
