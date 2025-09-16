CREATE DATABASE sql_task_4;

-- Continuing with the previous task's Products table.
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT
);

-- CREATE AN AUDIT_LOG TABLE
CREATE TABLE audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(50),
    operation_type VARCHAR(10),    -- INSERT, UPDATE, DELETE
    record_id INT,
    old_data TEXT,
    new_data TEXT,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CURRENTLY THE TABLE SHOULD BE NULL (as no product has been entered)
SELECT * FROM audit_log;


-- INSERT TRIGGER
DELIMITER $$

CREATE TRIGGER trg_products_insert
AFTER INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO audit_log(table_name, operation_type, record_id, new_data)
    VALUES ('products', 'INSERT', NEW.product_id,
            CONCAT('Name=', NEW.name, ', Price=', NEW.price, ', Stock=', NEW.stock));
END$$

DELIMITER ;


-- UPDATE TRIGGER
DELIMITER $$

CREATE TRIGGER trg_products_update
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    INSERT INTO audit_log(table_name, operation_type, record_id, old_data, new_data)
    VALUES ('products', 'UPDATE', OLD.product_id,
            CONCAT('Name=', OLD.name, ', Price=', OLD.price, ', Stock=', OLD.stock),
            CONCAT('Name=', NEW.name, ', Price=', NEW.price, ', Stock=', NEW.stock));
END$$

DELIMITER ;


-- DELETE TRIGGER
DELIMITER $$

CREATE TRIGGER trg_products_delete
AFTER DELETE ON products
FOR EACH ROW
BEGIN
    INSERT INTO audit_log(table_name, operation_type, record_id, old_data)
    VALUES ('products', 'DELETE', OLD.product_id,
            CONCAT('Name=', OLD.name, ', Price=', OLD.price, ', Stock=', OLD.stock));
END$$

DELIMITER ;

-- INSERT SOME PRODUCTS
INSERT INTO products (name, price, stock) VALUES
('Laptop', 800.00, 10),
('Mouse', 20.00, 100);

-- UPDATE ANY PRODUCT
UPDATE products SET price = 850.00 WHERE product_id = 1;

-- DELETE ANY PRODUCT
DELETE FROM products WHERE product_id = 2;

-- VIEW AUDIT LOG TABLE
SELECT * FROM audit_log;
