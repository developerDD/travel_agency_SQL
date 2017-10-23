/*CREATE DATABASE travel_agency;
GO
USE travel_agency
GO*/

CREATE TABLE user_group(
id_user_group INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_user_group NVARCHAR (50) NOT NULL UNIQUE
)
GO

INSERT INTO user_group VALUES ('Заказчик')
INSERT INTO user_group VALUES ('Сотрудник агенства')
INSERT INTO user_group VALUES ('Администратор')
GO

CREATE TABLE users(
id_users INT NOT NULL PRIMARY KEY IDENTITY (1,1),
surname NVARCHAR (50) NOT NULL,
name NVARCHAR (50) NOT NULL,
patronymic NVARCHAR (50) NOT NULL,
email NVARCHAR (50) NOT NULL UNIQUE,
user_group_id INT NOT NULL FOREIGN KEY REFERENCES user_group(id_user_group) ON DELETE CASCADE
)
GO

INSERT INTO users VALUES ('Журкин','Валерий','Петрович','dd@ff',(SELECT id_user_group FROM user_group WHERE name_user_group='Заказчик'))
INSERT INTO users VALUES ('Куркин','Сергей','Петрович','ddd@fff',(SELECT id_user_group FROM user_group WHERE name_user_group='Заказчик'))
INSERT INTO users VALUES ('Вуркин','Дмитрий','Олегович','dddd@ffff',(SELECT id_user_group FROM user_group WHERE name_user_group='Заказчик'))
INSERT INTO users VALUES ('Лукошко','Светлана','Сергеевна','lll@ffff',(SELECT id_user_group FROM user_group WHERE name_user_group='Сотрудник агенства'))
INSERT INTO users VALUES ('Кукушка','Алена','Василивна','kkk@ffff',(SELECT id_user_group FROM user_group WHERE name_user_group='Администратор'))
GO

CREATE TABLE country(
id_country INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_country NVARCHAR (50) NOT NULL UNIQUE
)
GO

INSERT INTO country VALUES ('Греция')
INSERT INTO country VALUES ('Италия')
INSERT INTO country VALUES ('Египет')
INSERT INTO country VALUES ('Турция')
INSERT INTO country VALUES ('Таиланд')
INSERT INTO country VALUES ('Украина')
GO



CREATE TABLE type_tour(
id_type_tour INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_type_tour NVARCHAR (50) NOT NULL UNIQUE
)
GO

INSERT INTO type_tour VALUES ('Туризм')
INSERT INTO type_tour VALUES ('Пляжный отдых')
INSERT INTO type_tour VALUES ('Бизнес')
INSERT INTO type_tour VALUES ('Спортивный')
GO

CREATE TABLE type_room(
id_room INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_type_room NVARCHAR (50) NOT NULL UNIQUE
)
GO

INSERT INTO type_room VALUES ('Одноместный')
INSERT INTO type_room VALUES ('Двухместный')
INSERT INTO type_room VALUES ('Трехместный')
INSERT INTO type_room VALUES ('Люкс')
GO

CREATE TABLE type_food(
id_food INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_type_food NVARCHAR (50) NOT NULL UNIQUE
)
GO

INSERT INTO type_food VALUES ('Без питания')
INSERT INTO type_food VALUES ('Завтрак')
INSERT INTO type_food VALUES ('Завтрак и Ужин')
INSERT INTO type_food VALUES ('Все включино')
GO

CREATE TABLE type_discount(
id_discount INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_discount NVARCHAR (50) NOT NULL UNIQUE,
value INT DEFAULT 0
)
GO
INSERT INTO type_discount VALUES ('Процентная скидка 0%',0)
INSERT INTO type_discount VALUES ('2 тура по цене одного',2)
INSERT INTO type_discount VALUES ('-200$ на тур в Египет',200)
INSERT INTO type_discount VALUES ('Процентная скидка 10%',10)
GO


CREATE TABLE city(
id_city INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_city NVARCHAR (50) NOT NULL UNIQUE,
contry_id INT NOT NULL FOREIGN KEY REFERENCES country(id_country) ON DELETE CASCADE
)
GO

