/*CREATE DATABASE travel_agency;
GO
USE travel_agency
GO*/

CREATE TABLE user_group(
id_user_group INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_user_group NVARCHAR (50) NOT NULL UNIQUE
)
GO

INSERT INTO user_group VALUES ('��������')
INSERT INTO user_group VALUES ('��������� ��������')
INSERT INTO user_group VALUES ('�������������')
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

INSERT INTO users VALUES ('������','�������','��������','dd@ff',(SELECT id_user_group FROM user_group WHERE name_user_group='��������'))
INSERT INTO users VALUES ('������','������','��������','ddd@fff',(SELECT id_user_group FROM user_group WHERE name_user_group='��������'))
INSERT INTO users VALUES ('������','�������','��������','dddd@ffff',(SELECT id_user_group FROM user_group WHERE name_user_group='��������'))
INSERT INTO users VALUES ('�������','��������','���������','lll@ffff',(SELECT id_user_group FROM user_group WHERE name_user_group='��������� ��������'))
INSERT INTO users VALUES ('�������','�����','���������','kkk@ffff',(SELECT id_user_group FROM user_group WHERE name_user_group='�������������'))
GO

CREATE TABLE country(
id_country INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_country NVARCHAR (50) NOT NULL UNIQUE
)
GO

INSERT INTO country VALUES ('������')
INSERT INTO country VALUES ('������')
INSERT INTO country VALUES ('������')
INSERT INTO country VALUES ('������')
INSERT INTO country VALUES ('�������')
INSERT INTO country VALUES ('�������')
GO



CREATE TABLE type_tour(
id_type_tour INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_type_tour NVARCHAR (50) NOT NULL UNIQUE
)
GO

INSERT INTO type_tour VALUES ('������')
INSERT INTO type_tour VALUES ('������� �����')
INSERT INTO type_tour VALUES ('������')
INSERT INTO type_tour VALUES ('����������')
GO

CREATE TABLE type_room(
id_room INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_type_room NVARCHAR (50) NOT NULL UNIQUE
)
GO

INSERT INTO type_room VALUES ('�����������')
INSERT INTO type_room VALUES ('�����������')
INSERT INTO type_room VALUES ('�����������')
INSERT INTO type_room VALUES ('����')
GO

CREATE TABLE type_food(
id_food INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_type_food NVARCHAR (50) NOT NULL UNIQUE
)
GO

INSERT INTO type_food VALUES ('��� �������')
INSERT INTO type_food VALUES ('�������')
INSERT INTO type_food VALUES ('������� � ����')
INSERT INTO type_food VALUES ('��� ��������')
GO

CREATE TABLE type_discount(
id_discount INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_discount NVARCHAR (50) NOT NULL UNIQUE,
value INT DEFAULT 0
)
GO
INSERT INTO type_discount VALUES ('���������� ������ 0%',0)
INSERT INTO type_discount VALUES ('2 ���� �� ���� ������',2)
INSERT INTO type_discount VALUES ('-200$ �� ��� � ������',200)
INSERT INTO type_discount VALUES ('���������� ������ 10%',10)
GO


CREATE TABLE city(
id_city INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_city NVARCHAR (50) NOT NULL UNIQUE,
contry_id INT NOT NULL FOREIGN KEY REFERENCES country(id_country) ON DELETE CASCADE
)
GO

INSERT INTO city VALUES ('�����', (SELECT id_country FROM country WHERE name_country='������'))
INSERT INTO city VALUES ('���', (SELECT id_country FROM country WHERE name_country='������'))
INSERT INTO city VALUES ('�������', (SELECT id_country FROM country WHERE name_country='������'))
INSERT INTO city VALUES ('�������', (SELECT id_country FROM country WHERE name_country='������'))
INSERT INTO city VALUES ('�������', (SELECT id_country FROM country WHERE name_country='�������'))
INSERT INTO city VALUES ('�����', (SELECT id_country FROM country WHERE name_country='�������'))
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

