package model;

public class DeliveryAddressModel{
	private String country;
	private String province;
	private String city;
	private String street_address;
	
	public DeliveryAddressModel(String country, String province, String city, String street_address) {
		this.country = country;
		this.province = province;
		this.city = city;
		this.street_address = street_address;
	}
	
	public DeliveryAddressModel() {}
	
	public String getCountry() {
		return country;
	}
	
	public void setCountry(String country) {
		this.country = country;
	}
	
	public String getProvince() {
		return province;
	}
	
	public void setProvince(String province) {
		this.province = province;
	}
	
	public String getCity() {
		return city;
	}
	
	public void setCity(String city) {
		this.city = city;
	}
	
	public String getStreetAddress() {
		return street_address;
	}
	
	public void setStreetAddress(String street_address) {
		this.street_address = street_address;
	}
}
