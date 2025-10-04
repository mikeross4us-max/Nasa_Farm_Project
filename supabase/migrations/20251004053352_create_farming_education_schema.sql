/*
  # Farming Education Platform Schema

  ## Overview
  This migration creates the complete database schema for an interactive farming education platform
  with gamified quizzes, leaderboards, and analytics.

  ## New Tables

  ### 1. chapters
  Main learning chapters (Land-Based, Water-Based, Innovative, Space Farming)
  - `id` (uuid, primary key)
  - `title` (text) - Chapter name
  - `icon` (text) - Emoji icon
  - `order_index` (integer) - Display order
  - `created_at` (timestamptz)

  ### 2. subchapters
  Sub-topics within each chapter (Arable Farming, Hydroponics, etc.)
  - `id` (uuid, primary key)
  - `chapter_id` (uuid, foreign key) - Parent chapter
  - `title` (text) - Subchapter name
  - `icon` (text) - Emoji icon
  - `description` (text) - Introduction text
  - `nasa_resources` (jsonb) - Array of NASA links/datasets
  - `order_index` (integer) - Display order
  - `created_at` (timestamptz)

  ### 3. questions
  Quiz questions with multiple types and media support
  - `id` (uuid, primary key)
  - `subchapter_id` (uuid, foreign key)
  - `question_type` (text) - MCQ, true/false, numeric, free_text, matching, ordering, hotspot, media, code
  - `question_text` (text) - The question content
  - `question_data` (jsonb) - Additional data (options, correct answer, images, videos, etc.)
  - `points` (integer) - Points awarded
  - `difficulty` (integer) - 1-5 scale
  - `explanation` (text) - Answer explanation
  - `media_url` (text) - Optional image/video/audio URL
  - `created_at` (timestamptz)

  ### 4. user_profiles
  Extended user information and stats
  - `id` (uuid, primary key, references auth.users)
  - `username` (text, unique)
  - `avatar_url` (text)
  - `total_points` (integer)
  - `current_streak` (integer)
  - `longest_streak` (integer)
  - `badges` (jsonb) - Array of earned badges
  - `created_at` (timestamptz)
  - `updated_at` (timestamptz)

  ### 5. quiz_attempts
  Track individual quiz attempts
  - `id` (uuid, primary key)
  - `user_id` (uuid, foreign key)
  - `subchapter_id` (uuid, foreign key)
  - `score` (integer)
  - `max_score` (integer)
  - `time_taken` (integer) - Seconds
  - `completed_at` (timestamptz)

  ### 6. user_answers
  Individual question answers
  - `id` (uuid, primary key)
  - `attempt_id` (uuid, foreign key)
  - `question_id` (uuid, foreign key)
  - `user_id` (uuid, foreign key)
  - `answer_data` (jsonb) - User's answer
  - `is_correct` (boolean)
  - `points_earned` (integer)
  - `time_taken` (integer) - Seconds
  - `created_at` (timestamptz)

  ### 7. live_sessions
  Host-led live quiz sessions
  - `id` (uuid, primary key)
  - `host_id` (uuid, foreign key)
  - `subchapter_id` (uuid, foreign key)
  - `room_code` (text, unique)
  - `status` (text) - waiting, active, completed
  - `current_question_index` (integer)
  - `started_at` (timestamptz)
  - `ended_at` (timestamptz)

  ### 8. session_participants
  Users in live sessions
  - `id` (uuid, primary key)
  - `session_id` (uuid, foreign key)
  - `user_id` (uuid, foreign key)
  - `score` (integer)
  - `joined_at` (timestamptz)

  ## Security
  - Enable RLS on all tables
  - Users can read public content (chapters, subchapters, questions)
  - Users can only modify their own data
  - Real-time leaderboard access for all authenticated users

  ## Indexes
  - Performance indexes on frequently queried columns
  - Foreign key relationships for data integrity
*/

