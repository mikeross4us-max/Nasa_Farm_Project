import { useState } from 'react';
import { Check, X } from 'lucide-react';

interface QuestionProps {
  question: any;
  onAnswer: (isCorrect: boolean, pointsEarned: number, timeTaken: number, answerData: any) => void;
}

export function QuizQuestion({ question, onAnswer }: QuestionProps) {
  const [selectedAnswer, setSelectedAnswer] = useState<any>(null);
  const [showExplanation, setShowExplanation] = useState(false);
  const [startTime] = useState(Date.now());

  const handleSubmit = () => {
    const timeTaken = Math.floor((Date.now() - startTime) / 1000);
    let isCorrect = false;
    let pointsEarned = 0;

    switch (question.question_type) {
      case 'mcq':
        isCorrect = selectedAnswer === question.question_data.correct;
        break;
      case 'true_false':
        isCorrect = selectedAnswer === question.question_data.correct;
        break;
      case 'numeric':
        const numAnswer = parseFloat(selectedAnswer);
        const correct = question.question_data.correct;
        const tolerance = question.question_data.tolerance || 0;
        isCorrect = Math.abs(numAnswer - correct) <= tolerance;
        break;
      case 'free_text':
        isCorrect = true;
        break;
      case 'matching':
        isCorrect = JSON.stringify(selectedAnswer?.sort()) === JSON.stringify(question.question_data.correct?.sort());
        break;
      case 'ordering':
        isCorrect = JSON.stringify(selectedAnswer) === JSON.stringify(question.question_data.correct);
        break;
      default:
        isCorrect = false;
    }

    if (isCorrect) {
      pointsEarned = question.points;
    }

    setShowExplanation(true);
    setTimeout(() => {
      onAnswer(isCorrect, pointsEarned, timeTaken, selectedAnswer);
    }, 3000);
  };

  const renderQuestionInput = () => {
    switch (question.question_type) {
      case 'mcq':
        return (
          <div className="space-y-3">
            {question.question_data.options.map((option: string, index: number) => (
              <button
                key={index}
                onClick={() => setSelectedAnswer(option)}
                className={`w-full p-4 text-left rounded-xl border-2 transition-all ${
                  selectedAnswer === option
                    ? 'border-green-500 bg-green-50'
                    : 'border-gray-200 hover:border-green-300 bg-white'
                }`}
              >
                <span className="font-semibold text-gray-800">{option}</span>
              </button>
            ))}
          </div>
        );

      case 'true_false':
        return (
          <div className="flex gap-4">
            {[true, false].map((value) => (
              <button
                key={value.toString()}
                onClick={() => setSelectedAnswer(value)}
                className={`flex-1 p-6 rounded-xl border-2 font-bold text-lg transition-all ${
                  selectedAnswer === value
                    ? 'border-green-500 bg-green-50'
                    : 'border-gray-200 hover:border-green-300 bg-white'
                }`}
              >
                {value ? '✓ True' : '✗ False'}
              </button>
            ))}
          </div>
        );

      case 'numeric':
        return (
          <div>
            <input
              type="number"
              step="any"
              value={selectedAnswer || ''}
              onChange={(e) => setSelectedAnswer(e.target.value)}
              className="w-full p-4 text-lg border-2 border-gray-200 rounded-xl focus:border-green-500 focus:ring-2 focus:ring-green-200 outline-none transition-all"
              placeholder={`Enter your answer ${question.question_data.unit ? `(${question.question_data.unit})` : ''}`}
            />
          </div>
        );

      case 'free_text':
        return (
          <div>
            <textarea
              value={selectedAnswer || ''}
              onChange={(e) => setSelectedAnswer(e.target.value)}
              rows={5}
              className="w-full p-4 border-2 border-gray-200 rounded-xl focus:border-green-500 focus:ring-2 focus:ring-green-200 outline-none transition-all resize-none"
              placeholder="Type your answer here..."
            />
            {question.question_data.min_words && (
              <p className="text-sm text-gray-500 mt-2">
                Minimum {question.question_data.min_words} words required
              </p>
            )}
          </div>
        );

      case 'ordering':
        const [items, setItems] = useState(
          question.question_data.items.map((item: string, index: number) => ({
            text: item,
            order: index,
          }))
        );

        const moveItem = (index: number, direction: 'up' | 'down') => {
          const newItems = [...items];
          const newIndex = direction === 'up' ? index - 1 : index + 1;
          if (newIndex >= 0 && newIndex < newItems.length) {
            [newItems[index], newItems[newIndex]] = [newItems[newIndex], newItems[index]];
            setItems(newItems);
            setSelectedAnswer(newItems.map(item => item.text));
          }
        };

        return (
          <div className="space-y-2">
            {items.map((item, index) => (
              <div key={index} className="flex items-center gap-2 bg-white p-3 rounded-lg border border-gray-200">
                <span className="font-bold text-gray-400 min-w-[2rem]">{index + 1}.</span>
                <span className="flex-1">{item.text}</span>
                <div className="flex gap-1">
                  <button
                    onClick={() => moveItem(index, 'up')}
                    disabled={index === 0}
                    className="p-1 hover:bg-gray-100 rounded disabled:opacity-30"
                  >
                    ↑
                  </button>
                  <button
                    onClick={() => moveItem(index, 'down')}
                    disabled={index === items.length - 1}
                    className="p-1 hover:bg-gray-100 rounded disabled:opacity-30"
                  >
                    ↓
                  </button>
                </div>
              </div>
            ))}
          </div>
        );

      case 'matching':
        const [matches, setMatches] = useState<Array<[string, string]>>([]);
        const pairs = question.question_data.pairs;

        return (
          <div className="space-y-4">
            <div className="grid md:grid-cols-2 gap-4">
              <div className="space-y-2">
                <h4 className="font-semibold text-gray-700">Items</h4>
                {pairs.map((pair: any, index: number) => (
                  <div key={index} className="p-3 bg-blue-50 rounded-lg border border-blue-200">
                    {pair.left}
                  </div>
                ))}
              </div>
              <div className="space-y-2">
                <h4 className="font-semibold text-gray-700">Match with</h4>
                {pairs.map((pair: any, index: number) => (
                  <div key={index} className="p-3 bg-green-50 rounded-lg border border-green-200">
                    {pair.right}
                  </div>
                ))}
              </div>
            </div>
            <p className="text-sm text-gray-600 italic">
              Match each item on the left with its corresponding description on the right
            </p>
          </div>
        );

      default:
        return <p className="text-gray-500">Question type not yet implemented</p>;
    }
  };

  return (
    <div className="bg-white rounded-2xl shadow-xl p-8 max-w-4xl mx-auto">
      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center gap-3">
          <span className="bg-gradient-to-r from-green-500 to-emerald-600 text-white px-4 py-2 rounded-full font-bold">
            {question.points} pts
          </span>
          <span className="text-gray-600">
            {'⭐'.repeat(question.difficulty)}
          </span>
        </div>
        <span className="text-sm text-gray-500 uppercase tracking-wide">
          {question.question_type.replace('_', ' ')}
        </span>
      </div>

      <h3 className="text-2xl font-bold text-gray-800 mb-6">{question.question_text}</h3>

      {question.media_url && (
        <div className="mb-6">
          <img
            src={question.media_url}
            alt="Question media"
            className="w-full rounded-xl shadow-md"
          />
        </div>
      )}

      <div className="mb-6">{renderQuestionInput()}</div>

      {!showExplanation && (
        <button
          onClick={handleSubmit}
          disabled={selectedAnswer === null || selectedAnswer === ''}
          className="w-full bg-gradient-to-r from-green-500 to-emerald-600 text-white py-4 rounded-xl font-bold text-lg hover:from-green-600 hover:to-emerald-700 transition-all transform hover:scale-105 disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none"
        >
          Submit Answer
        </button>
      )}

      {showExplanation && (
        <div
          className={`mt-6 p-6 rounded-xl ${
            selectedAnswer === question.question_data.correct ||
            (question.question_type === 'numeric' &&
              Math.abs(parseFloat(selectedAnswer) - question.question_data.correct) <=
                (question.question_data.tolerance || 0))
              ? 'bg-green-50 border-2 border-green-500'
              : 'bg-red-50 border-2 border-red-500'
          } animate-fadeIn`}
        >
          <div className="flex items-center gap-2 mb-3">
            {selectedAnswer === question.question_data.correct ||
            (question.question_type === 'numeric' &&
              Math.abs(parseFloat(selectedAnswer) - question.question_data.correct) <=
                (question.question_data.tolerance || 0)) ? (
              <>
                <Check className="text-green-600" size={24} />
                <span className="font-bold text-green-800 text-lg">Correct!</span>
              </>
            ) : (
              <>
                <X className="text-red-600" size={24} />
                <span className="font-bold text-red-800 text-lg">Not quite right</span>
              </>
            )}
          </div>
          <p className="text-gray-700 leading-relaxed">{question.explanation}</p>
        </div>
      )}
    </div>
  );
}
