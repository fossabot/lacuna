-- Lacuna Database Initialization Script
-- This runs when PostgreSQL container starts for the first time

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create the main schema (tables are created by Alembic migrations)
-- This script just ensures the database is properly configured

-- Create read-only user for reporting (optional)
-- CREATE USER lacuna_readonly WITH PASSWORD 'readonly_password';
-- GRANT CONNECT ON DATABASE lacuna TO lacuna_readonly;

-- Log initialization
DO $$
BEGIN
    RAISE NOTICE 'Lacuna database initialized at %', NOW();
END $$;

