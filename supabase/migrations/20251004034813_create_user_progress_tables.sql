/*
  # Create Agricultural Game User Progress Tables

  ## Overview
  This migration creates tables to track user progress in the agricultural farming game,
  including authentication, game statistics, chapter completion, and leaderboard data.

  ## New Tables
  
  1. `user_profiles`
    - `id` (uuid, primary key) - Links to auth.users
    - `username` (text, unique) - Display name
    - `email` (text) - User email
    - `avatar` (text) - Emoji or avatar identifier
    - `total_score` (integer) - Cumulative game score
    - `games_played` (integer) - Total number of games played
    - `hours_played` (integer) - Total hours spent playing
    - `created_at` (timestamptz) - Account creation time
    - `updated_at` (timestamptz) - Last profile update

  2. `chapter_progress`
    - `id` (uuid, primary key)
    - `user_id` (uuid, foreign key) - References user_profiles
    - `chapter_type` (text) - Type: land, water, innovative, or space
    - `subchapter_id` (text) - Specific farming technique
    - `completed` (boolean) - Whether chapter is completed
    - `score` (integer) - Points earned in this chapter
    - `completed_at` (timestamptz) - When chapter was completed
    - `created_at` (timestamptz) - When chapter was started

  3. `leaderboard`
    - `id` (uuid, primary key)
    - `user_id` (uuid, foreign key) - References user_profiles
    - `rank` (integer) - Current leaderboard position
    - `points` (integer) - Total points for ranking
    - `updated_at` (timestamptz) - Last rank update

  ## Security
  - Enable Row Level Security (RLS) on all tables
  - Users can read their own profile data
  - Users can update their own profile
  - Users can read their own chapter progress
  - Users can insert and update their own progress
  - Leaderboard is publicly readable
  - Only authenticated users can view leaderboard

  ## Indexes
  - Index on username for fast lookups
  - Index on user_id in chapter_progress for user queries
  - Index on rank in leaderboard for sorting
  - Index on chapter_type and subchapter_id for filtering
*/

-- Create user_profiles table
CREATE TABLE IF NOT EXISTS user_profiles (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  username text UNIQUE NOT NULL,
  email text NOT NULL,
  avatar text DEFAULT '👨‍🌾',
  total_score integer DEFAULT 0,
  games_played integer DEFAULT 0,
  hours_played integer DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create chapter_progress table
CREATE TABLE IF NOT EXISTS chapter_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  chapter_type text NOT NULL CHECK (chapter_type IN ('land', 'water', 'innovative', 'space')),
  subchapter_id text NOT NULL,
  completed boolean DEFAULT false,
  score integer DEFAULT 0,
  completed_at timestamptz,
  created_at timestamptz DEFAULT now()
);

-- Create leaderboard table
CREATE TABLE IF NOT EXISTS leaderboard (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  rank integer NOT NULL,
  points integer NOT NULL DEFAULT 0,
  updated_at timestamptz DEFAULT now(),
  UNIQUE(user_id)
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_user_profiles_username ON user_profiles(username);
CREATE INDEX IF NOT EXISTS idx_chapter_progress_user_id ON chapter_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_chapter_progress_chapter ON chapter_progress(chapter_type, subchapter_id);
CREATE INDEX IF NOT EXISTS idx_leaderboard_rank ON leaderboard(rank);
CREATE INDEX IF NOT EXISTS idx_leaderboard_points ON leaderboard(points DESC);

-- Enable Row Level Security
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE chapter_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE leaderboard ENABLE ROW LEVEL SECURITY;

-- RLS Policies for user_profiles
CREATE POLICY "Users can view own profile"
  ON user_profiles FOR SELECT
  TO authenticated
  USING (id = auth.uid());

CREATE POLICY "Users can insert own profile"
  ON user_profiles FOR INSERT
  TO authenticated
  WITH CHECK (id = auth.uid());

CREATE POLICY "Users can update own profile"
  ON user_profiles FOR UPDATE
  TO authenticated
  USING (id = auth.uid())
  WITH CHECK (id = auth.uid());

-- RLS Policies for chapter_progress
CREATE POLICY "Users can view own progress"
  ON chapter_progress FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

CREATE POLICY "Users can insert own progress"
  ON chapter_progress FOR INSERT
  TO authenticated
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update own progress"
  ON chapter_progress FOR UPDATE
  TO authenticated
  USING (user_id = auth.uid())
  WITH CHECK (user_id = auth.uid());

-- RLS Policies for leaderboard
CREATE POLICY "Leaderboard is publicly readable"
  ON leaderboard FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can insert own leaderboard entry"
  ON leaderboard FOR INSERT
  TO authenticated
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update own leaderboard entry"
  ON leaderboard FOR UPDATE
  TO authenticated
  USING (user_id = auth.uid())
  WITH CHECK (user_id = auth.uid());

-- Function to automatically update leaderboard when user score changes
CREATE OR REPLACE FUNCTION update_leaderboard()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO leaderboard (user_id, points, rank)
  VALUES (NEW.id, NEW.total_score, 0)
  ON CONFLICT (user_id)
  DO UPDATE SET
    points = NEW.total_score,
    updated_at = now();
  
  -- Update ranks based on points
  WITH ranked_users AS (
    SELECT user_id, ROW_NUMBER() OVER (ORDER BY points DESC) as new_rank
    FROM leaderboard
  )
  UPDATE leaderboard l
  SET rank = r.new_rank
  FROM ranked_users r
  WHERE l.user_id = r.user_id;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to update leaderboard when user profile changes
DROP TRIGGER IF EXISTS update_leaderboard_trigger ON user_profiles;
CREATE TRIGGER update_leaderboard_trigger
  AFTER INSERT OR UPDATE OF total_score ON user_profiles
  FOR EACH ROW
  EXECUTE FUNCTION update_leaderboard();

-- Insert sample data for testing
INSERT INTO user_profiles (username, email, avatar, total_score, games_played, hours_played)
VALUES
  ('Ranveer', 'ranveer@farm.com', '🌾', 9000, 120, 200),
  ('Barkie', 'barkie@farm.com', '🚜', 8750, 115, 190),
  ('John', 'john@farm.com', '🌱', 8000, 100, 175),
  ('Wang', 'wang@farm.com', '🌻', 7500, 95, 160),
  ('Chen', 'chen@farm.com', '🥕', 6000, 80, 140),
  ('Maria', 'maria@farm.com', '🌽', 4000, 60, 100),
  ('Ahmed', 'ahmed@farm.com', '🍅', 3500, 50, 90)
ON CONFLICT (username) DO NOTHING;
