import { Droplets, Leaf, Scissors } from 'lucide-react';
import { FarmState, NASAData } from './FarmSimulator';

interface DecisionPanelProps {
  farmState: FarmState;
  nasaData: NASAData;
  onIrrigate: (amount: 'light' | 'moderate' | 'heavy') => void;
  onFertilize: (type: 'organic' | 'synthetic') => void;
  onHarvest: () => void;
}

export function DecisionPanel({
  farmState,
  nasaData,
  onIrrigate,
  onFertilize,
  onHarvest
}: DecisionPanelProps) {
  const getIrrigationRecommendation = () => {
    if (nasaData.soilMoisture < 0.2) return 'heavy';
    if (nasaData.soilMoisture < 0.35) return 'moderate';
    return 'light';
  };

  const shouldIrrigate = nasaData.soilMoisture < 0.4 || farmState.waterLevel < 40;
  const shouldFertilize = farmState.nutrients < 50 || nasaData.ndvi < 0.5;
  const canHarvest = farmState.cropGrowth >= 80;

  return (
    <div className="bg-white rounded-2xl shadow-xl p-6">
      <h3 className="text-xl font-bold text-gray-800 mb-4">Farm Management Decisions</h3>

      <div className="grid md:grid-cols-3 gap-4">
        <div className={`p-4 rounded-xl border-2 ${shouldIrrigate ? 'bg-blue-50 border-blue-300' : 'bg-gray-50 border-gray-200'}`}>
          <div className="flex items-center gap-2 mb-3">
            <Droplets className={shouldIrrigate ? 'text-blue-600' : 'text-gray-400'} size={24} />
            <h4 className="font-bold text-gray-800">Irrigation</h4>
          </div>

          {shouldIrrigate && (
            <div className="bg-yellow-100 text-yellow-800 text-xs p-2 rounded mb-3">
              ⚠️ Recommended: {getIrrigationRecommendation()} irrigation
            </div>
          )}

          <div className="space-y-2">
            <button
              onClick={() => onIrrigate('light')}
              className="w-full bg-blue-100 hover:bg-blue-200 text-blue-700 py-2 px-3 rounded-lg text-sm font-semibold transition-all"
            >
              Light (+15%) - $50
            </button>
            <button
              onClick={() => onIrrigate('moderate')}
              className="w-full bg-blue-200 hover:bg-blue-300 text-blue-800 py-2 px-3 rounded-lg text-sm font-semibold transition-all"
            >
              Moderate (+30%) - $100
            </button>
            <button
              onClick={() => onIrrigate('heavy')}
              className="w-full bg-blue-300 hover:bg-blue-400 text-blue-900 py-2 px-3 rounded-lg text-sm font-semibold transition-all"
            >
              Heavy (+50%) - $150
            </button>
          </div>

          <div className="mt-3 text-xs text-gray-600 bg-gray-100 p-2 rounded">
            💡 Higher irrigation in hot weather or low SMAP soil moisture readings
          </div>
        </div>

        <div className={`p-4 rounded-xl border-2 ${shouldFertilize ? 'bg-green-50 border-green-300' : 'bg-gray-50 border-gray-200'}`}>
          <div className="flex items-center gap-2 mb-3">
            <Leaf className={shouldFertilize ? 'text-green-600' : 'text-gray-400'} size={24} />
            <h4 className="font-bold text-gray-800">Fertilization</h4>
          </div>

          {shouldFertilize && (
            <div className="bg-yellow-100 text-yellow-800 text-xs p-2 rounded mb-3">
              ⚠️ Low NDVI detected - fertilization needed
            </div>
          )}

          <div className="space-y-2">
            <button
              onClick={() => onFertilize('organic')}
              className="w-full bg-green-100 hover:bg-green-200 text-green-700 py-2 px-3 rounded-lg text-sm font-semibold transition-all"
            >
              Organic (+25%) - $100
            </button>
            <button
              onClick={() => onFertilize('synthetic')}
              className="w-full bg-green-200 hover:bg-green-300 text-green-800 py-2 px-3 rounded-lg text-sm font-semibold transition-all"
            >
              Synthetic (+40%) - $150
            </button>
          </div>

          <div className="mt-3 text-xs text-gray-600 bg-gray-100 p-2 rounded">
            💡 Monitor NDVI to determine timing. Organic is slower but sustainable.
          </div>
        </div>

        <div className={`p-4 rounded-xl border-2 ${canHarvest ? 'bg-yellow-50 border-yellow-300' : 'bg-gray-50 border-gray-200'}`}>
          <div className="flex items-center gap-2 mb-3">
            <Scissors className={canHarvest ? 'text-yellow-600' : 'text-gray-400'} size={24} />
            <h4 className="font-bold text-gray-800">Harvest</h4>
          </div>

          {canHarvest ? (
            <div className="bg-green-100 text-green-800 text-xs p-2 rounded mb-3">
              ✅ Crop ready for harvest!
            </div>
          ) : (
            <div className="bg-gray-100 text-gray-600 text-xs p-2 rounded mb-3">
              ⏳ Crop needs {80 - farmState.cropGrowth}% more growth
            </div>
          )}

          <button
            onClick={onHarvest}
            disabled={!canHarvest}
            className={`w-full py-3 px-4 rounded-lg font-bold text-lg transition-all ${
              canHarvest
                ? 'bg-gradient-to-r from-yellow-500 to-orange-500 hover:from-yellow-600 hover:to-orange-600 text-white shadow-lg'
                : 'bg-gray-200 text-gray-400 cursor-not-allowed'
            }`}
          >
            🌾 Harvest Crop
          </button>

          <div className="mt-3 text-xs text-gray-600 bg-gray-100 p-2 rounded">
            💡 Revenue depends on crop health and growth percentage
          </div>
        </div>
      </div>

      <div className="mt-6 bg-gradient-to-r from-purple-50 to-pink-50 p-4 rounded-xl border-2 border-purple-200">
        <h4 className="font-bold text-purple-800 mb-2">Understanding the Data</h4>
        <div className="space-y-2 text-sm text-purple-700">
          <div>
            <span className="font-semibold">NDVI (0.0-1.0):</span> Measures crop health via chlorophyll.
            Higher = healthier. Low NDVI may indicate water/nutrient stress or disease.
          </div>
          <div>
            <span className="font-semibold">Soil Moisture:</span> SMAP measures 0-10cm depth.
            Different crops need different levels. Too much can be as bad as too little!
          </div>
          <div>
            <span className="font-semibold">Temperature:</span> Landsat surface temp differs from air temp.
            High temps increase evapotranspiration, requiring more water.
          </div>
          <div>
            <span className="font-semibold">Timing Matters:</span> Don't just react to current data.
            Use GPM precipitation forecasts to plan ahead and save money!
          </div>
        </div>
      </div>
    </div>
  );
}
