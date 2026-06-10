-- 004_partitions.sql
-- Cria uma partição exemplo para trip_locations (mês atual). Em produção, automatizar criação de partições.

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_class c JOIN pg_namespace n ON c.relnamespace = n.oid
    WHERE c.relname = 'trip_locations_2026_06'
  ) THEN
    EXECUTE 'CREATE TABLE trip_locations_2026_06 PARTITION OF trip_locations
             FOR VALUES FROM (''2026-06-01T00:00:00Z'') TO (''2026-07-01T00:00:00Z'')';
    EXECUTE 'CREATE INDEX ON trip_locations_2026_06 USING GIST (location)';
  END IF;
END$$;

-- Nota: criar job (cron/pg_cron) para criar partições futuras automaticamente.
