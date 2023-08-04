package model;

public class Cart extends Book{
	private int quantity;

	public Cart() {
		super();
	}

	public int getCartQuantity() {
		return quantity;
	}

	public void setCartQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public String getGST() {
		return String.format("%.2f", getPrice() * 0.08);
	}
	
}
