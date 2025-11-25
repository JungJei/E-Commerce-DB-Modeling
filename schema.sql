-- 1. 회원 (Users)
CREATE TABLE Users (
    user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. 카테고리 (Categories)
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- 3. 상품 (Products)
CREATE TABLE Products (
    product_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    price INT NOT NULL, -- 현재 판매가
    stock_quantity INT NOT NULL,
    status VARCHAR(20) DEFAULT 'ON_SALE',
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- 4. 주문 (Orders)
CREATE TABLE Orders (
    order_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'ORDERED',
    total_amount INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 5. 주문 상세 (Order_Items) - 핵심 테이블
CREATE TABLE Order_Items (
    order_item_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    count INT NOT NULL, -- 주문 수량
    order_price INT NOT NULL, -- 주문 시점의 가격 (이력 관리)
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- 6. 결제 (Payments)
CREATE TABLE Payments (
    payment_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    payment_method VARCHAR(50) NOT NULL, -- 카드, 무통장 등
    amount INT NOT NULL,
    status VARCHAR(20) DEFAULT 'COMPLETED',
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- 7. 배송 (Deliveries)
CREATE TABLE Deliveries (
    delivery_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    address VARCHAR(255) NOT NULL, -- 실제 배송지
    status VARCHAR(20) DEFAULT 'PREPARING', -- 배송준비, 배송중, 완료
    tracking_number VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
