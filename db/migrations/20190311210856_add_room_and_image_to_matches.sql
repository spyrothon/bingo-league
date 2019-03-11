-- +migrate up
ALTER TABLE "public"."bingo_matches"
  ADD COLUMN "room_link" text,
  ADD COLUMN "board_image_link" text;

-- +migrate down
ALTER TABLE "public"."bingo_matches"
  DROP COLUMN "room_link",
  DROP COLUMN "board_image_link";
