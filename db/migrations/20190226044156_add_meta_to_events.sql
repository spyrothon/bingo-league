-- +migrate up
ALTER TABLE "public"."room_events"
  ADD COLUMN "meta" text;

-- +migrate down
ALTER TABLE "public"."room_events"
  DROP COLUMN "meta";
