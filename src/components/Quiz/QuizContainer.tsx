import { useState, useEffect } from 'react';
import { supabase } from '../../lib/supabase';
import { useAuth } from '../../contexts/AuthContext';
import { QuizQuestion } from './QuizQuestion';
import { QuizResults } from './QuizResults';
import { Trophy, Clock, Target } from 'lucide-react';
import { useSound } from '../../hooks/useSound';

interface QuizContainerProps {
  subchapterId: string;
  subchapterTitle: string;
  onBack: () => void;
}

export function QuizContainer({ subchapterId, subchapterTitle, onBack }: QuizContainerProps) {
  const { user } = useAuth();
  const [questions, setQuestions] = useState<any[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [score, setScore] = useState(0);
  const [answers, setAnswers] = useState<any[]>([]);
  const [quizComplete, setQuizComplete] = useState(false);
  const [loading, setLoading] = useState(true);
  const [startTime] = useState(Date.now());

  const correctSound = useSound('https://assets.mixkit.co/active_storage/sfx/2018/2018-preview.mp3');
  const wrongSound = useSound('https://assets.mixkit.co/active_storage/sfx/2955/2955-preview.mp3');

  useEffect(() => {
    loadQuestions();
  }, [subchapterId]);

  const loadQuestions = async () => {
    setLoading(true);
    const { data, error } = await supabase
      .from('questions')
      .select('*')
      .eq('subchapter_id', subchapterId)
      .limit(10);

    if (error) {
      console.error('Error loading questions:', error);
      return;
    }

    if (data) {
      const shuffled = data.sort(() => Math.random() - 0.5);
      setQuestions(shuffled);
    }
    setLoading(false);
  };

  const handleAnswer = async (isCorrect: boolean, pointsEarned: number, timeTaken: number, answerData: any) => {
    if (isCorrect) {
      correctSound.play();
    } else {
      wrongSound.play();
    }

    setScore(score + pointsEarned);
    setAnswers([
      ...answers,
      {
        question_id: questions[currentIndex].id,
        answer_data: answerData,
        is_correct: isCorrect,
        points_earned: pointsEarned,
        time_taken: timeTaken,
      },
    ]);

    if (currentIndex < questions.length - 1) {
      setTimeout(() => {
        setCurrentIndex(currentIndex + 1);
      }, 100);
    } else {
      saveQuizAttempt(pointsEarned);
    }
  };

  const saveQuizAttempt = async (finalScore: number) => {
    const totalTime = Math.floor((Date.now() - startTime) / 1000);
    const maxScore = questions.reduce((sum, q) => sum + q.points, 0);

    const { data: attemptData, error: attemptError } = await supabase
      .from('quiz_attempts')
      .insert([
        {
          user_id: user?.id,
          subchapter_id: subchapterId,
          score: finalScore,
          max_score: maxScore,
          time_taken: totalTime,
        },
      ])
      .select()
      .single();

    if (attemptError) {
      console.error('Error saving attempt:', attemptError);
      return;
    }

    const answersToSave = answers.map((answer) => ({
      ...answer,
      attempt_id: attemptData.id,
      user_id: user?.id,
    }));

    await supabase.from('user_answers').insert(answersToSave);

    const { data: profile } = await supabase
      .from('user_profiles')
      .select('total_points, current_streak')
      .eq('id', user?.id)
      .single();

    if (profile) {
      await supabase
        .from('user_profiles')
        .update({
          total_points: profile.total_points + finalScore,
          current_streak: profile.current_streak + 1,
        })
        .eq('id', user?.id);
    }

    setQuizComplete(true);
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-center">
          <div className="animate-spin text-6xl mb-4">🌱</div>
          <p className="text-xl text-gray-600">Loading questions...</p>
        </div>
      </div>
    );
  }

  if (quizComplete) {
    const maxScore = questions.reduce((sum, q) => sum + q.points, 0);
    const totalTime = Math.floor((Date.now() - startTime) / 1000);
    return (
      <QuizResults
        score={score}
        maxScore={maxScore}
        totalTime={totalTime}
        questionsCount={questions.length}
        correctCount={answers.filter((a) => a.is_correct).length}
        subchapterTitle={subchapterTitle}
        onRetry={() => {
          setCurrentIndex(0);
          setScore(0);
          setAnswers([]);
          setQuizComplete(false);
          loadQuestions();
        }}
        onBack={onBack}
      />
    );
  }

  const progress = ((currentIndex + 1) / questions.length) * 100;

  return (
    <div className="max-w-6xl mx-auto">
      <div className="mb-6">
        <div className="bg-white rounded-xl shadow-lg p-4 mb-4">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm font-semibold text-gray-600">
              Question {currentIndex + 1} of {questions.length}
            </span>
            <div className="flex items-center gap-4">
              <div className="flex items-center gap-1 text-green-600">
                <Trophy size={18} />
                <span className="font-bold">{score}</span>
              </div>
            </div>
          </div>
          <div className="w-full bg-gray-200 rounded-full h-3 overflow-hidden">
            <div
              className="bg-gradient-to-r from-green-500 to-emerald-600 h-full transition-all duration-500 rounded-full"
              style={{ width: `${progress}%` }}
            />
          </div>
        </div>
      </div>

      {questions[currentIndex] && (
        <QuizQuestion question={questions[currentIndex]} onAnswer={handleAnswer} />
      )}
    </div>
  );
}
