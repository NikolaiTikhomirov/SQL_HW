USE semimar_4;


/* Создайте представление, в которое попадет информация о пользователях (имя, фамилия, город и пол), которые не старше 20 лет. */

CREATE VIEW HW5task1 AS
SELECT u.firstname, u.lastname, p.hometown, p.gender
FROM users AS u
JOIN profiles AS p ON u.id = p.user_id
WHERE TIMESTAMPDIFF(YEAR, p.birthday, CURDATE()) < 20;

SELECT * FROM HW5task1;

/* Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный список пользователей,
указав имя и фамилию пользователя, количество отправленных сообщений и место в рейтинге
(первое место у пользователя с максимальным количеством сообщений) . (используйте DENSE_RANK) */

CREATE VIEW HW5task2 AS
SELECT u.firstname, u.lastname, COUNT(m.from_user_id) AS messages_count
FROM users AS u
JOIN messages AS m ON u.id = m.from_user_id
GROUP BY u.id;

SELECT
	firstname, 
	lastname,
    messages_count,
    DENSE_RANK()
    OVER(ORDER BY messages_count DESC) AS "dense_rank"
FROM HW5task2;

/* Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at) 
и найдите разницу дат отправления между соседними сообщениями, получившегося списка. (используйте LEAD или LAG) */

SELECT created_at, body,
TIMESTAMPDIFF(second, LAG(created_at) OVER(ORDER BY created_at), created_at) AS "sent_after_prev_msg(second)"
FROM messages
ORDER BY created_at;
