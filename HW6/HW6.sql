USE semimar_4;

/* Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру, 
с помощью которой можно переместить любого (одного) пользователя из таблицы users в таблицу users_old. 
(использование транзакции с выбором commit или rollback – обязательно). */

DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old(
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);

DELIMITER //

DROP PROCEDURE IF EXISTS move_user;
CREATE PROCEDURE  move_user (IN user_id INT) 
	DETERMINISTIC
BEGIN
INSERT INTO users_old (firstname, lastname, email) 
SELECT firstname, lastname, email 
	FROM users 
	WHERE users.id = user_id;
DELETE FROM users 
	WHERE id = user_id;
COMMIT;
END//

DELIMITER ;

CALL move_user(7);

/* Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи". */

DELIMITER //
CREATE FUNCTION hello()
	RETURNS VARCHAR(25)
    DETERMINISTIC
BEGIN
DECLARE hello_text VARCHAR(25);
SELECT CASE
	WHEN CURRENT_TIME >= "00:00:00" AND CURRENT_TIME < "06:00:00" THEN "Доброй ночи"
	WHEN CURRENT_TIME >= "06:00:00" AND CURRENT_TIME < "12:00:00" THEN "Доброе утро"
	WHEN CURRENT_TIME >= "12:00:00" AND CURRENT_TIME < "18:00:00" THEN "Добрый день"
	ELSE "Добрый вечер"
END INTO hello_text;
RETURN hello_text;
END//

DELIMITER ;

SELECT hello();

/* (по желанию)* Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, communities и messages в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа. */

