USE semimar_4;

/* 1. Подсчитать общее количество лайков, которые получили пользователи младше 12 лет. */

SELECT u.id, u.firstname, p.birthday, COUNT(l.user_id) AS likecount
FROM users AS u
JOIN likes AS l ON u.id = l.user_id
JOIN profiles AS p ON u.id = p.user_id
WHERE TIMESTAMPDIFF(YEAR, p.birthday, CURDATE()) < 12
GROUP BY u.id;

/*
Определить кто больше поставил лайков (всего): мужчины или женщины. 
Я не нашел таблицы, где отображается информация о том, кто ставит лайки, по этому мой код высчитывает то,
кому больше поставили лайков: мужчинам или женщинам.
*/

SELECT p.gender, COUNT(l.user_id) AS likecount
FROM profiles AS p
JOIN likes AS l ON p.user_id = l.user_id
GROUP BY p.gender
ORDER BY likecount DESC LIMIT 1;

/* Вывести всех пользователей, которые не отправляли сообщения. */

SELECT id, firstname, lastname
FROM users
WHERE id NOT IN (SELECT from_user_id FROM messages);

/* (по желанию)* Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех написал ему сообщений. */