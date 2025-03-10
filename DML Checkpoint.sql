--Write the appropriate SQL queries to insert all the provided records in their corresponding tables.

ALTER TABLE NewProducts
ADD Category VARCHAR (255);

INSERT INTO NewCustomers VALUES 
	(1, 'Ahmed', 'Tunisia'),
	(2, 'Coulibaly', 'Senegal'),
	(3, 'Hasan', 'Egypt'),
	(4, 'Yasmine', 'Morocco'),
	(5, 'John', 'France'),
	(6, 'Fatima', 'Algeria');

INSERT INTO NewProducts VALUES 
	(1, 'Cookies', 10, 'Snacks');
	(2, 'Candy', 5.2, 'Sweets'),
	(3, 'Chips', 8.5, 'Snacks'),
	(4,  'Juice', 15, 'Beverages'),
	(5, 'Ice Cream', 12, 'Desserts');

INSERT INTO NewOrders VALUES 
	(1, 1, 2, 3, '2023-01-22'),
	(2, 2, 1, 10, '2023-04-14'),
	(3, 3, 4, 5, '2023-06-10'),
	(4, 5, 3, 7, '2023-07-05'),
	(5, 6, 5, 2, '2023-10-15');


--Update the quantity of the second order, the new value should be 6.

UPDATE NewOrders SET Quantity = 6 WHERE Quantity = 10;


--Delete the third customer from the customers table.

ALTER TABLE NewOrders
DROP CONSTRAINT NewOrders_CustomerID_FK;

ALTER TABLE NewOrders
ADD CONSTRAINT NewOrders_CustomerID_FK FOREIGN KEY (Customer_id) REFERENCES NewCustomers(Customer_id) ON DELETE CASCADE;
 
DELETE FROM NewCustomers WHERE Customer_id = 3;



SELECT * FROM NewCustomers;