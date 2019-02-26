-- +migrate up
CREATE TABLE IF NOT EXISTS "public"."room_goals" (
  id serial,
  name text,
  types text,
  difficulty integer,
  clarification text,
  created_at timestamp without time zone,
  updated_at timestamp without time zone
);

-- +migrate down
DROP TABLE IF EXISTS "public"."room_goals";
