package model;

import java.util.List;

public class OrderDetail {
	private List<Cart> product;
	private double GST;
	private double total;
	private double subtotal;

	public OrderDetail(List<Cart> product, double GST, double subtotal, double total) {
		this.product = product;
		this.GST = GST;
		this.subtotal = subtotal;
		this.total = total;
	}

	public List<Cart> getProduct() {
		return product;
	}
	
	public String getGST() {
		return String.format("%.2f", GST);
	}
	
	public String getSubtotal() {
        return String.format("%.2f", subtotal);
    }
 
	public String getTotal() {
		return String.format("%.2f", total);
	}
}