INSERT INTO city VALUES ('Афины', (SELECT id_country FROM country WHERE name_country='Греция'))
INSERT INTO city VALUES ('Рим', (SELECT id_country FROM country WHERE name_country='Италия'))
INSERT INTO city VALUES ('Хургада', (SELECT id_country FROM country WHERE name_country='Египет'))
INSERT INTO city VALUES ('Анталия', (SELECT id_country FROM country WHERE name_country='Турция'))
INSERT INTO city VALUES ('Бангкок', (SELECT id_country FROM country WHERE name_country='Таиланд'))
INSERT INTO city VALUES ('Днепр', (SELECT id_country FROM country WHERE name_country='Украина'))
GO

CREATE TABLE voyage_fly(
id_voyage_fly INT NOT NULL PRIMARY KEY IDENTITY (1,1),
city_departure_id INT NOT NULL FOREIGN KEY REFERENCES city(id_city),
departure_there INT NOT NULL,
city_arrival_id INT NOT NULL FOREIGN KEY REFERENCES city(id_city),
arrival_from INT NOT NULL,
price_fly INT NOT NULL
)
GO

INSERT INTO voyage_fly VALUES ((SELECT id_city FROM city WHERE name_city='Днепр'),01012017,(SELECT id_city FROM city WHERE name_city='Афины'),01012017,150)
INSERT INTO voyage_fly VALUES ((SELECT id_city FROM city WHERE name_city='Афины'),08012017,(SELECT id_city FROM city WHERE name_city='Днепр'),08012017,150)
INSERT INTO voyage_fly VALUES ((SELECT id_city FROM city WHERE name_city='Днепр'),08012017,(SELECT id_city FROM city WHERE name_city='Рим'),08012017,150)
INSERT INTO voyage_fly VALUES ((SELECT id_city FROM city WHERE name_city='Рим'),18012017,(SELECT id_city FROM city WHERE name_city='Днепр'),18012017,150)
INSERT INTO voyage_fly VALUES ((SELECT id_city FROM city WHERE name_city='Днепр'),20012017,(SELECT id_city FROM city WHERE name_city='Хургада'),20012017,200)
INSERT INTO voyage_fly VALUES ((SELECT id_city FROM city WHERE name_city='Хургада'),30012017,(SELECT id_city FROM city WHERE name_city='Днепр'),30012017,200)
GO

CREATE TABLE hotel(
id_hotel INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_hotel NVARCHAR (50) NOT NULL UNIQUE,
price_hotel INT NOT NULL,
city_id INT NOT NULL FOREIGN KEY REFERENCES city(id_city) ON DELETE CASCADE,
type_room_id INT NOT NULL FOREIGN KEY REFERENCES type_room(id_room)ON DELETE CASCADE
)
GO

INSERT INTO hotel VALUES ('Hotel Limo',300,(SELECT id_city FROM city WHERE name_city='Афины'),(SELECT id_room FROM type_room WHERE name_type_room='Двухместный'))
INSERT INTO hotel VALUES ('Hotel Vladio',500,(SELECT id_city FROM city WHERE name_city='Рим'),(SELECT id_room FROM type_room WHERE name_type_room='Двухместный'))
INSERT INTO hotel VALUES ('Hotel Sharm',500,(SELECT id_city FROM city WHERE name_city='Хургада'),(SELECT id_room FROM type_room WHERE name_type_room='Двухместный'))
GO

CREATE TABLE tour(
id_tour INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_tour NVARCHAR (50) NOT NULL UNIQUE,
city_id INT NOT NULL FOREIGN KEY REFERENCES city(id_city) ON DELETE CASCADE,
hotel_id INT NOT NULL FOREIGN KEY REFERENCES hotel(id_hotel),
type_tour_id INT NOT NULL FOREIGN KEY REFERENCES type_tour(id_type_tour) ON DELETE CASCADE,
type_food_id INT NOT NULL FOREIGN KEY REFERENCES type_food(id_food),
departure_id INT NOT NULL FOREIGN KEY REFERENCES voyage_fly(id_voyage_fly),
arrival_id INT NOT NULL FOREIGN KEY REFERENCES voyage_fly(id_voyage_fly),
discount_id INT NOT NULL FOREIGN KEY REFERENCES type_discount(id_discount) ON DELETE CASCADE,
quantity_tour INT NOT NULL,
price_tour INT NOT NULL,
)
GO

