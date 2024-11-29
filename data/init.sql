DROP DATABASE IF EXISTS elastic_db;

CREATE DATABASE elastic_db;
USE elastic_db;

CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Inserir roles iniciais
INSERT INTO roles (name, description) VALUES 
('admin', 'adm'),
('user', 'user');

-- Inserir usuários
INSERT INTO users (role_id, username, email, password_hash, full_name) VALUES 
(1, 'admin', 'admin@example.com', 'hash123', 'Administrador'),
(2, 'user', 'user@example.com', 'hash123', 'user');

-- Inserir produtos iniciais
INSERT INTO products (name, description, price, stock) VALUES 
('Product 1', 'Description for product 1', 19.99, 100),
('Product 2', 'Description for product 2', 29.99, 200),
('Product 3', 'Description for product 3', 39.99, 300);