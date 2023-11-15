create database quan_ly_ban_hang;
use quan_ly_ban_hang;

create table category(
id int primary key auto_increment,
name varchar(50) unique,
status tinyint(1) default(1)
);

CREATE TABLE product (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    category_id INT,
    FOREIGN KEY (category_id)
        REFERENCES category (id),
    price FLOAT CHECK (price > 0),
    sale_price FLOAT,
    CONSTRAINT CHECK (sale_price < price)
);

create table customer(
id int primary key auto_increment,
name varchar(100),
email varchar(100),
birthday date,
gender tinyint(1)default(1)
);

create table orders(
id int primary key auto_increment,
customer_id int,
foreign key(customer_id)references customer(id),
created date default(current_date()),
status tinyint(1)default(1)
);

CREATE TABLE order_detail (
    orders_id INT,
    FOREIGN KEY (orders_id)
        REFERENCES orders (id),
    product_id INT,
    FOREIGN KEY (product_id)
        REFERENCES product (id),
    PRIMARY KEY (orders_id , product_id),
    quantity INT,
    price FLOAT
);

-- tạo customer
insert into customer(name,email,birthday,gender)values('Thịnh','thinh@gmail.com','2023-11-11',1);
insert into customer(name,email,birthday,gender)values('Huy','Huy@gmail.com','2023-11-1',1);
insert into customer(name,email,birthday,gender)values('Đức','Đức@gmail.com','2023-11-1',1);
insert into customer(name,email,birthday,gender)values('Tùng','Tùng@gmail.com','2023-11-1',1);
insert into customer(name,email,birthday,gender)values('Việt','Việt@gmail.com','2023-11-1',1);

-- tạo category
insert into category(name)values('IPHONE');
insert into category(name)values('IPAD');
insert into category(name)values('MACBOOK');
insert into category(name)values('APPLE WATCH');
insert into category(name)values('AIR PODS');

-- tạo product

insert into product(name,category_id,price,sale_price)values('Iphone15',1,30000000,25000000);
insert into product(name,category_id,price,sale_price)values('Macbook Pro',3,45000000,35000000);
insert into product(name,category_id,price,sale_price)values('Ipad Air',2,35000000,25000000);
insert into product(name,category_id,price,sale_price)values('AirPods Max',5,10000000,9000000);
insert into product(name,category_id,price,sale_price)values('Apple Watch s9',4,18000000,15000000);

-- tạo order
insert into orders(customer_id)values(1);
insert into orders(customer_id)values(2);
insert into orders(customer_id)values(3);
insert into orders(customer_id)values(4);
insert into orders(customer_id)values(5);

-- tạo order_detail
insert into order_detail(orders_id,product_id,quantity,price)values(1,1,2,25000000);
insert into order_detail(orders_id,product_id,quantity,price)values(2,2,2,25000000);
insert into order_detail(orders_id,product_id,quantity,price)values(3,3,2,25000000);
insert into order_detail(orders_id,product_id,quantity,price)values(4,4,2,25000000);
insert into order_detail(orders_id,product_id,quantity,price)values(5,5,2,25000000);

-- thêm cột vào orders
alter table orders add column note varchar(100);

SELECT o.id, c.name, o.created, o.status
from orders o
left join customer c 
on o.customer_id = c.id;

SELECT o.orders_id, p.name, o.quantity, p.price,( p.price * o.quantity) as total
FROM order_detail o
LEFT JOIN product p
ON o.product_id = p.id;

SELECT o.id, c.name as 'người mua',p.name as 'Tên sản phẩm',od.quantity,p.price, o.created, o.status, ( p.price * od.quantity) as total
FROM orders o
LEFT JOIN customer c 
ON o.customer_id = c.id
LEFT JOIN order_detail od
ON od.orders_id = o.id
LEFT JOIN product p
ON od.product_id = p.id;