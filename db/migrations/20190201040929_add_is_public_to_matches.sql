-- +migrate up
ALTER TABLE "public"."bingo_matches"
  ADD COLUMN "is_public" boolean DEFAULT true;

-- +migrate down
ALTER TABLE "public"."bingo_matches"
  DROP COLUMN "is_public";
