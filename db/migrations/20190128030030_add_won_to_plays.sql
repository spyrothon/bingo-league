-- +migrate up
ALTER TABLE "public"."bingo_plays"
  ADD COLUMN "won" boolean DEFAULT false;

-- +migrate down
ALTER TABLE "public"."bingo_plays"
  DROP COLUMN "won";
