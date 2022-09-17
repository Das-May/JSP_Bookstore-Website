create database bookDatabase;
use bookDatabase;
CREATE TABLE user (
    logname CHAR(30) NOT NULL,
    password VARCHAR(30)CHARACTER SET UTF8,
    phone CHAR(20),
    address CHAR(50)CHARACTER SET GB2312,
    realname CHAR(60)CHARACTER SET GB2312,
    PRIMARY KEY (logname)
);

CREATE TABLE bookForm (
    id CHAR(30) NOT NULL,
    book_name VARCHAR(50)CHARACTER SET GB2312,
    book_made VARCHAR(20)CHARACTER SET GB2312,
    book_price FLOAT,
    book_describe VARCHAR(100)CHARACTER SET GB2312,
    PRIMARY KEY (id)
);

CREATE TABLE shoppingForm (
    goodsId CHAR(30) NOT NULL,
    logname CHAR(30) NOT NULL,
    goodsName VARCHAR(50)CHARACTER SET GB2312,
    goodsPrice FLOAT,
    goodsAmount INT,
    FOREIGN KEY (logname)
        REFERENCES user (logname)
);

CREATE TABLE orderForm (
    orderNumber INT NOT NULL AUTO_INCREMENT,
    logname CHAR(30)CHARACTER SET GB2312,
    mess VARCHAR(5000)CHARACTER SET GB2312,
    PRIMARY KEY (orderNumber)
);

CREATE TABLE adm (
    logname CHAR(30) NOT NULL,
    password VARCHAR(30)CHARACTER SET UTF8,
    PRIMARY KEY (logname)
);
