-- Kreiranje baze
CREATE DATABASE IF NOT EXISTS taskforge;
USE taskforge;

-- USERS tabela
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('USER', 'ADMIN') DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- PROJECTS tabela
CREATE TABLE projects (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    owner_id BIGINT NOT NULL,
    status ENUM('ACTIVE', 'COMPLETED', 'ARCHIVED') DEFAULT 'ACTIVE',
    priority ENUM('LOW', 'MEDIUM', 'HIGH') DEFAULT 'MEDIUM',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_project_owner
        FOREIGN KEY (owner_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);

-- TASKS tabela
CREATE TABLE tasks (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    status ENUM('TODO', 'IN_PROGRESS', 'DONE') DEFAULT 'TODO',
    priority ENUM('LOW', 'MEDIUM', 'HIGH') DEFAULT 'MEDIUM',
    project_id BIGINT NOT NULL,
    assigned_user_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_task_project
        FOREIGN KEY (project_id)
        REFERENCES projects(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_task_user
        FOREIGN KEY (assigned_user_id)
        REFERENCES users(id)
        ON DELETE SET NULL
);

-- PROJECT MEMBERS tabela (Many-to-Many)
CREATE TABLE project_members (
    project_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (project_id, user_id),
    CONSTRAINT fk_pm_project
        FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
    CONSTRAINT fk_pm_user
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- =====================
-- INSERT DATA
-- =====================

INSERT INTO users (username, email, password, role) VALUES
('admin', 'admin@taskforge.com', '$2a$10$cOMoMqxzsb.AWtR6y9q9WuHEFMPNGG.4AlL2YnwCIF0gv3.BBKw1W', 'ADMIN'),
('john',  'john@taskforge.com',  '$2a$10$cOMoMqxzsb.AWtR6y9q9WuHEFMPNGG.4AlL2YnwCIF0gv3.BBKw1W', 'USER'),
('sara',  'sara@taskforge.com',  '$2a$10$cOMoMqxzsb.AWtR6y9q9WuHEFMPNGG.4AlL2YnwCIF0gv3.BBKw1W', 'USER'),
('mike',  'mike@taskforge.com',  '$2a$10$cOMoMqxzsb.AWtR6y9q9WuHEFMPNGG.4AlL2YnwCIF0gv3.BBKw1W', 'USER'),
('ana',   'ana@taskforge.com',   '$2a$10$cOMoMqxzsb.AWtR6y9q9WuHEFMPNGG.4AlL2YnwCIF0gv3.BBKw1W', 'USER');


INSERT INTO projects (name, description, owner_id, status, priority) VALUES
('Project Alpha', 'Backend API development', 1, 'ACTIVE',    'HIGH'),
('Project Beta',  'Mobile app development',  1, 'ACTIVE',    'MEDIUM'),
('Project Gamma', 'Frontend dashboard',      2, 'COMPLETED', 'LOW');

INSERT INTO project_members (project_id, user_id) VALUES
(1, 1), (1, 2), (1, 3),
(2, 1), (2, 4), (2, 5),
(3, 2), (3, 3), (3, 5);

INSERT INTO tasks (title, description, status, priority, project_id, assigned_user_id) VALUES
('Setup backend',      'Initialize Spring Boot',      'DONE',        'HIGH',   1, 2),
('Create auth API',    'JWT login and register',      'IN_PROGRESS', 'HIGH',   1, 2),
('Setup database',     'Docker MySQL config',         'DONE',        'MEDIUM', 1, 3),
('Write unit tests',   'Test auth endpoints',         'TODO',        'MEDIUM', 1, 3),
('Design mockups',     'Figma screens for mobile',   'DONE',        'HIGH',   2, 4),
('Setup React Native', 'Initialize mobile project',  'IN_PROGRESS', 'HIGH',   2, 4),
('API integration',    'Connect mobile to backend',  'TODO',        'MEDIUM', 2, 5),
('Setup React',        'Initialize frontend project','IN_PROGRESS', 'HIGH',   3, 3),
('Build dashboard',    'Main dashboard UI',          'TODO',        'HIGH',   3, 5),
('Auth pages',         'Login and register pages',   'TODO',        'MEDIUM', 3, 2);