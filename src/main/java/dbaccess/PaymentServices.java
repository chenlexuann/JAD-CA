package dbaccess;

import java.util.*;
import model.*;
import com.paypal.api.payments.*;
import com.paypal.base.rest.*;

public class PaymentServices {
	private static final String CLIENT_ID = "AQV-GsbGowewcnfAP8clNQFb-KvFVf_Kh5yuz_ZKlTmxRUJaaeXLcCBJaQTHndooDSGRYkl8HNy4XIEZ";
	private static final String CLIENT_SECRET = "ELa6JID_bgjlsucSTupxYDXj2La97K11OqGBZUzAwC9YvnCf9h4KQyscD084_MFjxKk0YCE_WVLOTeIO";
	private static final String MODE = "sandbox";

	public String authorizePayment(OrderDetail orderDetail, User user) throws PayPalRESTException {

		Payer payer = getPayerInformation(user);
		RedirectUrls redirectUrls = getRedirectURLs();
		List<Transaction> listTransaction = getTransactionInformation(orderDetail);

		Payment requestPayment = new Payment();
		requestPayment.setTransactions(listTransaction);
		requestPayment.setRedirectUrls(redirectUrls);
		requestPayment.setPayer(payer);
		requestPayment.setIntent("authorize");

		APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);

		Payment approvedPayment = requestPayment.create(apiContext);

		return getApprovalLink(approvedPayment);

	}

	private Payer getPayerInformation(User user) {
		Payer payer = new Payer();
		payer.setPaymentMethod("paypal");

		PayerInfo payerInfo = new PayerInfo();
		payerInfo.setFirstName(user.getFirstName()).setLastName(user.getLastName()).setEmail(user.getEmail());

		payer.setPayerInfo(payerInfo);

		return payer;
	}

	private RedirectUrls getRedirectURLs() {
		RedirectUrls redirectUrls = new RedirectUrls();
		redirectUrls.setCancelUrl("http://localhost:8080/JAD-CA/cart.jsp");
		redirectUrls.setReturnUrl("http://localhost:8080/JAD-CA/review_payment");

		return redirectUrls;
	}

	private List<Transaction> getTransactionInformation(OrderDetail orderDetail) {
		Details details = new Details();
		details.setSubtotal(orderDetail.getSubtotal());
		details.setTax(orderDetail.getGST());

		Amount amount = new Amount();
		amount.setCurrency("SGD");
		amount.setTotal(orderDetail.getTotal());
		amount.setDetails(details);
		
		Transaction transaction = new Transaction();
		transaction.setAmount(amount);
		transaction.setDescription("Kitty Books Ptd Ltd");

		ItemList itemList = new ItemList();
		List<Item> items = new ArrayList<>();
		
		for (Cart c : orderDetail.getProduct()) {
			Item item = new Item();
			item.setCurrency("SGD");
			item.setName(c.getTitle());
			item.setPrice((c.getPrice()/c.getCartQuantity())+"");
			item.setTax(c.getGST());
			item.setQuantity(c.getCartQuantity() + "");

			items.add(item);
		}
		itemList.setItems(items);
		transaction.setItemList(itemList);

		List<Transaction> listTransaction = new ArrayList<>();
		listTransaction.add(transaction);

		return listTransaction;
	}

	private String getApprovalLink(Payment approvedPayment) {
		List<Links> links = approvedPayment.getLinks();
		String approvalLink = null;

		for (Links link : links) {
			if (link.getRel().equalsIgnoreCase("approval_url")) {
				approvalLink = link.getHref();
				break;
			}
		}

		return approvalLink;
	}

	public Payment getPaymentDetails(String paymentId) throws PayPalRESTException {
		APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
		return Payment.get(apiContext, paymentId);
	}

	public Payment executePayment(String paymentId, String payerId) throws PayPalRESTException {
		PaymentExecution paymentExecution = new PaymentExecution();
		paymentExecution.setPayerId(payerId);

		Payment payment = new Payment().setId(paymentId);

		APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);

		return payment.execute(apiContext, paymentExecution);
	}

}