INSERT INTO voyage_fly VALUES ((SELECT id_city FROM city WHERE name_city='�����'),01012017,(SELECT id_city FROM city WHERE name_city='�����'),01012017,150)
INSERT INTO voyage_fly VALUES ((SELECT id_city FROM city WHERE name_city='�����'),08012017,(SELECT id_city FROM city WHERE name_city='�����'),08012017,150)
INSERT INTO voyage_fly VALUES ((SELECT id_city FROM city WHERE name_city='�����'),08012017,(SELECT id_city FROM city WHERE name_city='���'),08012017,150)
INSERT INTO voyage_fly VALUES ((SELECT id_city FROM city WHERE name_city='���'),18012017,(SELECT id_city FROM city WHERE name_city='�����'),18012017,150)
INSERT INTO voyage_fly VALUES ((SELECT id_city FROM city WHERE name_city='�����'),20012017,(SELECT id_city FROM city WHERE name_city='�������'),20012017,200)
INSERT INTO voyage_fly VALUES ((SELECT id_city FROM city WHERE name_city='�������'),30012017,(SELECT id_city FROM city WHERE name_city='�����'),30012017,200)
GO

CREATE TABLE hotel(
id_hotel INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_hotel NVARCHAR (50) NOT NULL UNIQUE,
price_hotel INT NOT NULL,
city_id INT NOT NULL FOREIGN KEY REFERENCES city(id_city) ON DELETE CASCADE,
type_room_id INT NOT NULL FOREIGN KEY REFERENCES type_room(id_room)ON DELETE CASCADE
)
GO

INSERT INTO hotel VALUES ('Hotel Limo',300,(SELECT id_city FROM city WHERE name_city='�����'),(SELECT id_room FROM type_room WHERE name_type_room='�����������'))
INSERT INTO hotel VALUES ('Hotel Vladio',500,(SELECT id_city FROM city WHERE name_city='���'),(SELECT id_room FROM type_room WHERE name_type_room='�����������'))
INSERT INTO hotel VALUES ('Hotel Sharm',500,(SELECT id_city FROM city WHERE name_city='�������'),(SELECT id_room FROM type_room WHERE name_type_room='�����������'))
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

INSERT INTO tour VALUES ('���������� �����',(SELECT id_city FROM city WHERE name_city='�����'),(SELECT id_hotel FROM hotel WHERE name_hotel='Hotel Limo'),
(SELECT id_type_tour FROM type_tour WHERE name_type_tour='������'),(SELECT id_food FROM type_food WHERE name_type_food='��� ��������'),
1,2,1,10,((SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=1)+(SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=2)+(SELECT price_hotel  FROM hotel WHERE id_hotel=1))),
('���������� ���',(SELECT id_city FROM city WHERE name_city='���'),(SELECT id_hotel FROM hotel WHERE name_hotel='Hotel Vladio'),
(SELECT id_type_tour FROM type_tour WHERE name_type_tour='������'),(SELECT id_food FROM type_food WHERE name_type_food='��� ��������'),
3,4,1,10,((SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=3)+(SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=4)+(SELECT price_hotel  FROM hotel WHERE id_hotel=2))),
('������� ����',(SELECT id_city FROM city WHERE name_city='�������'),(SELECT id_hotel FROM hotel WHERE name_hotel='Hotel Sharm'),
(SELECT id_type_tour FROM type_tour WHERE name_type_tour='������� �����'),(SELECT id_food FROM type_food WHERE name_type_food='��� ��������'),
5,6,1,10,((SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=5)+(SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=6)+(SELECT price_hotel  FROM hotel WHERE id_hotel=3)))
GO

INSERT INTO tour VALUES ('������� ���� �����!',(SELECT id_city FROM city WHERE name_city='�������'),(SELECT id_hotel FROM hotel WHERE name_hotel='Hotel Sharm'),
(SELECT id_type_tour FROM type_tour WHERE name_type_tour='������� �����'),(SELECT id_food FROM type_food WHERE name_type_food='��� ��������'),
5,6,3,5,(((SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=5)+(SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=6)+(SELECT price_hotel  FROM hotel WHERE id_hotel=3))-(SELECT value FROM type_discount WHERE type_discount.id_discount=3)))
GO

