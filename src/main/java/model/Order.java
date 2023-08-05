package model;

public class Order {

	private String member_id;
	private String order_id;
	private String title;
	private String quantities;
	private double price;
	private String order_date;
	
	public Order(String member_id, String order_id, String title, String quantities, double price, String order_date) {
		super();
		this.member_id = member_id;
		this.order_id = order_id;
		this.title = title;
		this.quantities = quantities;
		this.price = price;
		this.order_date = order_date;
	}
	
	public Order() {
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getOrder_id() {
		return order_id;
	}

	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getQuantities() {
		return quantities;
	}

	public void setQuantities(String quantities) {
		this.quantities = quantities;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getOrder_date() {
		return order_date;
	}

	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	
}
