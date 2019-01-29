-- +migrate up
ALTER TABLE "public"."bingo_plays"
  ADD COLUMN "round" integer;

-- +migrate down
ALTER TABLE "public"."bingo_plays"
  DROP COLUMN "round";
