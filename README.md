#INSERT SOME PRODUCTS  
INSERT INTO products (name, price, stock) VALUES  
('Laptop', 800.00, 10),  
('Mouse', 20.00, 100);  
  
#UPDATE ANY PRODUCT  
UPDATE products SET price = 850.00 WHERE product_id = 1;  
  
#DELETE ANY PRODUCT  
DELETE FROM products WHERE product_id = 2;  
  
#VIEW AUDIT LOG TABLE  
SELECT * FROM audit_log;  
