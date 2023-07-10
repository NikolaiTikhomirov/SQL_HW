USE first_schema;

CREATE TABLE sales (
	id INT AUTO_INCREMENT PRIMARY KEY,
	order_date DATE,
    count_product INT
);

INSERT INTO sales (order_date, count_product)
VALUES
("2022-01-01", 156),
("2022-01-02", 180),
("2022-01-03", 21),
("2022-01-04", 124),
("2022-01-05", 341);

SELECT id,
CASE
WHEN count_product < 99 then "Маленький заказ"
WHEN count_product BETWEEN 100 AND 300 then "Средний заказ"
WHEN count_product > 301 then "Большой заказ"
END as sale_type
FROM sales;


CREATE TABLE orders (
	id INT AUTO_INCREMENT PRIMARY KEY,
	imployee_id VARCHAR(45),
    amount FLOAT,
    order_status VARCHAR(45)
);

INSERT INTO orders (imployee_id, amount, order_status)
VALUES
("e03", 15.00, "OPEN"),
("e01", 25.50, "OPEN"),
("e05", 100.0, "CLOSED"),
("e02", 22.18, "OPEN"),
("e04", 9.50, "CANCELLED");

SELECT id,
IF (order_status = "OPEN", "Order is in open state",
	IF (order_status = "CLOSED", "Order is closed",
		IF (order_status = "CANCELLED", "Order is cancelled", "Order is unknown"))) as full_order_status
FROM orders;
