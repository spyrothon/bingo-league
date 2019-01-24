-- +migrate up
CREATE TABLE IF NOT EXISTS "public"."acc_users" (
  "id" serial,
  "name" text,
  "encrypted_password" text,
  "discord" text,
  "twitch" text,
  "twitter" text,
  "timezone" text,
  "admin" boolean DEFAULT 'false',
  "avatar_object_id" text,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "public"."acc_sessions" (
  "id" serial,
  "key" text,
  "user_id" integer,
  "valid" boolean DEFAULT false,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  FOREIGN KEY ("user_id") REFERENCES "public"."acc_users"("id"),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "public"."bingo_leagues" (
  "id" serial,
  "name" text,
  "owner_id" integer,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  FOREIGN KEY ("owner_id") REFERENCES "public"."acc_users"("id"),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "public"."bingo_matches" (
  "id" serial,
  "name" text,
  "start_date" timestamp without time zone,
  "league_id" integer,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  FOREIGN KEY ("league_id") REFERENCES "public"."bingo_leagues"("id"),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "public"."bingo_players" (
  "id" serial,
  "alias_name" text,
  "account_id" integer,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  FOREIGN KEY ("account_id") REFERENCES "public"."acc_users"("id"),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "public"."bingo_teams" (
  "id" serial,
  "name" text,
  "color" text,
  "league_id" integer,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  FOREIGN KEY ("league_id") REFERENCES "public"."bingo_leagues"("id"),
  PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "public"."bingo_plays" (
  "id" serial,
  "score" integer,
  "player_id" integer,
  "team_id" integer,
  "match_id" integer,
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  FOREIGN KEY ("player_id") REFERENCES "public"."bingo_players"("id"),
  FOREIGN KEY ("team_id") REFERENCES "public"."bingo_teams"("id"),
  FOREIGN KEY ("match_id") REFERENCES "public"."bingo_matches"("id"),
  PRIMARY KEY ("id")
);



-- +migrate down
DROP TABLE IF EXISTS "public"."bingo_plays";
DROP TABLE IF EXISTS "public"."bingo_teams";
DROP TABLE IF EXISTS "public"."bingo_players";
DROP TABLE IF EXISTS "public"."bingo_matches";
DROP TABLE IF EXISTS "public"."bingo_leagues";
DROP TABLE IF EXISTS "public"."acc_sessions";
DROP TABLE IF EXISTS "public"."acc_users";
