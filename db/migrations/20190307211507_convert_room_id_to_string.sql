-- +migrate up
ALTER TABLE "public"."room_events"
  ALTER COLUMN "room_id" TYPE text;

-- +migrate down
ALTER TABLE "public"."room_events"
  ALTER COLUMN "room_id" TYPE integer;
