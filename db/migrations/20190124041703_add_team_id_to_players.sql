-- +migrate up
ALTER TABLE "public"."bingo_players"
  ADD COLUMN "team_id" integer,
  ADD FOREIGN KEY("team_id") REFERENCES "public"."bingo_teams"("id");

-- +migrate down
ALTER TABLE "public"."bingo_players"
  DROP COLUMN "team_id";
