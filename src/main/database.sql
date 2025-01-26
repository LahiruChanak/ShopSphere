CREATE DATABASE ecommerce;

USE ecommerce;

CREATE TABLE customer
(
    id             INT AUTO_INCREMENT PRIMARY KEY,
    name           VARCHAR(100)                NOT NULL,
    email          VARCHAR(255)                NOT NULL UNIQUE,
    password       VARCHAR(255)                NOT NULL,
    address        VARCHAR(255),
    phoneNumber    VARCHAR(255),
    registeredDate TIMESTAMP                   NOT NULL,
    image          LONGBLOB,
    status         ENUM ('Active', 'Inactive') NOT NULL DEFAULT 'Active'
);

# ALTER TABLE customer
#     ADD COLUMN status ENUM ('Active', 'Inactive') NOT NULL DEFAULT 'Active';

CREATE TABLE category
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(255)             NOT NULL,
    description VARCHAR(255),
    status      ENUM ('Active', 'Draft') NOT NULL DEFAULT 'Draft',
    icon        LONGBLOB
);

CREATE TABLE product
(
    itemCode    INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(255)   NOT NULL,
    unitPrice   DECIMAL(10, 2) NOT NULL,
    description VARCHAR(255)   NOT NULL,
    qtyOnHand   INT            NOT NULL DEFAULT 0,
    image       LONGBLOB,
    categoryId  INT            NOT NULL,
    FOREIGN KEY (categoryId) REFERENCES category (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE orders
(
    orderId       VARCHAR(20) PRIMARY KEY,
    date          DATE NOT NULL,
    customerId    INT NOT NULL,
    address       VARCHAR(255) NOT NULL,
    city          VARCHAR(255) NOT NULL,
    state         VARCHAR(255) NOT NULL,
    zipCode       VARCHAR(255) NOT NULL,
    status        ENUM ('Pending', 'Shipped', 'Completed') NOT NULL DEFAULT 'Pending',
    subTotal      DECIMAL(10, 2) NOT NULL,
    delivery      DECIMAL(10, 2) NOT NULL,
    paymentMethod ENUM ('COD', 'Card') NOT NULL DEFAULT 'Card',
    FOREIGN KEY (customerId) REFERENCES customer (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE order_details
(
    orderId  VARCHAR(20) NOT NULL,
    itemCode INT         NOT NULL,
    quantity INT         NOT NULL,
    orderedSize VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL,
    FOREIGN KEY (orderId) REFERENCES orders (orderId) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (itemCode) REFERENCES product (itemCode) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE cart
(
    id     INT AUTO_INCREMENT PRIMARY KEY,
    customerId INT NOT NULL,
    FOREIGN KEY (customerId) REFERENCES customer (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE cart_details
(
    cartId   INT NOT NULL,
    itemCode INT NOT NULL,
    quantity INT NOT NULL,
    productSize VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL,
    FOREIGN KEY (itemCode) REFERENCES product (itemCode) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cartId) REFERENCES cart (id) ON UPDATE CASCADE ON DELETE CASCADE
);

drop table customer;

# for testing purposes
INSERT INTO orders (orderId, date, customerId, address, city, state, zipCode, subTotal, delivery, paymentMethod, status)
VALUES ('ORD123456', '2023-10-15', 1, '123 Main St', 'New York', 'NY',
        '10001', 99.99, 5.00, 'Card', 'Pending');
