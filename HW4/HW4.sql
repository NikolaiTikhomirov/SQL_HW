USE semimar_4;

/* 1. Подсчитать общее количество лайков, которые получили пользователи младше 12 лет. */

SELECT u.id, u.firstname, p.birthday, COUNT(l.user_id) AS likecount
FROM users AS u
JOIN likes AS l ON u.id = l.user_id
JOIN profiles AS p ON u.id = p.user_id
WHERE TIMESTAMPDIFF(YEAR, p.birthday, CURDATE()) < 12
GROUP BY u.id;

/* Определить кто больше поставил лайков (всего): мужчины или женщины. 
*/

SELECT T.gender, MAX(T.likecount) AS like_count
FROM (SELECT p.gender, COUNT(l.user_id) AS likecount
FROM profiles AS p
JOIN likes AS l ON p.user_id = l.user_id
GROUP BY p.gender) AS T;

/* Вывести всех пользователей, которые не отправляли сообщения.
(по желанию)* Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех написал ему сообщений. */