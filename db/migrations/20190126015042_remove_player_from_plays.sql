-- +migrate up
ALTER TABLE "public"."bingo_plays"
  DROP COLUMN "player_id";

-- +migrate down
ALTER TABLE "public"."bingo_plays"
  ADD COLUMN "player_id" integer,
  ADD FOREIGN KEY("player_id") REFERENCES "public"."bingo_players"("id");
