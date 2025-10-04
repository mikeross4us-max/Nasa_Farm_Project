interface ChapterCardProps {
  title: string;
  icon: string;
  subchapterCount: number;
  onClick: () => void;
}

export function ChapterCard({ title, icon, subchapterCount, onClick }: ChapterCardProps) {
  return (
    <button
      onClick={onClick}
      className="bg-white rounded-2xl shadow-lg hover:shadow-2xl transform hover:scale-105 transition-all duration-300 p-8 text-left w-full group"
    >
      <div className="flex items-center justify-between mb-4">
        <span className="text-6xl group-hover:scale-110 transition-transform duration-300">
          {icon}
        </span>
        <div className="bg-green-100 text-green-700 px-3 py-1 rounded-full text-sm font-semibold">
          {subchapterCount} topics
        </div>
      </div>
      <h3 className="text-2xl font-bold text-gray-800 group-hover:text-green-600 transition-colors">
        {title}
      </h3>
      <p className="text-gray-600 mt-2">Explore and master this farming category</p>
      <div className="mt-4 flex items-center text-green-600 font-semibold">
        <span>Start Learning</span>
        <span className="ml-2 group-hover:translate-x-2 transition-transform">→</span>
      </div>
    </button>
  );
}
