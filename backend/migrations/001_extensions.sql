-- 001_extensions.sql
-- Habilita extensões necessárias: pgcrypto para gen_random_uuid, postgis para geoespacial, citext para emails case-insensitive

CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS citext;