INSERT INTO tour VALUES ('Прекрасные Афины',(SELECT id_city FROM city WHERE name_city='Афины'),(SELECT id_hotel FROM hotel WHERE name_hotel='Hotel Limo'),
(SELECT id_type_tour FROM type_tour WHERE name_type_tour='Туризм'),(SELECT id_food FROM type_food WHERE name_type_food='Все включино'),
1,2,1,10,((SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=1)+(SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=2)+(SELECT price_hotel  FROM hotel WHERE id_hotel=1))),
('Прекрасный Рим',(SELECT id_city FROM city WHERE name_city='Рим'),(SELECT id_hotel FROM hotel WHERE name_hotel='Hotel Vladio'),
(SELECT id_type_tour FROM type_tour WHERE name_type_tour='Бизнес'),(SELECT id_food FROM type_food WHERE name_type_food='Все включино'),
3,4,1,10,((SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=3)+(SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=4)+(SELECT price_hotel  FROM hotel WHERE id_hotel=2))),
('Красное море',(SELECT id_city FROM city WHERE name_city='Хургада'),(SELECT id_hotel FROM hotel WHERE name_hotel='Hotel Sharm'),
(SELECT id_type_tour FROM type_tour WHERE name_type_tour='Пляжный отдых'),(SELECT id_food FROM type_food WHERE name_type_food='Все включино'),
5,6,1,10,((SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=5)+(SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=6)+(SELECT price_hotel  FROM hotel WHERE id_hotel=3)))
GO

INSERT INTO tour VALUES ('Красное море акция!',(SELECT id_city FROM city WHERE name_city='Хургада'),(SELECT id_hotel FROM hotel WHERE name_hotel='Hotel Sharm'),
(SELECT id_type_tour FROM type_tour WHERE name_type_tour='Пляжный отдых'),(SELECT id_food FROM type_food WHERE name_type_food='Все включино'),
5,6,3,5,(((SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=5)+(SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=6)+(SELECT price_hotel  FROM hotel WHERE id_hotel=3))-(SELECT value FROM type_discount WHERE type_discount.id_discount=3)))
GO

INSERT INTO tour VALUES ('Красное море акция! 2 тура по цене одного',(SELECT id_city FROM city WHERE name_city='Хургада'),(SELECT id_hotel FROM hotel WHERE name_hotel='Hotel Sharm'),
(SELECT id_type_tour FROM type_tour WHERE name_type_tour='Пляжный отдых'),(SELECT id_food FROM type_food WHERE name_type_food='Все включино'),
5,6,2,6,(((SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=5)+(SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=6)+(SELECT price_hotel  FROM hotel WHERE id_hotel=3))/(SELECT value FROM type_discount WHERE type_discount.id_discount=2)))
GO

/*
DELETE FROM tour удаление строк
*/ 


CREATE TABLE reserv(
users_id INT NOT NULL FOREIGN KEY REFERENCES users(id_users) ON DELETE CASCADE,
tour_id INT NOT NULL FOREIGN KEY REFERENCES tour(id_tour) ON DELETE CASCADE,
quantity_reserv INT NOT NULL,
)
GO

CREATE TABLE sala(
id_sala INT NOT NULL PRIMARY KEY IDENTITY (1,1),
users_id INT NOT NULL FOREIGN KEY REFERENCES users(id_users) ON DELETE CASCADE,
tour_id INT NOT NULL FOREIGN KEY REFERENCES tour(id_tour) ON DELETE CASCADE,
quantity_tour_sala INT NOT NULL,
date_sala INT NOT NULL
)
GO

INSERT INTO sala VALUES (1,3,2,19012017)
UPDATE tour  SET quantity_tour=quantity_tour-(SELECT quantity_reserv FROM reserv WHERE reserv.tour_id=tour.id_tour) WHERE  tour.id_tour=2
GO

