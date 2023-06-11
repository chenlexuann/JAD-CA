package books;

import java.util.Date;

public class Book {
    private int bookId;
    private String title;
    private double price;
    private int quantity;
    private String ISBN;
    private String imageUrl;
    private String authorName;
    private String genreName;
    private String publisherName;
    private Date publicationDate;
    private String rating;
    private String description;

    public Book() {
        // Default constructor
    }

    public Book(int bookId, String title, double price, int quantity, String ISBN, String imageUrl,
                String authorName, String genreName, String publisherName, Date publicationDate,
                String rating, String description) {
        this.bookId = bookId;
        this.title = title;
        this.price = price;
        this.quantity = quantity;
        this.ISBN = ISBN;
        this.imageUrl = imageUrl;
        this.authorName = authorName;
        this.genreName = genreName;
        this.publisherName = publisherName;
        this.publicationDate = publicationDate;
        this.rating = rating;
        this.description = description;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getISBN() {
        return ISBN;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getGenreName() {
        return genreName;
    }

    public void setGenreName(String genreName) {
        this.genreName = genreName;
    }

    public String getPublisherName() {
        return publisherName;
    }

    public void setPublisherName(String publisherName) {
        this.publisherName = publisherName;
    }

    public Date getPublicationDate() {
        return publicationDate;
    }

    public void setPublicationDate(Date publicationDate) {
        this.publicationDate = publicationDate;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
