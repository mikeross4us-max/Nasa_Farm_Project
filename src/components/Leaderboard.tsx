import { useState, useEffect } from 'react';
import { Trophy, Medal, Award } from 'lucide-react';
import { supabase } from '../lib/supabase';
import { useAuth } from '../contexts/AuthContext';

export function Leaderboard() {
  const { user } = useAuth();
  const [leaders, setLeaders] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadLeaderboard();
    const subscription = supabase
      .channel('leaderboard-changes')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'user_profiles' }, loadLeaderboard)
      .subscribe();

    return () => {
      subscription.unsubscribe();
    };
  }, []);

  const loadLeaderboard = async () => {
    const { data, error } = await supabase
      .from('user_profiles')
      .select('*')
      .order('total_points', { ascending: false })
      .limit(10);

    if (error) {
      console.error('Error loading leaderboard:', error);
      return;
    }

    if (data) {
      setLeaders(data);
    }
    setLoading(false);
  };

  const getRankIcon = (index: number) => {
    switch (index) {
      case 0:
        return <Trophy className="text-yellow-500" size={32} />;
      case 1:
        return <Medal className="text-gray-400" size={28} />;
      case 2:
        return <Award className="text-orange-600" size={28} />;
      default:
        return <span className="text-2xl font-bold text-gray-400">#{index + 1}</span>;
    }
  };

  const getRankClass = (index: number) => {
    switch (index) {
      case 0:
        return 'bg-gradient-to-r from-yellow-50 to-amber-50 border-yellow-300';
      case 1:
        return 'bg-gradient-to-r from-gray-50 to-slate-50 border-gray-300';
      case 2:
        return 'bg-gradient-to-r from-orange-50 to-red-50 border-orange-300';
      default:
        return 'bg-white border-gray-200';
    }
  };

  if (loading) {
    return (
      <div className="text-center py-8">
        <div className="animate-spin text-4xl">🏆</div>
        <p className="text-gray-600 mt-2">Loading leaderboard...</p>
      </div>
    );
  }

  return (
    <div className="max-w-4xl mx-auto">
      <div className="bg-white rounded-2xl shadow-2xl p-8">
        <div className="text-center mb-8">
          <h2 className="text-4xl font-bold text-gray-800 mb-2">🏆 Leaderboard</h2>
          <p className="text-gray-600">Top farmers on the platform</p>
        </div>

        <div className="space-y-3">
          {leaders.map((leader, index) => (
            <div
              key={leader.id}
              className={`flex items-center gap-4 p-4 rounded-xl border-2 transition-all ${getRankClass(
                index
              )} ${leader.id === user?.id ? 'ring-4 ring-green-300' : ''}`}
            >
              <div className="flex-shrink-0 w-12 flex items-center justify-center">
                {getRankIcon(index)}
              </div>

              <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2">
                  <p className="font-bold text-gray-800 truncate">{leader.username}</p>
                  {leader.id === user?.id && (
                    <span className="bg-green-500 text-white text-xs px-2 py-1 rounded-full">You</span>
                  )}
                </div>
                <div className="flex items-center gap-3 text-sm text-gray-600">
                  <span>🔥 {leader.current_streak} day streak</span>
                  <span>⭐ {leader.longest_streak} best</span>
                </div>
              </div>

              <div className="text-right">
                <div className="text-2xl font-bold text-green-600">{leader.total_points}</div>
                <div className="text-xs text-gray-500">points</div>
              </div>
            </div>
          ))}
        </div>

        {leaders.length === 0 && (
          <div className="text-center py-12 text-gray-500">
            <p className="text-xl">No players yet. Be the first to compete!</p>
          </div>
        )}
      </div>
    </div>
  );
}
