CREATE TABLE IF NOT EXISTS todos (
    id BIGINT PRIMARY KEY IDENTITY,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(500),
    completed BIT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);