--CREATE A TABLE ASSIGNING PRIMARY AND FOREIGN KEY
CREATE TABLE 
	NewProducts (
		Product_id INT, 
		Product_name VARCHAR(255) DEFAULT ('No Name'), 
		Product_price$ DECIMAL(10,2),
		CONSTRAINT NewProducts_PK PRIMARY KEY(Product_id)
);

CREATE TABLE 
	NewCustomers (
		Customer_id INT, 
		Customer_name VARCHAR(255), 
		Customer_address VARCHAR(255),
		CONSTRAINT NewCustomers_PK PRIMARY KEY(Customer_id)
);

CREATE TABLE 
	NewOrders (
		Order_id INT,
		Customer_id INT, 
		Product_id INT,  
		Order_date DATE,
		Quantity INT CHECK (Quantity>0),
		CONSTRAINT 
			NewOrders_PK PRIMARY KEY (Order_id),
		CONSTRAINT
			NewOrders_CustomerID_FK FOREIGN KEY (Customer_id) REFERENCES NewCustomers(Customer_id),
		CONSTRAINT
			NewProducts_ProductID_FK FOREIGN KEY (Product_id) REFERENCES NewProducts(Product_id)
);