INSERT INTO tour VALUES ('������� ���� �����! 2 ���� �� ���� ������',(SELECT id_city FROM city WHERE name_city='�������'),(SELECT id_hotel FROM hotel WHERE name_hotel='Hotel Sharm'),
(SELECT id_type_tour FROM type_tour WHERE name_type_tour='������� �����'),(SELECT id_food FROM type_food WHERE name_type_food='��� ��������'),
5,6,2,6,(((SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=5)+(SELECT price_fly FROM voyage_fly WHERE id_voyage_fly=6)+(SELECT price_hotel  FROM hotel WHERE id_hotel=3))/(SELECT value FROM type_discount WHERE type_discount.id_discount=2)))
GO

/*
DELETE FROM tour �������� �����
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

/*������������������������ �����������������������
������� ������ ��������� ������� �� ��������,
�������������������������������� ����������������*/

CREATE VIEW promotional_offers
AS
select name_discount AS [��� �����������], name_tour AS [��������� ����],price_tour AS [���� ����],name_hotel AS [�������� ���������], name_city AS [�����],name_country AS [������]
 from tour
join type_discount  on tour.discount_id=type_discount.id_discount 
join hotel on tour.hotel_id=hotel.id_hotel 
join city on tour.city_id=city.id_city
join country on city.contry_id=id_country
WHERE tour.discount_id>1
GO

SELECT * FROM promotional_offers
GO

/*����������� ���������, ����������� ���������
��������� ����������� �� ������� � ��������� ������ (3
���������,���������������������������).*/

CREATE PROCEDURE discounts1 (@country nvarchar(30))
AS
DECLARE @idtour int
SET @idtour=(SELECT id_tour FROM tour
join city on tour.city_id=city.id_city
join country on city.contry_id=id_country
WHERE tour.discount_id=1 AND
name_country=@country)
UPDATE tour SET discount_id=(SELECT id_discount FROM type_discount WHERE name_discount='2 ���� �� ���� ������'),
price_tour=price_tour/2
WHERE id_tour=@idtour
GO

EXEC discounts1 '������'
GO

CREATE PROCEDURE discountsEgypt
AS
DECLARE @idtour int
SET @idtour=(SELECT id_tour FROM tour
join city on tour.city_id=city.id_city
join country on city.contry_id=id_country
WHERE tour.discount_id=1 AND
name_country='������')
UPDATE tour SET discount_id=(SELECT id_discount FROM type_discount WHERE name_discount='-200$ �� ��� � ������'),
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
UPDATE tour SET discount_id=(SELECT id_discount FROM type_discount WHERE name_discount='���������� ������ 10%'),
price_tour=price_tour*0.9
WHERE id_tour=@idtour
GO

EXEC [discounts10%]'������'
GO

--����������� �������, ����������� �������������
--�������,����������� id ���� � ����� ������������.

CREATE FUNCTION FancReserv (@idTour int, @emailUser nvarchar(30))
RETURNS  TABLE 
AS
RETURN(
SELECT u.id_users, t.id_tour, quantity_tour=1 FROM tour t 
JOIN users u ON  u.email=@emailUser
WHERE t.id_tour=@idTour
)
GO
-- � ��� �������� ������ � ������� ������ ���������
CREATE PROCEDURE ReserVtour (@idTour int, @emailUser nvarchar(30))
AS
INSERT INTO reserv VALUES((SELECT id_users FROM FancReserv (@idTour, @emailUser)),(SELECT id_tour FROM FancReserv (@idTour, @emailUser)),
(SELECT quantity_tour FROM FancReserv (@idTour, @emailUser)))
GO

EXEC ReserVtour 10, ddd@fff
GO

/*����������� ������� ��� ������ ����� � ������, ���
������� ��������� ���� �� ��������� ���������� ��������.*/

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