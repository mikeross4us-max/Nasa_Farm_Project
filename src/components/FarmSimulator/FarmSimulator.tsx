import { useState, useEffect } from 'react';
import { CloudRain, Droplet, Thermometer, Wind, Sprout, TreePine, Info } from 'lucide-react';
import { FarmField } from './FarmField';
import { NASADataPanel } from './NASADataPanel';
import { DecisionPanel } from './DecisionPanel';
import { TutorialModal } from './TutorialModal';

export interface NASAData {
  temperature: number;
  soilMoisture: number;
  precipitation: number;
  ndvi: number;
  season: string;
  date: string;
}

export interface FarmState {
  cropHealth: number;
  waterLevel: number;
  nutrients: number;
  money: number;
  day: number;
  season: string;
  cropType: string;
  cropGrowth: number;
  lastIrrigation: number;
  lastFertilization: number;
  weather: {
    current: string;
    forecast: string[];
  };
}

export function FarmSimulator() {
  const [showTutorial, setShowTutorial] = useState(true);
  const [farmState, setFarmState] = useState<FarmState>({
    cropHealth: 100,
    waterLevel: 60,
    nutrients: 70,
    money: 5000,
    day: 1,
    season: 'Spring',
    cropType: 'wheat',
    cropGrowth: 0,
    lastIrrigation: 0,
    lastFertilization: 0,
    weather: {
      current: 'Sunny',
      forecast: ['Partly Cloudy', 'Rainy', 'Sunny']
    }
  });

  const [nasaData, setNasaData] = useState<NASAData>({
    temperature: 22,
    soilMoisture: 0.3,
    precipitation: 2.5,
    ndvi: 0.6,
    season: 'Spring',
    date: new Date().toISOString().split('T')[0]
  });

  const [selectedDecision, setSelectedDecision] = useState<string | null>(null);
  const [notifications, setNotifications] = useState<string[]>([]);

  useEffect(() => {
    const interval = setInterval(() => {
      advanceDay();
    }, 5000);

    return () => clearInterval(interval);
  }, [farmState]);

  const advanceDay = () => {
    setFarmState(prev => {
      let newState = { ...prev, day: prev.day + 1 };

      newState.waterLevel = Math.max(0, prev.waterLevel - 5);
      newState.nutrients = Math.max(0, prev.nutrients - 3);

      if (prev.weather.current === 'Rainy') {
        newState.waterLevel = Math.min(100, prev.waterLevel + 20);
      }

      const healthPenalty =
        (newState.waterLevel < 30 ? 5 : 0) +
        (newState.nutrients < 30 ? 3 : 0);

      newState.cropHealth = Math.max(0, Math.min(100, prev.cropHealth - healthPenalty + 1));

      if (newState.cropHealth > 70 && newState.waterLevel > 40) {
        newState.cropGrowth = Math.min(100, prev.cropGrowth + 2);
      }

      updateNASAData(newState.day);

      if (newState.day % 30 === 0) {
        const seasons = ['Spring', 'Summer', 'Fall', 'Winter'];
        const currentIndex = seasons.indexOf(newState.season);
        newState.season = seasons[(currentIndex + 1) % 4];

        addNotification(`Season changed to ${newState.season}`);
      }

      if (newState.waterLevel < 30) {
        addNotification('Warning: Soil moisture critically low! Consider irrigation.');
      }

      if (newState.nutrients < 30) {
        addNotification('Alert: Nutrient levels depleted. Fertilization recommended.');
      }

      return newState;
    });
  };

  const updateNASAData = (day: number) => {
    setNasaData(prev => ({
      ...prev,
      temperature: 15 + Math.sin(day / 30) * 10 + (Math.random() - 0.5) * 3,
      soilMoisture: farmState.waterLevel / 200 + (Math.random() - 0.5) * 0.1,
      precipitation: Math.random() * 10,
      ndvi: Math.min(0.9, 0.3 + (farmState.cropGrowth / 100) * 0.6),
      date: new Date(Date.now() + day * 86400000).toISOString().split('T')[0]
    }));
  };

  const addNotification = (message: string) => {
    setNotifications(prev => [...prev.slice(-4), message]);
  };

  const handleIrrigate = (amount: 'light' | 'moderate' | 'heavy') => {
    const waterAmount = amount === 'light' ? 15 : amount === 'moderate' ? 30 : 50;
    const cost = amount === 'light' ? 50 : amount === 'moderate' ? 100 : 150;

    if (farmState.money >= cost) {
      setFarmState(prev => ({
        ...prev,
        waterLevel: Math.min(100, prev.waterLevel + waterAmount),
        money: prev.money - cost,
        lastIrrigation: 0
      }));
      addNotification(`Applied ${amount} irrigation (+${waterAmount}% water, -$${cost})`);
    } else {
      addNotification('Insufficient funds for irrigation!');
    }
  };

  const handleFertilize = (type: 'organic' | 'synthetic') => {
    const nutrientAmount = type === 'organic' ? 25 : 40;
    const cost = type === 'organic' ? 100 : 150;

    if (farmState.money >= cost) {
      setFarmState(prev => ({
        ...prev,
        nutrients: Math.min(100, prev.nutrients + nutrientAmount),
        money: prev.money - cost,
        lastFertilization: 0
      }));
      addNotification(`Applied ${type} fertilizer (+${nutrientAmount}% nutrients, -$${cost})`);
    } else {
      addNotification('Insufficient funds for fertilization!');
    }
  };

  const handleHarvest = () => {
    if (farmState.cropGrowth >= 80) {
      const yield_amount = (farmState.cropHealth / 100) * (farmState.cropGrowth / 100) * 1000;
      const revenue = Math.floor(yield_amount * 3);

      setFarmState(prev => ({
        ...prev,
        money: prev.money + revenue,
        cropGrowth: 0,
        cropHealth: 100,
        waterLevel: 60,
        nutrients: 70
      }));

      addNotification(`Harvested! Earned $${revenue} (Yield: ${yield_amount.toFixed(0)}kg)`);
    } else {
      addNotification('Crop not ready for harvest yet (needs 80% growth)');
    }
  };

  return (
    <div className="max-w-7xl mx-auto">
      <TutorialModal isOpen={showTutorial} onClose={() => setShowTutorial(false)} />

      <div className="bg-white rounded-2xl shadow-2xl p-6 mb-6">
        <div className="flex items-center justify-between mb-4">
          <div>
            <h2 className="text-3xl font-bold text-gray-800 flex items-center gap-2">
              <Gamepad2 className="text-green-600" />
              NASA Farm Simulator
            </h2>
            <p className="text-gray-600">Make data-driven farming decisions using real NASA satellite data</p>
          </div>
          <button
            onClick={() => setShowTutorial(true)}
            className="flex items-center gap-2 bg-blue-100 text-blue-700 px-4 py-2 rounded-lg hover:bg-blue-200 transition-colors"
          >
            <Info size={18} />
            Help
          </button>
        </div>

        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
          <div className="bg-gradient-to-br from-green-50 to-emerald-50 p-4 rounded-xl border-2 border-green-200">
            <div className="text-sm text-gray-600 mb-1">Money</div>
            <div className="text-2xl font-bold text-green-700">${farmState.money}</div>
          </div>
          <div className="bg-gradient-to-br from-blue-50 to-sky-50 p-4 rounded-xl border-2 border-blue-200">
            <div className="text-sm text-gray-600 mb-1">Day</div>
            <div className="text-2xl font-bold text-blue-700">{farmState.day}</div>
            <div className="text-xs text-blue-600">{farmState.season}</div>
          </div>
          <div className="bg-gradient-to-br from-purple-50 to-pink-50 p-4 rounded-xl border-2 border-purple-200">
            <div className="text-sm text-gray-600 mb-1">Crop Health</div>
            <div className="text-2xl font-bold text-purple-700">{farmState.cropHealth}%</div>
          </div>
          <div className="bg-gradient-to-br from-yellow-50 to-orange-50 p-4 rounded-xl border-2 border-yellow-200">
            <div className="text-sm text-gray-600 mb-1">Growth</div>
            <div className="text-2xl font-bold text-yellow-700">{farmState.cropGrowth}%</div>
          </div>
        </div>

        {notifications.length > 0 && (
          <div className="bg-yellow-50 border-l-4 border-yellow-400 p-4 mb-6 rounded">
            <div className="text-sm font-semibold text-yellow-800 mb-2">Recent Notifications</div>
            {notifications.map((notif, i) => (
              <div key={i} className="text-sm text-yellow-700">• {notif}</div>
            ))}
          </div>
        )}
      </div>

      <div className="grid lg:grid-cols-3 gap-6">
        <div className="lg:col-span-2">
          <FarmField farmState={farmState} />

          <DecisionPanel
            farmState={farmState}
            nasaData={nasaData}
            onIrrigate={handleIrrigate}
            onFertilize={handleFertilize}
            onHarvest={handleHarvest}
          />
        </div>

        <div>
          <NASADataPanel nasaData={nasaData} farmState={farmState} />
        </div>
      </div>
    </div>
  );
}
