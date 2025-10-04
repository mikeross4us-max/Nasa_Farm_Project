import { Trophy, User, LogOut } from 'lucide-react';
import { useAuth } from '../contexts/AuthContext';
import { useState, useEffect } from 'react';
import { supabase } from '../lib/supabase';

export function Header() {
  const { user, signOut } = useAuth();
  const [profile, setProfile] = useState<any>(null);

  useEffect(() => {
    if (user) {
      loadProfile();
    }
  }, [user]);

  const loadProfile = async () => {
    const { data } = await supabase
      .from('user_profiles')
      .select('*')
      .eq('id', user?.id)
      .maybeSingle();

    if (data) setProfile(data);
  };

  return (
    <header className="bg-gradient-to-r from-green-600 to-emerald-700 text-white shadow-lg">
      <div className="container mx-auto px-4 py-4">
        <div className="flex items-center justify-between">
          <div className="flex items-center space-x-3">
            <div className="bg-white/20 p-2 rounded-lg backdrop-blur-sm">
              <span className="text-3xl">🌱</span>
            </div>
            <div>
              <h1 className="text-2xl font-bold">FarmEd</h1>
              <p className="text-sm text-green-100">NASA-Powered Farming Education</p>
            </div>
          </div>

          {user && profile && (
            <div className="flex items-center space-x-6">
              <div className="flex items-center space-x-2 bg-white/20 px-4 py-2 rounded-lg backdrop-blur-sm">
                <Trophy className="text-yellow-300" size={20} />
                <span className="font-bold">{profile.total_points}</span>
              </div>

              <div className="flex items-center space-x-3">
                <div className="bg-white/20 p-2 rounded-full backdrop-blur-sm">
                  <User size={20} />
                </div>
                <div className="text-sm">
                  <p className="font-semibold">{profile.username}</p>
                  <p className="text-green-100 text-xs">🔥 {profile.current_streak} day streak</p>
                </div>
              </div>

              <button
                onClick={() => signOut()}
                className="bg-white/20 hover:bg-white/30 p-2 rounded-lg backdrop-blur-sm transition-all"
                title="Sign Out"
              >
                <LogOut size={20} />
              </button>
            </div>
          )}
        </div>
      </div>
    </header>
  );
}
