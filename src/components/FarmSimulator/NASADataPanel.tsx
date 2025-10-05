import { Thermometer, Droplet, CloudRain, Activity, Satellite } from 'lucide-react';
import { NASAData, FarmState } from './FarmSimulator';

interface NASADataPanelProps {
  nasaData: NASAData;
  farmState: FarmState;
}

export function NASADataPanel({ nasaData, farmState }: NASADataPanelProps) {
  const getSoilMoistureDepth = () => {
    return '0-10cm';
  };

  const getResolutionInfo = () => {
    return '30m (Field-scale)';
  };

  const getNDVIInterpretation = () => {
    if (nasaData.ndvi > 0.7) return { text: 'Healthy', color: 'text-green-600', bg: 'bg-green-50' };
    if (nasaData.ndvi > 0.4) return { text: 'Moderate', color: 'text-yellow-600', bg: 'bg-yellow-50' };
    return { text: 'Stressed', color: 'text-red-600', bg: 'bg-red-50' };
  };

  const ndviInterpretation = getNDVIInterpretation();

  const getRecommendations = () => {
    const recommendations: string[] = [];

    if (nasaData.soilMoisture < 0.25) {
      recommendations.push('🚨 SMAP data shows critically low soil moisture. Immediate irrigation recommended.');
    }

    if (nasaData.temperature > 28) {
      recommendations.push('🌡️ High temperature detected by Landsat. Increase irrigation frequency.');
    }

    if (nasaData.ndvi < 0.5 && farmState.cropGrowth > 20) {
      recommendations.push('📉 NDVI indicates crop stress. Check nutrients and water levels.');
    }

    if (nasaData.precipitation > 5 && farmState.day % 7 < 3) {
      recommendations.push('☔ GPM forecasts rain. Delay irrigation to conserve resources.');
    }

    if (farmState.nutrients < 40 && nasaData.ndvi < 0.6) {
      recommendations.push('🌱 Low NDVI + depleted nutrients. Fertilization needed soon.');
    }

    if (recommendations.length === 0) {
      recommendations.push('✅ Current conditions are optimal. Continue monitoring.');
    }

    return recommendations;
  };

  return (
    <div className="bg-white rounded-2xl shadow-xl p-6 sticky top-4">
      <div className="flex items-center gap-2 mb-6">
        <Satellite className="text-blue-600" size={24} />
        <h3 className="text-xl font-bold text-gray-800">NASA Satellite Data</h3>
      </div>

      <div className="space-y-4">
        <div className="bg-gradient-to-br from-red-50 to-orange-50 p-4 rounded-xl border-2 border-red-200">
          <div className="flex items-center justify-between mb-2">
            <div className="flex items-center gap-2 text-red-700">
              <Thermometer size={20} />
              <span className="font-semibold text-sm">Temperature</span>
            </div>
            <span className="text-xs text-red-600 bg-white px-2 py-1 rounded">Landsat 8/9</span>
          </div>
          <div className="text-3xl font-bold text-red-700">{nasaData.temperature.toFixed(1)}°C</div>
          <div className="text-xs text-red-600 mt-1">Surface temperature</div>
        </div>

        <div className="bg-gradient-to-br from-blue-50 to-cyan-50 p-4 rounded-xl border-2 border-blue-200">
          <div className="flex items-center justify-between mb-2">
            <div className="flex items-center gap-2 text-blue-700">
              <Droplet size={20} />
              <span className="font-semibold text-sm">Soil Moisture</span>
            </div>
            <span className="text-xs text-blue-600 bg-white px-2 py-1 rounded">SMAP</span>
          </div>
          <div className="text-3xl font-bold text-blue-700">{(nasaData.soilMoisture * 100).toFixed(0)}%</div>
          <div className="text-xs text-blue-600 mt-1">Depth: {getSoilMoistureDepth()}</div>
        </div>

        <div className="bg-gradient-to-br from-sky-50 to-blue-50 p-4 rounded-xl border-2 border-sky-200">
          <div className="flex items-center justify-between mb-2">
            <div className="flex items-center gap-2 text-sky-700">
              <CloudRain size={20} />
              <span className="font-semibold text-sm">Precipitation</span>
            </div>
            <span className="text-xs text-sky-600 bg-white px-2 py-1 rounded">GPM</span>
          </div>
          <div className="text-3xl font-bold text-sky-700">{nasaData.precipitation.toFixed(1)} mm</div>
          <div className="text-xs text-sky-600 mt-1">Last 24 hours</div>
        </div>

        <div className={`bg-gradient-to-br ${ndviInterpretation.bg} p-4 rounded-xl border-2 border-green-200`}>
          <div className="flex items-center justify-between mb-2">
            <div className="flex items-center gap-2 text-green-700">
              <Activity size={20} />
              <span className="font-semibold text-sm">NDVI</span>
            </div>
            <span className="text-xs text-green-600 bg-white px-2 py-1 rounded">MODIS</span>
          </div>
          <div className="flex items-center justify-between">
            <div className="text-3xl font-bold text-green-700">{nasaData.ndvi.toFixed(2)}</div>
            <span className={`${ndviInterpretation.color} font-bold text-sm`}>
              {ndviInterpretation.text}
            </span>
          </div>
          <div className="text-xs text-green-600 mt-1">Vegetation health index</div>
        </div>
      </div>

      <div className="mt-6 bg-blue-50 border-l-4 border-blue-500 p-4 rounded">
        <div className="flex items-center gap-2 mb-2">
          <span className="text-sm font-bold text-blue-800">📡 Data Resolution</span>
        </div>
        <div className="text-xs text-blue-700 mb-1">Spatial: {getResolutionInfo()}</div>
        <div className="text-xs text-blue-700">Temporal: Daily updates</div>
      </div>

      <div className="mt-6">
        <h4 className="font-bold text-gray-800 mb-3 flex items-center gap-2">
          <span>💡</span> AI Recommendations
        </h4>
        <div className="space-y-2">
          {getRecommendations().map((rec, i) => (
            <div key={i} className="text-sm bg-gray-50 p-3 rounded-lg border border-gray-200">
              {rec}
            </div>
          ))}
        </div>
      </div>

      <div className="mt-6 text-xs text-gray-500 bg-gray-50 p-3 rounded-lg">
        <div className="font-semibold mb-1">Data Sources:</div>
        <div>• Landsat 8/9: Surface temperature</div>
        <div>• SMAP: Soil moisture (0-10cm depth)</div>
        <div>• GPM: Precipitation measurements</div>
        <div>• MODIS: Normalized Difference Vegetation Index</div>
      </div>
    </div>
  );
}
