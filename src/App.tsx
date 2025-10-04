import { useState, useEffect } from 'react';
import { AuthProvider, useAuth } from './contexts/AuthContext';
import { AuthModal } from './components/Auth/AuthModal';
import { Header } from './components/Header';
import { ChapterCard } from './components/ChapterCard';
import { SubchapterCard } from './components/SubchapterCard';
import { QuizContainer } from './components/Quiz/QuizContainer';
import { Leaderboard } from './components/Leaderboard';
import { supabase } from './lib/supabase';
import { useBackgroundMusic } from './hooks/useSound';
import { Trophy, BookOpen } from 'lucide-react';

type View = 'chapters' | 'subchapter' | 'quiz' | 'leaderboard';

function AppContent() {
  const { user, loading: authLoading } = useAuth();
  const [showAuthModal, setShowAuthModal] = useState(false);
  const [view, setView] = useState<View>('chapters');
  const [chapters, setChapters] = useState<any[]>([]);
  const [subchapters, setSubchapters] = useState<any[]>([]);
  const [selectedChapter, setSelectedChapter] = useState<any>(null);
  const [selectedSubchapter, setSelectedSubchapter] = useState<any>(null);
  const [loading, setLoading] = useState(true);

  useBackgroundMusic('https://assets.mixkit.co/active_storage/sfx/2571/2571-preview.mp3', 0.15);

  useEffect(() => {
    if (!authLoading && !user) {
      setShowAuthModal(true);
    }
  }, [user, authLoading]);

  useEffect(() => {
    if (user) {
      loadChapters();
    }
  }, [user]);

  const loadChapters = async () => {
    setLoading(true);
    const { data, error } = await supabase
      .from('chapters')
      .select('*')
      .order('order_index');

    if (error) {
      console.error('Error loading chapters:', error);
      return;
    }

    if (data) {
      setChapters(data);
    }
    setLoading(false);
  };

  const loadSubchapters = async (chapterId: string) => {
    const { data, error } = await supabase
      .from('subchapters')
      .select('*')
      .eq('chapter_id', chapterId)
      .order('order_index');

    if (error) {
      console.error('Error loading subchapters:', error);
      return;
    }

    if (data) {
      setSubchapters(data);
    }
  };

  const handleChapterClick = async (chapter: any) => {
    setSelectedChapter(chapter);
    await loadSubchapters(chapter.id);
    setView('subchapter');
  };

  const handleSubchapterClick = (subchapter: any) => {
    setSelectedSubchapter(subchapter);
    setView('quiz');
  };

  const handleBackToChapters = () => {
    setSelectedChapter(null);
    setSubchapters([]);
    setView('chapters');
  };

  const handleBackToSubchapters = () => {
    setSelectedSubchapter(null);
    setView('subchapter');
  };

  if (authLoading || !user) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-green-900 via-emerald-800 to-teal-900 flex items-center justify-center">
        <AuthModal isOpen={showAuthModal} onClose={() => setShowAuthModal(false)} />
        <div className="text-center">
          <div className="text-8xl mb-4 animate-bounce">🌱</div>
          <h1 className="text-4xl font-bold text-white mb-2">FarmEd</h1>
          <p className="text-green-200">NASA-Powered Farming Education</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-green-50 via-emerald-50 to-teal-50">
      <Header />

      <main className="container mx-auto px-4 py-8">
        <div className="flex justify-center gap-4 mb-8">
          <button
            onClick={() => setView('chapters')}
            className={`flex items-center gap-2 px-6 py-3 rounded-xl font-semibold transition-all ${
              view === 'chapters' || view === 'subchapter' || view === 'quiz'
                ? 'bg-green-600 text-white shadow-lg'
                : 'bg-white text-gray-700 hover:bg-gray-100'
            }`}
          >
            <BookOpen size={20} />
            Chapters
          </button>
          <button
            onClick={() => setView('leaderboard')}
            className={`flex items-center gap-2 px-6 py-3 rounded-xl font-semibold transition-all ${
              view === 'leaderboard'
                ? 'bg-green-600 text-white shadow-lg'
                : 'bg-white text-gray-700 hover:bg-gray-100'
            }`}
          >
            <Trophy size={20} />
            Leaderboard
          </button>
        </div>

        {loading ? (
          <div className="flex items-center justify-center min-h-[400px]">
            <div className="text-center">
              <div className="animate-spin text-6xl mb-4">🌱</div>
              <p className="text-xl text-gray-600">Loading...</p>
            </div>
          </div>
        ) : (
          <>
            {view === 'chapters' && (
              <div>
                <div className="text-center mb-12">
                  <h2 className="text-5xl font-bold text-gray-800 mb-4">
                    Choose Your Farming Path
                  </h2>
                  <p className="text-xl text-gray-600">
                    Explore 4 chapters with 16 topics and 160+ quiz questions
                  </p>
                </div>
                <div className="grid md:grid-cols-2 gap-6 max-w-6xl mx-auto">
                  {chapters.map((chapter) => (
                    <ChapterCard
                      key={chapter.id}
                      title={chapter.title}
                      icon={chapter.icon}
                      subchapterCount={
                        chapter.title === 'Land-Based Farming'
                          ? 5
                          : chapter.title === 'Water-Based Farming'
                          ? 4
                          : chapter.title === 'Innovative Farming'
                          ? 4
                          : 3
                      }
                      onClick={() => handleChapterClick(chapter)}
                    />
                  ))}
                </div>
              </div>
            )}

            {view === 'subchapter' && selectedChapter && (
              <div>
                <div className="text-center mb-8">
                  <h2 className="text-4xl font-bold text-gray-800 mb-2">
                    {selectedChapter.icon} {selectedChapter.title}
                  </h2>
                  <p className="text-gray-600">Select a topic to start learning</p>
                </div>
                <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6 max-w-7xl mx-auto">
                  {subchapters.map((subchapter) => (
                    <button
                      key={subchapter.id}
                      onClick={() => handleSubchapterClick(subchapter)}
                      className="bg-white rounded-2xl shadow-lg hover:shadow-2xl transform hover:scale-105 transition-all p-6 text-left group"
                    >
                      <div className="text-center mb-4">
                        <span className="text-6xl group-hover:scale-110 transition-transform inline-block">
                          {subchapter.icon}
                        </span>
                      </div>
                      <h3 className="text-xl font-bold text-gray-800 mb-2 text-center">
                        {subchapter.title}
                      </h3>
                      <p className="text-sm text-gray-600 text-center">
                        {subchapter.description.substring(0, 80)}...
                      </p>
                      <div className="mt-4 text-center">
                        <span className="text-green-600 font-semibold group-hover:text-green-700">
                          Start Learning →
                        </span>
                      </div>
                    </button>
                  ))}
                </div>
                <div className="text-center mt-8">
                  <button
                    onClick={handleBackToChapters}
                    className="text-green-600 hover:text-green-700 font-semibold"
                  >
                    ← Back to Chapters
                  </button>
                </div>
              </div>
            )}

            {view === 'quiz' && selectedSubchapter && (
              <div>
                <SubchapterCard
                  title={selectedSubchapter.title}
                  icon={selectedSubchapter.icon}
                  description={selectedSubchapter.description}
                  nasa_resources={selectedSubchapter.nasa_resources}
                  onStartQuiz={() => {}}
                  onBack={handleBackToSubchapters}
                />
                <div className="mt-8">
                  <QuizContainer
                    subchapterId={selectedSubchapter.id}
                    subchapterTitle={selectedSubchapter.title}
                    onBack={handleBackToSubchapters}
                  />
                </div>
              </div>
            )}

            {view === 'leaderboard' && <Leaderboard />}
          </>
        )}
      </main>
    </div>
  );
}

function App() {
  return (
    <AuthProvider>
      <AppContent />
    </AuthProvider>
  );
}

export default App;
