import { X } from 'lucide-react';

interface TutorialModalProps {
  isOpen: boolean;
  onClose: () => void;
}

export function TutorialModal({ isOpen, onClose }: TutorialModalProps) {
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black/60 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-2xl shadow-2xl max-w-4xl w-full max-h-[90vh] overflow-y-auto">
        <div className="sticky top-0 bg-white border-b p-6 flex items-center justify-between">
          <h2 className="text-3xl font-bold text-gray-800">🌾 NASA Farm Simulator Tutorial</h2>
          <button
            onClick={onClose}
            className="text-gray-400 hover:text-gray-600 transition-colors"
          >
            <X size={28} />
          </button>
        </div>

        <div className="p-6 space-y-6">
          <div className="bg-blue-50 border-l-4 border-blue-500 p-4 rounded">
            <h3 className="font-bold text-blue-900 mb-2">🎯 Game Objective</h3>
            <p className="text-blue-800">
              Manage a farm using real NASA satellite data to make informed decisions about irrigation,
              fertilization, and harvesting. Maximize your profits while maintaining crop health and
              implementing sustainable practices.
            </p>
          </div>

          <div>
            <h3 className="text-2xl font-bold text-gray-800 mb-4">📡 Understanding NASA Data</h3>

            <div className="space-y-4">
              <div className="bg-gradient-to-r from-red-50 to-orange-50 p-4 rounded-xl border border-red-200">
                <h4 className="font-bold text-red-900 mb-2">🌡️ Temperature (Landsat 8/9)</h4>
                <p className="text-sm text-red-800 mb-2">
                  <span className="font-semibold">What it measures:</span> Land surface temperature, not air temperature
                </p>
                <p className="text-sm text-red-800 mb-2">
                  <span className="font-semibold">Resolution:</span> 30m spatial, 16-day revisit
                </p>
                <p className="text-sm text-red-800">
                  <span className="font-semibold">How to use:</span> High temps (&gt;28°C) increase water needs. Surface can be
                  5-10°C hotter than air. Plan irrigation when temps are high.
                </p>
              </div>

              <div className="bg-gradient-to-r from-blue-50 to-cyan-50 p-4 rounded-xl border border-blue-200">
                <h4 className="font-bold text-blue-900 mb-2">💧 Soil Moisture (SMAP)</h4>
                <p className="text-sm text-blue-800 mb-2">
                  <span className="font-semibold">What it measures:</span> Volumetric water content in top 0-10cm of soil
                </p>
                <p className="text-sm text-blue-800 mb-2">
                  <span className="font-semibold">Resolution:</span> 9km spatial, 2-3 day revisit
                </p>
                <p className="text-sm text-blue-800">
                  <span className="font-semibold">How to use:</span> Values below 0.25 indicate drought stress. Different crops
                  need different levels. Remember: this is surface moisture, roots go deeper!
                </p>
              </div>

              <div className="bg-gradient-to-r from-sky-50 to-blue-50 p-4 rounded-xl border border-sky-200">
                <h4 className="font-bold text-sky-900 mb-2">☔ Precipitation (GPM)</h4>
                <p className="text-sm text-sky-800 mb-2">
                  <span className="font-semibold">What it measures:</span> Rainfall and snowfall globally
                </p>
                <p className="text-sm text-sky-800 mb-2">
                  <span className="font-semibold">Resolution:</span> 10km spatial, 3-hour updates
                </p>
                <p className="text-sm text-sky-800">
                  <span className="font-semibold">How to use:</span> Use forecasts to plan ahead! If rain is coming, delay
                  irrigation to save money. 5mm+ rain can add significant soil moisture.
                </p>
              </div>

              <div className="bg-gradient-to-r from-green-50 to-emerald-50 p-4 rounded-xl border border-green-200">
                <h4 className="font-bold text-green-900 mb-2">🌱 NDVI (MODIS)</h4>
                <p className="text-sm text-green-800 mb-2">
                  <span className="font-semibold">What it measures:</span> Vegetation health via red/near-infrared reflectance
                </p>
                <p className="text-sm text-green-800 mb-2">
                  <span className="font-semibold">Resolution:</span> 250m spatial, daily updates
                </p>
                <p className="text-sm text-green-800">
                  <span className="font-semibold">How to use:</span> 0.0-0.3 = bare soil, 0.3-0.6 = stressed crops,
                  0.6-0.8 = healthy crops, 0.8-1.0 = dense vegetation. Dropping NDVI = problem developing.
                </p>
              </div>
            </div>
          </div>

          <div>
            <h3 className="text-2xl font-bold text-gray-800 mb-4">🎮 How to Play</h3>

            <div className="space-y-3">
              <div className="bg-purple-50 p-4 rounded-xl">
                <h4 className="font-bold text-purple-900 mb-2">1. Monitor Your Farm</h4>
                <p className="text-sm text-purple-800">
                  Watch water levels, nutrient status, and crop health. The game advances automatically,
                  simulating days passing. Your crops grow based on conditions you provide.
                </p>
              </div>

              <div className="bg-indigo-50 p-4 rounded-xl">
                <h4 className="font-bold text-indigo-900 mb-2">2. Read NASA Data</h4>
                <p className="text-sm text-indigo-800">
                  Check the satellite data panel regularly. Look for trends, not just current values.
                  Is soil moisture dropping? Is temperature rising? Plan ahead!
                </p>
              </div>

              <div className="bg-pink-50 p-4 rounded-xl">
                <h4 className="font-bold text-pink-900 mb-2">3. Make Decisions</h4>
                <p className="text-sm text-pink-800">
                  Choose irrigation intensity, fertilizer type, and harvest timing. Each decision costs money
                  but affects crop outcomes. Balance short-term costs with long-term gains.
                </p>
              </div>

              <div className="bg-amber-50 p-4 rounded-xl">
                <h4 className="font-bold text-amber-900 mb-2">4. Harvest & Profit</h4>
                <p className="text-sm text-amber-800">
                  When crops reach 80%+ growth, harvest them. Revenue depends on crop health and growth level.
                  Use profits to fund the next growing cycle.
                </p>
              </div>
            </div>
          </div>

          <div className="bg-yellow-50 border-l-4 border-yellow-500 p-4 rounded">
            <h3 className="font-bold text-yellow-900 mb-2">💡 Pro Tips</h3>
            <ul className="space-y-2 text-sm text-yellow-800">
              <li>• <span className="font-semibold">Don't over-irrigate:</span> Too much water wastes money and can stress crops</li>
              <li>• <span className="font-semibold">Watch NDVI trends:</span> Dropping values mean action needed before visible stress</li>
              <li>• <span className="font-semibold">Use precipitation forecasts:</span> Save money by delaying irrigation before rain</li>
              <li>• <span className="font-semibold">Consider data resolution:</span> SMAP is coarse (9km) - represents regional patterns</li>
              <li>• <span className="font-semibold">Think like a farmer:</span> Balance costs, timing, and data to maximize returns</li>
              <li>• <span className="font-semibold">Organic vs Synthetic:</span> Organic is cheaper, slower. Synthetic is faster, pricier.</li>
            </ul>
          </div>

          <div className="bg-red-50 border-l-4 border-red-500 p-4 rounded">
            <h3 className="font-bold text-red-900 mb-2">⚠️ Common Pitfalls</h3>
            <ul className="space-y-2 text-sm text-red-800">
              <li>• <span className="font-semibold">Ignoring early warnings:</span> Low NDVI or soil moisture are early indicators</li>
              <li>• <span className="font-semibold">One-size-fits-all:</span> Different growth stages need different management</li>
              <li>• <span className="font-semibold">Surface-level thinking:</span> SMAP shows 0-10cm, but roots go much deeper</li>
              <li>• <span className="font-semibold">Overreacting:</span> Small changes are normal; watch for sustained trends</li>
              <li>• <span className="font-semibold">Forgetting context:</span> Temperature + low moisture = urgent; just one alone may be OK</li>
            </ul>
          </div>

          <div className="bg-green-50 border-l-4 border-green-500 p-4 rounded">
            <h3 className="font-bold text-green-900 mb-2">🌍 Real-World Application</h3>
            <p className="text-sm text-green-800">
              This simulator uses real NASA data sources that farmers worldwide can access for free.
              The decision-making skills you develop here apply to actual precision agriculture.
              Understanding data limitations, combining multiple sources, and timing interventions
              are critical skills for modern, sustainable farming.
            </p>
          </div>
        </div>

        <div className="sticky bottom-0 bg-gray-50 border-t p-6">
          <button
            onClick={onClose}
            className="w-full bg-gradient-to-r from-green-500 to-emerald-600 text-white py-4 rounded-xl font-bold text-lg hover:from-green-600 hover:to-emerald-700 transition-all"
          >
            Start Farming! 🚜
          </button>
        </div>
      </div>
    </div>
  );
}
