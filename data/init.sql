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

-- Inserir roles iniciais
INSERT INTO roles (name, description) VALUES 
('admin', 'Administrador do sistema'),
('user', 'Usuário padrão');

-- Inserir usuário admin
INSERT INTO users (role_id, username, email, password_hash, full_name) 
SELECT id, 'admin', 'admin@example.com', 'hash123', 'Administrador'
FROM roles WHERE name = 'admin';

-- Inserir usuário user
INSERT INTO users (role_id, username, email, password_hash, full_name) 
SELECT id, 'user', 'user@example.com', 'hash123', 'user'
FROM roles WHERE name = 'user';