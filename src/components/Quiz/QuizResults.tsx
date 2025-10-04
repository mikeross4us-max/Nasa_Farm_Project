import { Trophy, Clock, Target, RotateCcw, Home } from 'lucide-react';

interface QuizResultsProps {
  score: number;
  maxScore: number;
  totalTime: number;
  questionsCount: number;
  correctCount: number;
  subchapterTitle: string;
  onRetry: () => void;
  onBack: () => void;
}

export function QuizResults({
  score,
  maxScore,
  totalTime,
  questionsCount,
  correctCount,
  subchapterTitle,
  onRetry,
  onBack,
}: QuizResultsProps) {
  const percentage = Math.round((score / maxScore) * 100);
  const accuracy = Math.round((correctCount / questionsCount) * 100);

  const getGrade = () => {
    if (percentage >= 90) return { grade: 'A+', color: 'text-green-600', emoji: '🏆' };
    if (percentage >= 80) return { grade: 'A', color: 'text-green-500', emoji: '⭐' };
    if (percentage >= 70) return { grade: 'B', color: 'text-blue-500', emoji: '👍' };
    if (percentage >= 60) return { grade: 'C', color: 'text-yellow-500', emoji: '📚' };
    return { grade: 'D', color: 'text-red-500', emoji: '💪' };
  };

  const gradeInfo = getGrade();

  const minutes = Math.floor(totalTime / 60);
  const seconds = totalTime % 60;

  return (
    <div className="max-w-4xl mx-auto">
      <div className="bg-white rounded-2xl shadow-2xl p-8 md:p-12 text-center">
        <div className="text-8xl mb-6 animate-bounce">{gradeInfo.emoji}</div>

        <h2 className="text-4xl font-bold text-gray-800 mb-2">Quiz Complete!</h2>
        <p className="text-xl text-gray-600 mb-8">{subchapterTitle}</p>

        <div className={`text-7xl font-bold ${gradeInfo.color} mb-8`}>{gradeInfo.grade}</div>

        <div className="grid md:grid-cols-3 gap-6 mb-8">
          <div className="bg-gradient-to-br from-green-50 to-emerald-50 p-6 rounded-xl border-2 border-green-200">
            <div className="flex items-center justify-center mb-2">
              <Trophy className="text-green-600" size={32} />
            </div>
            <div className="text-3xl font-bold text-green-700 mb-1">
              {score}/{maxScore}
            </div>
            <div className="text-sm text-gray-600">Points Earned</div>
            <div className="text-lg font-semibold text-green-600 mt-1">{percentage}%</div>
          </div>

          <div className="bg-gradient-to-br from-blue-50 to-sky-50 p-6 rounded-xl border-2 border-blue-200">
            <div className="flex items-center justify-center mb-2">
              <Target className="text-blue-600" size={32} />
            </div>
            <div className="text-3xl font-bold text-blue-700 mb-1">
              {correctCount}/{questionsCount}
            </div>
            <div className="text-sm text-gray-600">Correct Answers</div>
            <div className="text-lg font-semibold text-blue-600 mt-1">{accuracy}%</div>
          </div>

          <div className="bg-gradient-to-br from-purple-50 to-pink-50 p-6 rounded-xl border-2 border-purple-200">
            <div className="flex items-center justify-center mb-2">
              <Clock className="text-purple-600" size={32} />
            </div>
            <div className="text-3xl font-bold text-purple-700 mb-1">
              {minutes}:{seconds.toString().padStart(2, '0')}
            </div>
            <div className="text-sm text-gray-600">Time Taken</div>
            <div className="text-lg font-semibold text-purple-600 mt-1">
              {Math.round(totalTime / questionsCount)}s per question
            </div>
          </div>
        </div>

        <div className="bg-gradient-to-r from-yellow-50 to-orange-50 p-6 rounded-xl border-2 border-yellow-200 mb-8">
          <h3 className="font-bold text-gray-800 mb-2">Performance Feedback</h3>
          <p className="text-gray-700">
            {percentage >= 90 && "Outstanding work! You've mastered this topic! 🌟"}
            {percentage >= 70 && percentage < 90 && "Great job! You have a solid understanding. Keep practicing!"}
            {percentage >= 50 && percentage < 70 && "Good effort! Review the materials and try again for a better score."}
            {percentage < 50 && "Keep learning! Review the NASA resources and practice more."}
          </p>
        </div>

        <div className="flex flex-col sm:flex-row gap-4">
          <button
            onClick={onRetry}
            className="flex-1 flex items-center justify-center gap-2 bg-gradient-to-r from-green-500 to-emerald-600 text-white py-4 rounded-xl font-bold text-lg hover:from-green-600 hover:to-emerald-700 transition-all transform hover:scale-105"
          >
            <RotateCcw size={20} />
            Try Again
          </button>
          <button
            onClick={onBack}
            className="flex-1 flex items-center justify-center gap-2 bg-gradient-to-r from-gray-500 to-gray-600 text-white py-4 rounded-xl font-bold text-lg hover:from-gray-600 hover:to-gray-700 transition-all transform hover:scale-105"
          >
            <Home size={20} />
            Back to Topics
          </button>
        </div>
      </div>
    </div>
  );
}
