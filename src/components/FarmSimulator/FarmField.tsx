import { FarmState } from './FarmSimulator';

interface FarmFieldProps {
  farmState: FarmState;
}

export function FarmField({ farmState }: FarmFieldProps) {
  const getFieldColor = () => {
    if (farmState.cropHealth > 70) return 'from-green-600 to-green-700';
    if (farmState.cropHealth > 40) return 'from-yellow-600 to-yellow-700';
    return 'from-orange-700 to-red-700';
  };

  const getCropDensity = () => {
    const count = Math.floor((farmState.cropGrowth / 100) * 50);
    return Array.from({ length: count }, (_, i) => i);
  };

  return (
    <div className="bg-white rounded-2xl shadow-xl p-6 mb-6">
      <h3 className="text-xl font-bold text-gray-800 mb-4">Your Farm Field</h3>

      <div className="relative h-64 bg-gradient-to-b from-sky-200 to-green-100 rounded-xl overflow-hidden border-4 border-green-800">
        <div className="absolute inset-0 bg-gradient-to-t from-green-900/20 to-transparent" />

        <div className={`absolute bottom-0 left-0 right-0 h-3/4 bg-gradient-to-b ${getFieldColor()} transition-all duration-1000`}>
          <div className="grid grid-cols-10 gap-1 p-4 h-full">
            {getCropDensity().map((i) => (
              <div
                key={i}
                className="text-2xl animate-bounce"
                style={{ animationDelay: `${i * 0.1}s`, animationDuration: '3s' }}
              >
                🌾
              </div>
            ))}
          </div>
        </div>

        {farmState.weather.current === 'Rainy' && (
          <div className="absolute inset-0 pointer-events-none">
            {Array.from({ length: 20 }).map((_, i) => (
              <div
                key={i}
                className="absolute text-blue-400 animate-pulse"
                style={{
                  left: `${Math.random() * 100}%`,
                  top: `${Math.random() * 100}%`,
                  animationDelay: `${Math.random() * 2}s`
                }}
              >
                💧
              </div>
            ))}
          </div>
        )}

        <div className="absolute top-4 left-4 bg-white/90 backdrop-blur-sm px-3 py-1 rounded-full text-sm font-semibold">
          {farmState.weather.current} ☀️
        </div>
      </div>

      <div className="grid grid-cols-3 gap-4 mt-4">
        <div className="bg-blue-50 p-3 rounded-lg">
          <div className="flex items-center gap-2 text-blue-700 mb-1">
            <span>💧</span>
            <span className="text-xs font-semibold">Water</span>
          </div>
          <div className="w-full bg-blue-200 rounded-full h-3 overflow-hidden">
            <div
              className="bg-blue-600 h-full transition-all duration-500"
              style={{ width: `${farmState.waterLevel}%` }}
            />
          </div>
          <div className="text-xs text-blue-700 mt-1">{farmState.waterLevel}%</div>
        </div>

        <div className="bg-green-50 p-3 rounded-lg">
          <div className="flex items-center gap-2 text-green-700 mb-1">
            <span>🌱</span>
            <span className="text-xs font-semibold">Nutrients</span>
          </div>
          <div className="w-full bg-green-200 rounded-full h-3 overflow-hidden">
            <div
              className="bg-green-600 h-full transition-all duration-500"
              style={{ width: `${farmState.nutrients}%` }}
            />
          </div>
          <div className="text-xs text-green-700 mt-1">{farmState.nutrients}%</div>
        </div>

        <div className="bg-purple-50 p-3 rounded-lg">
          <div className="flex items-center gap-2 text-purple-700 mb-1">
            <span>❤️</span>
            <span className="text-xs font-semibold">Health</span>
          </div>
          <div className="w-full bg-purple-200 rounded-full h-3 overflow-hidden">
            <div
              className="bg-purple-600 h-full transition-all duration-500"
              style={{ width: `${farmState.cropHealth}%` }}
            />
          </div>
          <div className="text-xs text-purple-700 mt-1">{farmState.cropHealth}%</div>
        </div>
      </div>
    </div>
  );
}