/*Реализоватьпредставление «Акционныепредложения»в
которое должны выводится путевки со скидками,
представлениедолжносодержатьполе «видпредложения»*/

CREATE VIEW promotional_offers
AS
select name_discount AS [Вид пердложения], name_tour AS [Назавание тура],price_tour AS [Цена тура],name_hotel AS [Название гостиници], name_city AS [Город],name_country AS [Страна]
 from tour
join type_discount  on tour.discount_id=type_discount.id_discount 
join hotel on tour.hotel_id=hotel.id_hotel 
join city on tour.city_id=city.id_city
join country on city.contry_id=id_country
WHERE tour.discount_id>1
GO

SELECT * FROM promotional_offers
GO

/*Реализовать процедуру, позволяющую добавлять
акционные предложения на путевки в указанную страну (3
процедуры,пооднойдлякаждоговидаскидок).*/

CREATE PROCEDURE discounts1 (@country nvarchar(30))
AS
DECLARE @idtour int
SET @idtour=(SELECT id_tour FROM tour
join city on tour.city_id=city.id_city
join country on city.contry_id=id_country
WHERE tour.discount_id=1 AND
name_country=@country)
UPDATE tour SET discount_id=(SELECT id_discount FROM type_discount WHERE name_discount='2 тура по цене одного'),
price_tour=price_tour/2
WHERE id_tour=@idtour
GO

EXEC discounts1 'Греция'
GO

CREATE PROCEDURE discountsEgypt
AS
DECLARE @idtour int
SET @idtour=(SELECT id_tour FROM tour
join city on tour.city_id=city.id_city
join country on city.contry_id=id_country
WHERE tour.discount_id=1 AND
name_country='Египет')
UPDATE tour SET discount_id=(SELECT id_discount FROM type_discount WHERE name_discount='-200$ на тур в Египет'),
price_tour=price_tour-200
WHERE id_tour=@idtour
GO

EXEC discountsEgypt
GO

CREATE PROCEDURE [discounts10%] (@country nvarchar(30))
AS
DECLARE @idtour int
SET @idtour=(SELECT id_tour FROM tour
join city on tour.city_id=city.id_city
join country on city.contry_id=id_country
WHERE tour.discount_id=1 AND
name_country=@country)
UPDATE tour SET discount_id=(SELECT id_discount FROM type_discount WHERE name_discount='Процентная скидка 10%'),
price_tour=price_tour*0.9
WHERE id_tour=@idtour
GO

EXEC [discounts10%]'Италия'
GO

--Реализовать функцию, позволяющую забронировать
--путевку,принимающую id тура и логин пользователя.

CREATE FUNCTION FancReserv (@idTour int, @emailUser nvarchar(30))
RETURNS  TABLE 
AS
RETURN(
SELECT u.id_users, t.id_tour, quantity_tour=1 FROM tour t 
JOIN users u ON  u.email=@emailUser
WHERE t.id_tour=@idTour
)
GO
-- с для удобства работы с функией создал процедуру
CREATE PROCEDURE ReserVtour (@idTour int, @emailUser nvarchar(30))
AS
INSERT INTO reserv VALUES((SELECT id_users FROM FancReserv (@idTour, @emailUser)),(SELECT id_tour FROM FancReserv (@idTour, @emailUser)),
(SELECT quantity_tour FROM FancReserv (@idTour, @emailUser)))
GO

EXEC ReserVtour 10, ddd@fff
GO

/*Реализовать функцию для выбора туров в страны, где
средняя стоимость тура не превышает переданное значение.*/

CREATE FUNCTION TourAVGPrice (@price int)
RETURNS  TABLE 
AS
RETURN(
SELECT name_country AS Country,AVG (price_tour) AS AVGPrice FROM tour
JOIN city ON tour.city_id=city.id_city
JOIN country ON country.id_country=city.id_city
GROUP BY name_country
HAVING AVG (price_tour)>@price
)
GO

SELECT * FROM TourAVGPrice(200)