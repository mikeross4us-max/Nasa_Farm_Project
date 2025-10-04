import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Missing Supabase environment variables');
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

export type Database = {
  public: {
    Tables: {
      chapters: {
        Row: {
          id: string;
          title: string;
          icon: string;
          order_index: number;
          created_at: string;
        };
      };
      subchapters: {
        Row: {
          id: string;
          chapter_id: string;
          title: string;
          icon: string;
          description: string;
          nasa_resources: Array<{
            title: string;
            url: string;
            description: string;
          }>;
          order_index: number;
          created_at: string;
        };
      };
      questions: {
        Row: {
          id: string;
          subchapter_id: string;
          question_type: string;
          question_text: string;
          question_data: any;
          points: number;
          difficulty: number;
          explanation: string;
          media_url: string | null;
          created_at: string;
        };
      };
      user_profiles: {
        Row: {
          id: string;
          username: string;
          avatar_url: string | null;
          total_points: number;
          current_streak: number;
          longest_streak: number;
          badges: string[];
          created_at: string;
          updated_at: string;
        };
      };
      quiz_attempts: {
        Row: {
          id: string;
          user_id: string;
          subchapter_id: string;
          score: number;
          max_score: number;
          time_taken: number;
          completed_at: string;
        };
      };
    };
  };
};
