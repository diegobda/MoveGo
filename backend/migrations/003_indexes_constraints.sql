-- 003_indexes_constraints.sql
-- Índices e constraints para performance

-- Users
CREATE UNIQUE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_phone ON users(phone);

-- Drivers: índice para buscas geoespaciais (se usar driver_current_locations)
CREATE INDEX IF NOT EXISTS idx_driver_locations_geom ON driver_current_locations USING GIST (location);
CREATE INDEX IF NOT EXISTS idx_drivers_online ON drivers (online) WHERE online = true;

-- Trips
CREATE INDEX IF NOT EXISTS idx_trips_status_created ON trips (status, created_at);
CREATE INDEX IF NOT EXISTS idx_trips_passenger ON trips (passenger_id);
CREATE INDEX IF NOT EXISTS idx_trips_driver ON trips (driver_id);

-- Payments
CREATE INDEX IF NOT EXISTS idx_payments_status_created ON payments (status, created_at);
CREATE UNIQUE INDEX IF NOT EXISTS idx_payments_idempotency ON payments (idempotency_key) WHERE idempotency_key IS NOT NULL;

-- Wallets
CREATE INDEX IF NOT EXISTS idx_wallets_user ON wallets (user_id);

-- Ratings
CREATE INDEX IF NOT EXISTS idx_ratings_ratee ON ratings (ratee_id);

-- Coupons
CREATE INDEX IF NOT EXISTS idx_coupons_code ON coupons (code);

-- Trip locations: example partition-specific index will be created per partition

-- Full-text / other indices as needed

-- Constraints
ALTER TABLE payments ADD CONSTRAINT payments_amount_positive CHECK (amount_cents >= 0);
ALTER TABLE wallet_transactions ADD CONSTRAINT wallet_tx_amount_nonzero CHECK (amount_cents <> 0);
