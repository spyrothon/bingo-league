-- +migrate up
CREATE TABLE IF NOT EXISTS "public"."room_events" (
  "id" serial,
  "room_id" integer,
  "type" text,
  "data" text,
  "timestamp" timestamp without time zone,
  PRIMARY KEY ("id")
);

-- +migrate down
DROP TABLE IF EXISTS "public"."room_events";
