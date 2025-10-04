interface NASAResource {
  title: string;
  url: string;
  description: string;
}

interface SubchapterCardProps {
  title: string;
  icon: string;
  description: string;
  nasa_resources: NASAResource[];
  onStartQuiz: () => void;
  onBack: () => void;
}

export function SubchapterCard({
  title,
  icon,
  description,
  nasa_resources,
  onStartQuiz,
  onBack,
}: SubchapterCardProps) {
  return (
    <div className="max-w-4xl mx-auto">
      <button
        onClick={onBack}
        className="mb-6 flex items-center text-green-600 hover:text-green-700 font-semibold transition-colors"
      >
        <span className="mr-2">←</span> Back to Chapters
      </button>

      <div className="bg-white rounded-2xl shadow-2xl p-8 md:p-12">
        <div className="flex items-center justify-center mb-6">
          <span className="text-8xl">{icon}</span>
        </div>

        <h2 className="text-4xl font-bold text-gray-800 text-center mb-4">{title}</h2>
        <p className="text-lg text-gray-600 text-center mb-8 leading-relaxed">{description}</p>

        <div className="mb-8">
          <h3 className="text-2xl font-bold text-gray-800 mb-4 flex items-center">
            <span className="mr-2">🚀</span> NASA Resources
          </h3>
          <div className="grid gap-4">
            {nasa_resources.map((resource, index) => (
              <a
                key={index}
                href={resource.url}
                target="_blank"
                rel="noopener noreferrer"
                className="bg-gradient-to-r from-blue-50 to-indigo-50 p-4 rounded-xl hover:shadow-lg transition-all border border-blue-100 hover:border-blue-300 group"
              >
                <h4 className="font-bold text-blue-900 group-hover:text-blue-700 mb-1">
                  {resource.title} ↗
                </h4>
                <p className="text-sm text-blue-700">{resource.description}</p>
              </a>
            ))}
          </div>
        </div>

        <div className="flex flex-col sm:flex-row gap-4">
          <button
            onClick={onStartQuiz}
            className="flex-1 bg-gradient-to-r from-green-500 to-emerald-600 text-white py-4 rounded-xl font-bold text-lg hover:from-green-600 hover:to-emerald-700 transition-all transform hover:scale-105 shadow-lg hover:shadow-xl"
          >
            🎯 Start Quiz
          </button>
          <button
            onClick={onStartQuiz}
            className="flex-1 bg-gradient-to-r from-orange-500 to-red-600 text-white py-4 rounded-xl font-bold text-lg hover:from-orange-600 hover:to-red-700 transition-all transform hover:scale-105 shadow-lg hover:shadow-xl"
          >
            🏆 Practice Mode
          </button>
        </div>
      </div>
    </div>
  );
}
