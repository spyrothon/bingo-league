-- +migrate up
ALTER TABLE "public"."bingo_matches"
  ADD COLUMN "description" text,
  ADD COLUMN "notes" text,
  ADD COLUMN "video_link" text;

-- +migrate down
ALTER TABLE "public"."bingo_matches"
  DROP COLUMN "description",
  DROP COLUMN "notes",
  DROP COLUMN "video_link";