-- Create chapters table
CREATE TABLE IF NOT EXISTS chapters (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  icon text NOT NULL,
  order_index integer NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Create subchapters table
CREATE TABLE IF NOT EXISTS subchapters (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  chapter_id uuid NOT NULL REFERENCES chapters(id) ON DELETE CASCADE,
  title text NOT NULL,
  icon text NOT NULL,
  description text NOT NULL,
  nasa_resources jsonb DEFAULT '[]'::jsonb,
  order_index integer NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Create questions table
CREATE TABLE IF NOT EXISTS questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  subchapter_id uuid NOT NULL REFERENCES subchapters(id) ON DELETE CASCADE,
  question_type text NOT NULL CHECK (question_type IN ('mcq', 'true_false', 'numeric', 'free_text', 'matching', 'ordering', 'hotspot', 'media', 'code')),
  question_text text NOT NULL,
  question_data jsonb NOT NULL DEFAULT '{}'::jsonb,
  points integer NOT NULL DEFAULT 10,
  difficulty integer NOT NULL DEFAULT 3 CHECK (difficulty BETWEEN 1 AND 5),
  explanation text NOT NULL,
  media_url text,
  created_at timestamptz DEFAULT now()
);

-- Create user_profiles table
CREATE TABLE IF NOT EXISTS user_profiles (
  id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  username text UNIQUE NOT NULL,
  avatar_url text,
  total_points integer DEFAULT 0,
  current_streak integer DEFAULT 0,
  longest_streak integer DEFAULT 0,
  badges jsonb DEFAULT '[]'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create quiz_attempts table
CREATE TABLE IF NOT EXISTS quiz_attempts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  subchapter_id uuid NOT NULL REFERENCES subchapters(id) ON DELETE CASCADE,
  score integer NOT NULL DEFAULT 0,
  max_score integer NOT NULL,
  time_taken integer NOT NULL DEFAULT 0,
  completed_at timestamptz DEFAULT now()
);

-- Create user_answers table
CREATE TABLE IF NOT EXISTS user_answers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  attempt_id uuid NOT NULL REFERENCES quiz_attempts(id) ON DELETE CASCADE,
  question_id uuid NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  answer_data jsonb NOT NULL,
  is_correct boolean NOT NULL DEFAULT false,
  points_earned integer NOT NULL DEFAULT 0,
  time_taken integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Create live_sessions table
CREATE TABLE IF NOT EXISTS live_sessions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  host_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  subchapter_id uuid NOT NULL REFERENCES subchapters(id) ON DELETE CASCADE,
  room_code text UNIQUE NOT NULL,
  status text NOT NULL DEFAULT 'waiting' CHECK (status IN ('waiting', 'active', 'completed')),
  current_question_index integer DEFAULT 0,
  started_at timestamptz,
  ended_at timestamptz,
  created_at timestamptz DEFAULT now()
);

-- Create session_participants table
CREATE TABLE IF NOT EXISTS session_participants (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id uuid NOT NULL REFERENCES live_sessions(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  score integer DEFAULT 0,
  joined_at timestamptz DEFAULT now(),
  UNIQUE(session_id, user_id)
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_subchapters_chapter ON subchapters(chapter_id);
CREATE INDEX IF NOT EXISTS idx_questions_subchapter ON questions(subchapter_id);
CREATE INDEX IF NOT EXISTS idx_quiz_attempts_user ON quiz_attempts(user_id);
CREATE INDEX IF NOT EXISTS idx_quiz_attempts_subchapter ON quiz_attempts(subchapter_id);
CREATE INDEX IF NOT EXISTS idx_user_answers_attempt ON user_answers(attempt_id);
CREATE INDEX IF NOT EXISTS idx_user_answers_user ON user_answers(user_id);
CREATE INDEX IF NOT EXISTS idx_session_participants_session ON session_participants(session_id);
CREATE INDEX IF NOT EXISTS idx_live_sessions_room_code ON live_sessions(room_code);

-- Enable Row Level Security
ALTER TABLE chapters ENABLE ROW LEVEL SECURITY;
ALTER TABLE subchapters ENABLE ROW LEVEL SECURITY;
ALTER TABLE questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_answers ENABLE ROW LEVEL SECURITY;
ALTER TABLE live_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_participants ENABLE ROW LEVEL SECURITY;

-- RLS Policies for chapters (public read)
CREATE POLICY "Anyone can view chapters"
  ON chapters FOR SELECT
  TO authenticated
  USING (true);

-- RLS Policies for subchapters (public read)
CREATE POLICY "Anyone can view subchapters"
  ON subchapters FOR SELECT
  TO authenticated
  USING (true);

-- RLS Policies for questions (public read)
CREATE POLICY "Anyone can view questions"
  ON questions FOR SELECT
  TO authenticated
  USING (true);

-- RLS Policies for user_profiles
CREATE POLICY "Users can view all profiles"
  ON user_profiles FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can insert own profile"
  ON user_profiles FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can update own profile"
  ON user_profiles FOR UPDATE
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- RLS Policies for quiz_attempts
CREATE POLICY "Users can view own attempts"
  ON quiz_attempts FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own attempts"
  ON quiz_attempts FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- RLS Policies for user_answers
CREATE POLICY "Users can view own answers"
  ON user_answers FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own answers"
  ON user_answers FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- RLS Policies for live_sessions
CREATE POLICY "Anyone can view active sessions"
  ON live_sessions FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Hosts can create sessions"
  ON live_sessions FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = host_id);

CREATE POLICY "Hosts can update own sessions"
  ON live_sessions FOR UPDATE
  TO authenticated
  USING (auth.uid() = host_id)
  WITH CHECK (auth.uid() = host_id);

-- RLS Policies for session_participants
CREATE POLICY "Anyone can view session participants"
  ON session_participants FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can join sessions"
  ON session_participants FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own participation"
  ON session_participants FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);