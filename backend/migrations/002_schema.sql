-- 002_schema.sql
-- Tipos ENUM

CREATE TYPE driver_status AS ENUM ('pending','approved','blocked');
CREATE TYPE trip_status AS ENUM ('requested','accepted','enroute','in_progress','completed','cancelled');
CREATE TYPE payment_status AS ENUM ('pending','succeeded','failed','refunded');
CREATE TYPE payment_provider AS ENUM ('stripe','pix','wallet');
CREATE TYPE coupon_type AS ENUM ('percent','fixed');
CREATE TYPE admin_role AS ENUM ('superadmin','admin','support');
CREATE TYPE trip_location_type AS ENUM ('pickup','dropoff','waypoint','ping');

-- Tabelas principais

CREATE TABLE IF NOT EXISTS users (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email citext UNIQUE,
  phone varchar(32) UNIQUE,
  password_hash text,
  name text,
  photo_url text,
  metadata jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS drivers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  cpf varchar(32) UNIQUE,
  cnh_number varchar(64),
  status driver_status DEFAULT 'pending',
  online boolean DEFAULT false,
  rating numeric(3,2) DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS vehicles (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  driver_id uuid NOT NULL REFERENCES drivers(id) ON DELETE CASCADE,
  plate varchar(32),
  model varchar(128),
  color varchar(64),
  year int,
  document_url text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS trips (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  passenger_id uuid NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
  driver_id uuid REFERENCES drivers(id) ON DELETE SET NULL,
  status trip_status DEFAULT 'requested',
  fare_cents bigint,
  commission_cents bigint,
  start_time timestamptz,
  end_time timestamptz,
  distance_meters int,
  duration_seconds int,
  route geometry(Geometry,4326),
  metadata jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Trip locations: parent partitioned table (RANGE by recorded_at)
CREATE TABLE IF NOT EXISTS trip_locations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  trip_id uuid NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
  location geometry(Point,4326) NOT NULL,
  recorded_at timestamptz NOT NULL DEFAULT now(),
  type trip_location_type DEFAULT 'ping'
) PARTITION BY RANGE (recorded_at);

-- Payments and idempotency
CREATE TABLE IF NOT EXISTS payments (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  trip_id uuid REFERENCES trips(id) ON DELETE SET NULL,
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
  amount_cents bigint NOT NULL,
  currency varchar(3) NOT NULL DEFAULT 'BRL',
  status payment_status DEFAULT 'pending',
  provider payment_provider,
  provider_payment_id text,
  idempotency_key text,
  metadata jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Wallet and ledger
CREATE TABLE IF NOT EXISTS wallets (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE UNIQUE,
  balance_cents bigint DEFAULT 0,
  currency varchar(3) DEFAULT 'BRL',
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS wallet_transactions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  wallet_id uuid NOT NULL REFERENCES wallets(id) ON DELETE CASCADE,
  amount_cents bigint NOT NULL,
  type varchar(32) NOT NULL,
  reference_id uuid,
  metadata jsonb,
  created_at timestamptz DEFAULT now()
);

-- Ratings
CREATE TABLE IF NOT EXISTS ratings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  trip_id uuid REFERENCES trips(id) ON DELETE CASCADE,
  rater_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  ratee_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  score smallint NOT NULL CHECK (score >= 1 AND score <= 5),
  comment text,
  created_at timestamptz DEFAULT now()
);

-- Coupons
CREATE TABLE IF NOT EXISTS coupons (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code varchar(64) UNIQUE NOT NULL,
  type coupon_type NOT NULL,
  amount numeric(12,2) NOT NULL,
  expires_at timestamptz,
  usage_limit int DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS coupon_usages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  coupon_id uuid NOT NULL REFERENCES coupons(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  payment_id uuid REFERENCES payments(id) ON DELETE SET NULL,
  used_at timestamptz DEFAULT now()
);

-- Notifications
CREATE TABLE IF NOT EXISTS notifications (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type varchar(64),
  payload jsonb,
  read boolean DEFAULT false,
  created_at timestamptz DEFAULT now()
);

-- Audit logs (append-only)
CREATE TABLE IF NOT EXISTS audit_logs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  actor_id uuid,
  action varchar(128),
  entity varchar(128),
  entity_id uuid,
  before jsonb,
  after jsonb,
  created_at timestamptz DEFAULT now()
);

-- Admin users
CREATE TABLE IF NOT EXISTS admin_users (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email citext UNIQUE NOT NULL,
  password_hash text NOT NULL,
  role admin_role DEFAULT 'support',
  created_at timestamptz DEFAULT now()
);

-- Refresh tokens (server-side store)
CREATE TABLE IF NOT EXISTS refresh_tokens (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  token_hash text NOT NULL,
  revoked boolean DEFAULT false,
  expires_at timestamptz,
  created_at timestamptz DEFAULT now()
);

-- Idempotency keys
CREATE TABLE IF NOT EXISTS idempotency_keys (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  key text UNIQUE NOT NULL,
  user_id uuid REFERENCES users(id),
  created_at timestamptz DEFAULT now()
);

-- Driver current location snapshot (lightweight fallback; primary store should be Redis)
CREATE TABLE IF NOT EXISTS driver_current_locations (
  driver_id uuid PRIMARY KEY REFERENCES drivers(id) ON DELETE CASCADE,
  location geometry(Point,4326),
  updated_at timestamptz DEFAULT now()
);
