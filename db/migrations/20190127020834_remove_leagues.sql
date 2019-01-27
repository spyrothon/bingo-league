-- +migrate up
ALTER TABLE "public"."bingo_matches"
  DROP COLUMN "league_id";

ALTER TABLE "public"."bingo_teams"
  DROP COLUMN "league_id";

DROP TABLE IF EXISTS "public"."bingo_leagues";


-- +migrate down
CREATE TABLE IF NOT EXISTS "public"."bingo_leagues" (
  "id" serial,
  "name" text,
  "owner_id" integer,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  FOREIGN KEY ("owner_id") REFERENCES "public"."acc_users"("id"),
  PRIMARY KEY ("id")
);


ALTER TABLE "public"."bingo_matches"
  ADD COLUMN "league_id" integer,
  ADD FOREIGN KEY("league_id") REFERENCES "public"."bingo_leagues"("id");

ALTER TABLE "public"."bingo_teams"
  ADD COLUMN "league_id" integer,
  ADD FOREIGN KEY("league_id") REFERENCES "public"."bingo_leagues"("id");
