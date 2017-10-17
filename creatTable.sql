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
name_discount NVARCHAR (50) NOT NULL UNIQUE
)
GO

INSERT INTO type_discount VALUES ('���������� ������')
INSERT INTO type_discount VALUES ('2 ���� �� ���� ������')
INSERT INTO type_discount VALUES ('-200$ �� ��� � ������')
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
GO

CREATE TABLE voyage_fly(
id_voyage_fly INT NOT NULL PRIMARY KEY IDENTITY (1,1),
departure_there INT NOT NULL,
arrival_from INT NOT NULL,
price_fly INT NOT NULL,
city_id INT NOT NULL FOREIGN KEY REFERENCES city(id_city) ON DELETE CASCADE
)
GO

CREATE TABLE hotel(
id_hotel INT NOT NULL PRIMARY KEY IDENTITY (1,1),
name_hotel NVARCHAR (50) NOT NULL UNIQUE,
price_hotel INT NOT NULL,
city_id INT NOT NULL FOREIGN KEY REFERENCES city(id_city) ON DELETE CASCADE,
type_room_id INT NOT NULL FOREIGN KEY REFERENCES type_room(id_room)ON DELETE CASCADE
)
GO

CREATE TABLE tour(
id_tour INT NOT NULL PRIMARY KEY IDENTITY (1,1),
city_id INT NOT NULL FOREIGN KEY REFERENCES city(id_city) ON DELETE CASCADE,
hotel_id INT NOT NULL FOREIGN KEY REFERENCES hotel(id_hotel),
type_tour_id INT NOT NULL FOREIGN KEY REFERENCES type_tour(id_type_tour) ON DELETE CASCADE,
type_food_id INT NOT NULL FOREIGN KEY REFERENCES type_food(id_food),
voyage_fly_id INT NOT NULL FOREIGN KEY REFERENCES voyage_fly(id_voyage_fly),
discount_id INT NOT NULL FOREIGN KEY REFERENCES type_discount(id_discount) ON DELETE CASCADE,
quantity_tour INT NOT NULL,
price_tour INT NOT NULL,
)
GO

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
