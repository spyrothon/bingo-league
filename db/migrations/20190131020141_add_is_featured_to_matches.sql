-- +migrate up
ALTER TABLE "public"."bingo_matches"
  ADD COLUMN "is_featured" boolean DEFAULT false;

-- +migrate down
ALTER TABLE "public"."bingo_matches"
  DROP COLUMN "is_featured";
