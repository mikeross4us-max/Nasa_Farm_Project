import { useState, useEffect } from 'react';
import { Check, ChevronLeft, Trophy, Clock, Gamepad2, TrendingUp } from 'lucide-react';

type Screen = 'login' | 'register' | 'home' | 'leaderboard' | 'chapters' | 'subchapters' | 'dashboard';
type ChapterType = 'land' | 'water' | 'innovative' | 'space';

interface SubChapter {
  id: string;
  name: string;
  icon: string;
  description: string;
}

interface UserStats {
  gamesPlayed: number;
  hoursPlayed: number;
  chaptersCompleted: number;
  totalScore: number;
}

function App() {
  const [currentScreen, setCurrentScreen] = useState<Screen>('login');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [repeatPassword, setRepeatPassword] = useState('');
  const [username, setUsername] = useState('user987');
  const [selectedChapter, setSelectedChapter] = useState<ChapterType | null>(null);

  const [userStats] = useState<UserStats>({
    gamesPlayed: 47,
    hoursPlayed: 156,
    chaptersCompleted: 12,
    totalScore: 8500,
  });

  const playClickSound = () => {
    const click = new Audio('https://assets.mixkit.co/active_storage/sfx/2568/2568-preview.mp3');
    click.volume = 0.4;
    click.play().catch(() => {});
  };

  useEffect(() => {
    const audio = new Audio('https://assets.mixkit.co/active_storage/sfx/2571/2571-preview.mp3');
    audio.loop = true;
    audio.volume = 0.3;
    audio.play().catch(() => {});

    return () => {
      audio.pause();
    };
  }, []);

  const leaderboardData = [
    { rank: 1, username: 'Ranveer', points: 9000, avatar: '🌾' },
    { rank: 2, username: 'Barkie', points: 8750, avatar: '🚜' },
    { rank: 3, username: 'John', points: 8000, avatar: '🌱' },
    { rank: 4, username: 'Wang', points: 7500, place: '4th Place', avatar: '🌻' },
    { rank: 5, username: 'Chen', points: 6000, place: '5th Place', avatar: '🥕' },
    { rank: 6, username: 'Maria', points: 4000, place: '6th Place', avatar: '🌽' },
    { rank: 7, username: 'Ahmed', points: 3500, place: '7th Place', avatar: '🍅' },
  ];

  const chapters = [
    {
      id: 'land',
      title: 'Land-Based Farming',
      subtitle: 'Traditional & Conventional',
      icon: '🌍',
      description: 'Master the art of cultivating crops and raising livestock on land',
    },
    {
      id: 'water',
      title: 'Water-Based Farming',
      subtitle: 'Aquatic Agriculture',
      icon: '🌊',
      description: 'Dive into fish farming, mariculture, and aquatic plant cultivation',
    },
    {
      id: 'innovative',
      title: 'Innovative Farming',
      subtitle: 'Modern Technologies',
      icon: '🌿',
      description: 'Explore hydroponics, vertical farming, and cutting-edge methods',
    },
    {
      id: 'space',
      title: 'Space Farming',
      subtitle: 'Future of Agriculture',
      icon: '🛰️',
      description: 'Pioneer farming in space stations and urban environments',
    },
  ];

  const subChapters: Record<ChapterType, SubChapter[]> = {
    land: [
      { id: 'arable', name: 'Arable Farming', icon: '🌾', description: 'Growing crops on cultivated land' },
      { id: 'pastoral', name: 'Pastoral Farming', icon: '🐄', description: 'Raising animals like cows, goats, sheep' },
      { id: 'mixed', name: 'Mixed Farming', icon: '🚜', description: 'Combining crops and animal husbandry' },
      { id: 'shifting', name: 'Shifting Cultivation', icon: '🔥', description: 'Temporary land use and rotation' },
      { id: 'terrace', name: 'Terrace Farming', icon: '⛰️', description: 'Step-like cultivation on hillsides' },
    ],
    water: [
      { id: 'aquaculture', name: 'Aquaculture', icon: '🐟', description: 'Farming fish and prawns in controlled systems' },
      { id: 'mariculture', name: 'Mariculture', icon: '🦪', description: 'Ocean-based farming of oysters and seaweed' },
      { id: 'freshwater', name: 'Freshwater Aquaculture', icon: '🏞️', description: 'Fish farming in ponds and rivers' },
      { id: 'algae', name: 'Algae Farming', icon: '🌊', description: 'Cultivating seaweed and microalgae' },
    ],
    innovative: [
      { id: 'hydroponics', name: 'Hydroponics', icon: '💧', description: 'Soil-free farming with nutrient-rich water' },
      { id: 'aeroponics', name: 'Aeroponics', icon: '💨', description: 'Growing plants in air with nutrient mist' },
      { id: 'vertical', name: 'Vertical Farming', icon: '🏢', description: 'Stacked indoor farms with artificial lights' },
      { id: 'greenhouse', name: 'Greenhouse Farming', icon: '🏠', description: 'Controlled environment agriculture' },
    ],
    space: [
      { id: 'space', name: 'Space Station Farming', icon: '🚀', description: 'Growing crops in zero gravity' },
      { id: 'urban', name: 'Urban Farming', icon: '🏙️', description: 'Rooftop and city-based agriculture' },
      { id: 'aerial', name: 'Aerial Farming', icon: '🌤️', description: 'Sky-based agricultural systems' },
    ],
  };

  const handleNavigate = (screen: Screen) => {
    playClickSound();
    setCurrentScreen(screen);
  };

  const handleChapterSelect = (chapterId: ChapterType) => {
    playClickSound();
    setSelectedChapter(chapterId);
    setCurrentScreen('subchapters');
  };

  return (
    <div className="min-h-screen relative overflow-hidden bg-gradient-to-br from-green-950 via-green-900 to-emerald-950">
      <div
        className="absolute inset-0 opacity-40"
        style={{
          backgroundImage: 'url(https://images.pexels.com/photos/1105666/pexels-photo-1105666.jpeg)',
          backgroundSize: 'cover',
          backgroundPosition: 'center',
        }}
      />

      <div className="relative z-10">
        {currentScreen === 'login' && (
          <div className="min-h-screen flex items-center justify-center px-4">
            <div className="w-full max-w-2xl">
              <h1 className="text-5xl font-bold text-center mb-12 text-yellow-400 tracking-widest" style={{ fontFamily: 'monospace' }}>
                SIGN IN
              </h1>

              <div className="backdrop-blur-sm bg-black/40 rounded-lg border-2 border-yellow-600/60 p-8">
                <div className="flex mb-8">
                  <button
                    className="flex-1 py-4 bg-yellow-600/90 text-white font-bold text-xl tracking-wide"
                    onClick={() => handleNavigate('login')}
                  >
                    LOGIN
                  </button>
                  <button
                    className="flex-1 py-4 bg-yellow-900/60 text-white/70 font-bold text-xl tracking-wide hover:bg-yellow-800/60 transition-colors"
                    onClick={() => handleNavigate('register')}
                  >
                    REGISTER
                  </button>
                </div>

                <div className="space-y-6">
                  <div>
                    <label className="block text-white font-bold mb-2 tracking-wide">
                      YOUR EMAIL <span className="text-red-500">*</span>
                    </label>
                    <div className="relative">
                      <input
                        type="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        onClick={playClickSound}
                        placeholder="ranveer4us@gmail.com"
                        className="w-full px-4 py-4 bg-yellow-700/80 text-white placeholder-yellow-200/50 rounded-lg border-2 border-yellow-600/40 focus:outline-none focus:border-yellow-500"
                      />
                      {email && (
                        <div className="absolute right-4 top-1/2 -translate-y-1/2 bg-yellow-500 rounded-full p-1">
                          <Check className="w-5 h-5 text-black" />
                        </div>
                      )}
                    </div>
                  </div>

                  <div>
                    <label className="block text-white font-bold mb-2 tracking-wide">
                      YOUR PASSWORD <span className="text-red-500">*</span>
                    </label>
                    <div className="relative">
                      <input
                        type="password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        onClick={playClickSound}
                        placeholder="••••••••••••"
                        className="w-full px-4 py-4 bg-yellow-700/80 text-white placeholder-yellow-200/50 rounded-lg border-2 border-yellow-600/40 focus:outline-none focus:border-yellow-500"
                      />
                      {password && (
                        <div className="absolute right-4 top-1/2 -translate-y-1/2 bg-yellow-500 rounded-full p-1">
                          <Check className="w-5 h-5 text-black" />
                        </div>
                      )}
                    </div>
                  </div>

                  <button
                    onClick={() => handleNavigate('home')}
                    className="w-full py-4 bg-yellow-600/90 hover:bg-yellow-500 text-black font-bold text-xl tracking-wider rounded-lg transition-colors mt-8"
                  >
                    LOGIN TO YOUR ACCOUNT
                  </button>
                </div>
              </div>
            </div>
          </div>
        )}

        {currentScreen === 'register' && (
          <div className="min-h-screen flex items-center justify-center px-4">
            <div className="w-full max-w-2xl">
              <h1 className="text-5xl font-bold text-center mb-12 text-yellow-400 tracking-widest" style={{ fontFamily: 'monospace' }}>
                CREATE AN ACCOUNT
              </h1>

              <div className="backdrop-blur-sm bg-black/40 rounded-lg border-2 border-yellow-600/60 p-8">
                <div className="flex mb-8">
                  <button
                    className="flex-1 py-4 bg-yellow-900/60 text-white/70 font-bold text-xl tracking-wide hover:bg-yellow-800/60 transition-colors"
                    onClick={() => handleNavigate('login')}
                  >
                    LOGIN
                  </button>
                  <button
                    className="flex-1 py-4 bg-yellow-600/90 text-white font-bold text-xl tracking-wide"
                    onClick={() => handleNavigate('register')}
                  >
                    REGISTER
                  </button>
                </div>

                <div className="space-y-6">
                  <div>
                    <label className="block text-white font-bold mb-2 tracking-wide">
                      YOUR EMAIL <span className="text-red-500">*</span>
                    </label>
                    <div className="relative">
                      <input
                        type="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        onClick={playClickSound}
                        placeholder="ranveer4us@gmail.com"
                        className="w-full px-4 py-4 bg-yellow-700/80 text-white placeholder-yellow-200/50 rounded-lg border-2 border-yellow-600/40 focus:outline-none focus:border-yellow-500"
                      />
                      {email && (
                        <div className="absolute right-4 top-1/2 -translate-y-1/2 bg-yellow-500 rounded-full p-1">
                          <Check className="w-5 h-5 text-black" />
                        </div>
                      )}
                    </div>
                  </div>

                  <div>
                    <label className="block text-white font-bold mb-2 tracking-wide">
                      YOUR PASSWORD <span className="text-red-500">*</span>
                    </label>
                    <div className="relative">
                      <input
                        type="password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        onClick={playClickSound}
                        placeholder="••••••••••••"
                        className="w-full px-4 py-4 bg-yellow-700/80 text-white placeholder-yellow-200/50 rounded-lg border-2 border-yellow-600/40 focus:outline-none focus:border-yellow-500"
                      />
                      {password && (
                        <div className="absolute right-4 top-1/2 -translate-y-1/2 bg-yellow-500 rounded-full p-1">
                          <Check className="w-5 h-5 text-black" />
                        </div>
                      )}
                    </div>
                  </div>

                  <div>
                    <label className="block text-white font-bold mb-2 tracking-wide">
                      REPEAT PASSWORD
                    </label>
                    <input
                      type="password"
                      value={repeatPassword}
                      onChange={(e) => setRepeatPassword(e.target.value)}
                      onClick={playClickSound}
                      className="w-full px-4 py-4 bg-yellow-700/80 text-white placeholder-yellow-200/50 rounded-lg border-2 border-yellow-600/40 focus:outline-none focus:border-yellow-500"
                    />
                  </div>

                  <button
                    onClick={() => handleNavigate('home')}
                    className="w-full py-4 bg-yellow-600/90 hover:bg-yellow-500 text-black font-bold text-xl tracking-wider rounded-lg transition-colors mt-8"
                  >
                    CREATE ACCOUNT
                  </button>

                  <p className="text-center text-white/60 text-sm mt-4">
                    You will receive a confirmation email in your inbox with a link so you can activate your account.
                  </p>
                </div>
              </div>
            </div>
          </div>
        )}

        {currentScreen === 'home' && (
          <div className="min-h-screen flex flex-col">
            <div className="flex justify-between items-center p-6">
              <div className="text-white text-xl tracking-wide">
                WELCOME {username.toUpperCase()}
              </div>
              <button
                onClick={() => handleNavigate('dashboard')}
                className="text-white text-xl tracking-wide hover:text-yellow-400 transition-colors flex items-center gap-2"
              >
                <Gamepad2 className="w-6 h-6" />
                DASHBOARD
              </button>
            </div>

            <div className="flex-1 flex flex-col items-center justify-center px-4">
              <h1 className="text-5xl md:text-6xl font-bold text-center mb-4 text-white tracking-wider" style={{ fontFamily: 'monospace' }}>
                AGRICULTURAL MASTERS:
              </h1>
              <h2 className="text-4xl md:text-5xl font-bold text-center mb-8 text-white tracking-wider" style={{ fontFamily: 'monospace' }}>
                GROW YOUR FARMING EMPIRE
              </h2>

              <p className="text-white/80 text-center max-w-3xl mb-16 text-lg leading-relaxed">
                Cultivate crops, manage resources, and compete with farmers worldwide.<br />
                Will you become the ultimate agricultural champion?
              </p>

              <div className="space-y-4">
                <button
                  onClick={() => handleNavigate('leaderboard')}
                  className="px-16 py-4 bg-yellow-500 hover:bg-yellow-400 text-black font-bold text-xl tracking-widest transition-all transform hover:scale-105"
                  style={{ clipPath: 'polygon(10% 0%, 100% 0%, 90% 100%, 0% 100%)' }}
                >
                  LEADERBOARD
                </button>
                <button
                  onClick={playClickSound}
                  className="px-16 py-4 bg-yellow-600/80 hover:bg-yellow-500/80 text-black font-bold text-xl tracking-widest transition-all transform hover:scale-105"
                  style={{ clipPath: 'polygon(10% 0%, 100% 0%, 90% 100%, 0% 100%)' }}
                >
                  SETTINGS
                </button>
              </div>
            </div>
          </div>
        )}

        {currentScreen === 'leaderboard' && (
          <div className="min-h-screen flex flex-col p-6">
            <button
              onClick={() => handleNavigate('home')}
              className="text-white/60 hover:text-white text-4xl mb-8 w-12 h-12 flex items-center justify-center rounded-lg border-2 border-yellow-600/40 hover:border-yellow-500 transition-all"
            >
              ‹
            </button>

            <h1 className="text-5xl font-bold text-center mb-4 text-yellow-400 tracking-widest" style={{ fontFamily: 'monospace' }}>
              LEADERBOARD
            </h1>
            <p className="text-center text-green-400 text-xl mb-12 tracking-wide">Top Agricultural Leaders</p>

            <div className="max-w-6xl mx-auto grid md:grid-cols-2 gap-8 flex-1">
              <div className="space-y-8">
                <div className="relative backdrop-blur-sm bg-gradient-to-br from-yellow-600/30 to-yellow-800/30 rounded-xl border-2 border-yellow-500/50 p-8 shadow-2xl">
                  <div className="absolute -top-4 -right-4 text-7xl animate-pulse">🏆</div>
                  <div className="text-center">
                    <div className="text-7xl mb-4">{leaderboardData[0].avatar}</div>
                    <div className="text-5xl font-bold text-yellow-400 tracking-wide mb-2">1ST PLACE</div>
                    <div className="text-3xl text-white font-bold mt-3">{leaderboardData[0].username}</div>
                    <div className="text-4xl text-green-400 font-bold mt-4 flex items-center justify-center gap-2">
                      <span className="text-3xl">🌟</span>
                      {leaderboardData[0].points} pts
                    </div>
                  </div>
                </div>

                <div className="flex gap-4">
                  <div className="flex-1 backdrop-blur-sm bg-gradient-to-br from-gray-300/20 to-gray-500/20 rounded-xl border-2 border-gray-400/50 p-6 shadow-xl transform hover:scale-105 transition-all">
                    <div className="text-center">
                      <div className="text-5xl mb-3">{leaderboardData[1].avatar}</div>
                      <div className="text-2xl font-bold text-gray-300">2ND</div>
                      <div className="text-xl text-white/90 mt-2">{leaderboardData[1].username}</div>
                      <div className="text-2xl text-green-400 font-bold mt-2">{leaderboardData[1].points} pts</div>
                    </div>
                  </div>

                  <div className="flex-1 backdrop-blur-sm bg-gradient-to-br from-amber-700/20 to-amber-900/20 rounded-xl border-2 border-amber-600/50 p-6 shadow-xl transform hover:scale-105 transition-all">
                    <div className="text-center">
                      <div className="text-5xl mb-3">{leaderboardData[2].avatar}</div>
                      <div className="text-2xl font-bold text-amber-400">3RD</div>
                      <div className="text-xl text-white/90 mt-2">{leaderboardData[2].username}</div>
                      <div className="text-2xl text-green-400 font-bold mt-2">{leaderboardData[2].points} pts</div>
                    </div>
                  </div>
                </div>
              </div>

              <div className="space-y-3">
                {leaderboardData.slice(3).map((player, index) => (
                  <div
                    key={player.rank}
                    className={`flex items-center justify-between p-5 backdrop-blur-sm ${
                      index % 2 === 0
                        ? 'bg-gradient-to-r from-yellow-800/40 to-yellow-700/30 border-yellow-600/40'
                        : 'bg-gradient-to-r from-yellow-900/50 to-yellow-800/40 border-yellow-700/40'
                    } rounded-xl border-2 shadow-lg hover:shadow-xl hover:scale-[1.02] transition-all`}
                  >
                    <div className="flex items-center gap-5">
                      <div className="text-yellow-400 font-bold text-2xl w-14 h-14 flex items-center justify-center bg-black/30 rounded-lg border border-yellow-600/50">
                        #{player.rank}
                      </div>
                      <div className="text-4xl">{player.avatar}</div>
                      <div>
                        <div className="text-white font-bold text-xl tracking-wide">{player.username}</div>
                        <div className="text-green-400/80 text-sm font-semibold">{player.place}</div>
                      </div>
                    </div>
                    <div className="text-green-400 font-bold text-2xl flex items-center gap-2">
                      {player.points}
                      <span className="text-sm text-white/60">PTS</span>
                    </div>
                  </div>
                ))}
              </div>
            </div>

            <div className="mt-12 text-center">
              <button
                onClick={() => handleNavigate('chapters')}
                className="px-20 py-5 bg-gradient-to-r from-green-600 to-green-500 hover:from-green-500 hover:to-green-400 text-white font-bold text-2xl tracking-widest rounded-xl shadow-2xl transform hover:scale-110 transition-all border-2 border-green-400/50 animate-pulse"
              >
                START FARMING GAME
              </button>
              <p className="text-white/60 mt-4 text-sm">Begin your journey to become the top farmer!</p>
            </div>
          </div>
        )}

        {currentScreen === 'chapters' && (
          <div className="min-h-screen p-6">
            <button
              onClick={() => handleNavigate('leaderboard')}
              className="text-white/60 hover:text-white mb-8 flex items-center gap-2 text-xl"
            >
              <ChevronLeft className="w-6 h-6" />
              Back
            </button>

            <h1 className="text-5xl font-bold text-center mb-4 text-yellow-400 tracking-widest" style={{ fontFamily: 'monospace' }}>
              CHOOSE YOUR PATH
            </h1>
            <p className="text-center text-green-400 text-xl mb-12 tracking-wide">Select a farming chapter to begin</p>

            <div className="max-w-6xl mx-auto grid md:grid-cols-2 gap-6">
              {chapters.map((chapter) => (
                <button
                  key={chapter.id}
                  onClick={() => handleChapterSelect(chapter.id as ChapterType)}
                  className="backdrop-blur-sm bg-gradient-to-br from-yellow-700/30 to-yellow-900/30 rounded-xl border-2 border-yellow-600/50 p-8 hover:border-green-400 hover:scale-105 transition-all shadow-xl text-left group"
                >
                  <div className="flex items-start gap-6">
                    <div className="text-7xl group-hover:scale-110 transition-transform">{chapter.icon}</div>
                    <div className="flex-1">
                      <h3 className="text-3xl font-bold text-white mb-2 tracking-wide">{chapter.title}</h3>
                      <p className="text-yellow-400 text-lg mb-3">{chapter.subtitle}</p>
                      <p className="text-white/70">{chapter.description}</p>
                    </div>
                  </div>
                </button>
              ))}
            </div>
          </div>
        )}

        {currentScreen === 'subchapters' && selectedChapter && (
          <div className="min-h-screen p-6">
            <button
              onClick={() => handleNavigate('chapters')}
              className="text-white/60 hover:text-white mb-8 flex items-center gap-2 text-xl"
            >
              <ChevronLeft className="w-6 h-6" />
              Back to Chapters
            </button>

            <h1 className="text-5xl font-bold text-center mb-4 text-yellow-400 tracking-widest" style={{ fontFamily: 'monospace' }}>
              {chapters.find(c => c.id === selectedChapter)?.title.toUpperCase()}
            </h1>
            <p className="text-center text-green-400 text-xl mb-12 tracking-wide">Select a farming technique</p>

            <div className="max-w-5xl mx-auto grid md:grid-cols-2 lg:grid-cols-3 gap-5">
              {subChapters[selectedChapter].map((sub) => (
                <button
                  key={sub.id}
                  onClick={playClickSound}
                  className="backdrop-blur-sm bg-gradient-to-br from-green-700/30 to-green-900/30 rounded-xl border-2 border-green-600/50 p-6 hover:border-yellow-400 hover:scale-105 transition-all shadow-xl text-center group"
                >
                  <div className="text-6xl mb-4 group-hover:scale-110 transition-transform">{sub.icon}</div>
                  <h4 className="text-xl font-bold text-white mb-2 tracking-wide">{sub.name}</h4>
                  <p className="text-white/60 text-sm">{sub.description}</p>
                  <div className="mt-4 px-4 py-2 bg-yellow-500/20 rounded-lg border border-yellow-500/40 text-yellow-400 font-semibold text-sm">
                    Start Mission
                  </div>
                </button>
              ))}
            </div>
          </div>
        )}

        {currentScreen === 'dashboard' && (
          <div className="min-h-screen p-6">
            <button
              onClick={() => handleNavigate('home')}
              className="text-white/60 hover:text-white mb-8 flex items-center gap-2 text-xl"
            >
              <ChevronLeft className="w-6 h-6" />
              Back to Home
            </button>

            <div className="max-w-5xl mx-auto">
              <div className="flex items-center justify-center gap-4 mb-12">
                <Trophy className="w-12 h-12 text-yellow-400" />
                <h1 className="text-5xl font-bold text-yellow-400 tracking-widest" style={{ fontFamily: 'monospace' }}>
                  MY DASHBOARD
                </h1>
              </div>

              <div className="backdrop-blur-sm bg-black/40 rounded-xl border-2 border-yellow-600/60 p-8 mb-8">
                <div className="flex items-center gap-6 mb-8">
                  <div className="text-7xl">👨‍🌾</div>
                  <div>
                    <h2 className="text-3xl font-bold text-white tracking-wide">{username}</h2>
                    <p className="text-green-400 text-lg">Master Farmer</p>
                  </div>
                </div>
              </div>

              <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                <div className="backdrop-blur-sm bg-gradient-to-br from-blue-700/30 to-blue-900/30 rounded-xl border-2 border-blue-500/50 p-6 shadow-xl">
                  <div className="flex items-center gap-4 mb-4">
                    <Gamepad2 className="w-10 h-10 text-blue-400" />
                    <div>
                      <p className="text-white/60 text-sm">Games Played</p>
                      <p className="text-4xl font-bold text-white">{userStats.gamesPlayed}</p>
                    </div>
                  </div>
                </div>

                <div className="backdrop-blur-sm bg-gradient-to-br from-purple-700/30 to-purple-900/30 rounded-xl border-2 border-purple-500/50 p-6 shadow-xl">
                  <div className="flex items-center gap-4 mb-4">
                    <Clock className="w-10 h-10 text-purple-400" />
                    <div>
                      <p className="text-white/60 text-sm">Hours Played</p>
                      <p className="text-4xl font-bold text-white">{userStats.hoursPlayed}</p>
                    </div>
                  </div>
                </div>

                <div className="backdrop-blur-sm bg-gradient-to-br from-green-700/30 to-green-900/30 rounded-xl border-2 border-green-500/50 p-6 shadow-xl">
                  <div className="flex items-center gap-4 mb-4">
                    <Check className="w-10 h-10 text-green-400" />
                    <div>
                      <p className="text-white/60 text-sm">Chapters Done</p>
                      <p className="text-4xl font-bold text-white">{userStats.chaptersCompleted}</p>
                    </div>
                  </div>
                </div>

                <div className="backdrop-blur-sm bg-gradient-to-br from-yellow-700/30 to-yellow-900/30 rounded-xl border-2 border-yellow-500/50 p-6 shadow-xl">
                  <div className="flex items-center gap-4 mb-4">
                    <TrendingUp className="w-10 h-10 text-yellow-400" />
                    <div>
                      <p className="text-white/60 text-sm">Total Score</p>
                      <p className="text-4xl font-bold text-white">{userStats.totalScore}</p>
                    </div>
                  </div>
                </div>
              </div>

              <div className="backdrop-blur-sm bg-black/40 rounded-xl border-2 border-yellow-600/60 p-8">
                <h3 className="text-2xl font-bold text-white mb-6 tracking-wide">Recent Activity</h3>
                <div className="space-y-4">
                  <div className="flex items-center justify-between p-4 bg-green-700/20 rounded-lg border border-green-600/30">
                    <div className="flex items-center gap-4">
                      <div className="text-3xl">🌾</div>
                      <div>
                        <p className="text-white font-bold">Completed Arable Farming</p>
                        <p className="text-white/60 text-sm">Land-Based Farming</p>
                      </div>
                    </div>
                    <div className="text-green-400 font-bold">+500 pts</div>
                  </div>

                  <div className="flex items-center justify-between p-4 bg-blue-700/20 rounded-lg border border-blue-600/30">
                    <div className="flex items-center gap-4">
                      <div className="text-3xl">🐟</div>
                      <div>
                        <p className="text-white font-bold">Started Aquaculture</p>
                        <p className="text-white/60 text-sm">Water-Based Farming</p>
                      </div>
                    </div>
                    <div className="text-blue-400 font-bold">In Progress</div>
                  </div>

                  <div className="flex items-center justify-between p-4 bg-purple-700/20 rounded-lg border border-purple-600/30">
                    <div className="flex items-center gap-4">
                      <div className="text-3xl">💧</div>
                      <div>
                        <p className="text-white font-bold">Unlocked Hydroponics</p>
                        <p className="text-white/60 text-sm">Innovative Farming</p>
                      </div>
                    </div>
                    <div className="text-purple-400 font-bold">New!</div>
                  </div>
                </div>
              </div>

              <div className="mt-8 text-center">
                <button
                  onClick={() => handleNavigate('chapters')}
                  className="px-12 py-4 bg-gradient-to-r from-green-600 to-green-500 hover:from-green-500 hover:to-green-400 text-white font-bold text-xl tracking-widest rounded-xl shadow-xl transform hover:scale-105 transition-all border-2 border-green-400/50"
                >
                  CONTINUE FARMING
                </button>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

export default App;
