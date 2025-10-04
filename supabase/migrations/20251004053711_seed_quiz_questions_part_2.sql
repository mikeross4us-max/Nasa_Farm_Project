/*
  # Seed Quiz Questions - Part 2 (Land-Based Farming Continued)

  ## Overview
  Continues quiz questions for remaining land-based farming subchapters.

  ## Subchapters Covered
  1. Shifting Cultivation (10 questions)
  2. Terrace Farming (10 questions)
*/

-- Shifting Cultivation Questions
INSERT INTO questions (subchapter_id, question_type, question_text, question_data, points, difficulty, explanation, media_url)
SELECT 
  (SELECT id FROM subchapters WHERE title = 'Shifting Cultivation' LIMIT 1),
  q.question_type,
  q.question_text,
  q.question_data::jsonb,
  q.points,
  q.difficulty,
  q.explanation,
  q.media_url
FROM (VALUES
  ('mcq', 'Which NASA system provides real-time fire detection data useful for monitoring shifting cultivation?', '{"options": ["FIRMS (Fire Information for Resource Management System)", "Netflix", "Spotify", "Twitter"], "correct": "FIRMS (Fire Information for Resource Management System)"}', 10, 2, 'FIRMS uses MODIS and VIIRS satellite data to detect active fires worldwide within hours, helping monitor agricultural burning in shifting cultivation systems.', NULL),
  
  ('true_false', 'Shifting cultivation, also known as slash-and-burn, always causes permanent forest destruction.', '{"correct": false}', 10, 3, 'When practiced traditionally with adequate fallow periods (10-20 years), shifting cultivation allows forest regeneration and can be sustainable. Problems arise when fallow periods shorten due to population pressure.', NULL),
  
  ('numeric', 'A traditional shifting cultivation system uses land for 2 years then allows 18 years fallow. What is the fallow-to-cultivation ratio?', '{"correct": 9, "unit": "ratio", "tolerance": 0}', 15, 3, 'Fallow ratio = Fallow years / Cultivation years = 18 / 2 = 9:1. This high ratio allows complete forest regeneration and soil recovery.', NULL),
  
  ('mcq', 'What is the primary ecological benefit of long fallow periods in shifting cultivation?', '{"options": ["Faster internet", "Soil nutrient and forest recovery", "More rain", "Better phone signal"], "correct": "Soil nutrient and forest recovery"}', 10, 2, 'Extended fallow periods allow soil nutrients to replenish through natural processes, vegetation to regrow, and biodiversity to recover, making the system sustainable.', NULL),
  
  ('free_text', 'Describe why shifting cultivation is becoming unsustainable in many regions and what NASA data reveals about this.', '{"min_words": 25, "keywords": ["population", "fallow", "deforestation", "satellite"]}', 20, 4, 'Population pressure reduces fallow periods, preventing soil recovery and forcing permanent deforestation. NASA satellite data (Landsat, MODIS) reveals shortened cycles through land cover change analysis, showing declining forest cover and increasing degradation over time in many shifting cultivation areas.', NULL),
  
  ('matching', 'Match each NASA dataset with its application in monitoring shifting cultivation:', '{"pairs": [{"left": "FIRMS fire data", "right": "Detect burning events"}, {"left": "Landsat imagery", "right": "Track land cover change"}, {"left": "GRACE water data", "right": "Monitor groundwater depletion"}, {"left": "Carbon monitoring", "right": "Assess emissions from burning"}], "correct": [["FIRMS fire data", "Detect burning events"], ["Landsat imagery", "Track land cover change"], ["GRACE water data", "Monitor groundwater depletion"], ["Carbon monitoring", "Assess emissions from burning"]]}', 15, 4, 'Multiple NASA tools monitor shifting cultivation: FIRMS for active fires, Landsat for deforestation tracking, GRACE for water impacts, and carbon satellites for emission assessment.', NULL),
  
  ('ordering', 'Arrange the traditional shifting cultivation cycle in order:', '{"items": ["Select forest plot", "Clear and burn vegetation", "Plant crops in ash-enriched soil", "Cultivate for 1-3 years", "Abandon plot for fallow regeneration"], "correct": ["Select forest plot", "Clear and burn vegetation", "Plant crops in ash-enriched soil", "Cultivate for 1-3 years", "Abandon plot for fallow regeneration"]}', 15, 2, 'Traditional shifting cultivation follows this cycle: selecting a forest plot, clearing and burning, planting in nutrient-rich ash, short-term cultivation, then abandonment for long-term forest regeneration.', NULL),
  
  ('true_false', 'NASA Earth Observatory provides before-and-after satellite images showing land use changes from shifting cultivation.', '{"correct": true}', 10, 2, 'NASA Earth Observatory regularly publishes satellite imagery documenting environmental changes, including deforestation and land use patterns from shifting cultivation worldwide.', NULL),
  
  ('mcq', 'Which region traditionally practiced sustainable shifting cultivation with long fallow periods?', '{"options": ["Amazon rainforest", "Sahara desert", "Antarctica", "Atlantic Ocean"], "correct": "Amazon rainforest"}', 10, 3, 'Indigenous Amazonian communities traditionally practiced sustainable shifting cultivation with 15-20 year fallow periods, maintaining forest ecosystem integrity for centuries.', NULL),
  
  ('numeric', 'If a shifting cultivation area burns 500 hectares of forest annually and each hectare releases 200 tons of CO2, what are the annual emissions (in tons)?', '{"correct": 100000, "unit": "tons CO2", "tolerance": 0}', 15, 4, 'Total emissions = Area × Emissions per hectare = 500 hectares × 200 tons CO2/hectare = 100,000 tons of CO2 released annually from burning.', NULL)
) AS q(question_type, question_text, question_data, points, difficulty, explanation, media_url)
ON CONFLICT DO NOTHING;

-- Terrace Farming Questions
INSERT INTO questions (subchapter_id, question_type, question_text, question_data, points, difficulty, explanation, media_url)
SELECT 
  (SELECT id FROM subchapters WHERE title = 'Terrace Farming' LIMIT 1),
  q.question_type,
  q.question_text,
  q.question_data::jsonb,
  q.points,
  q.difficulty,
  q.explanation,
  q.media_url
FROM (VALUES
  ('mcq', 'Which NASA dataset provides digital elevation models (DEMs) essential for planning terrace farms?', '{"options": ["SRTM (Shuttle Radar Topography Mission)", "Spotify Premium", "Google Docs", "Facebook"], "correct": "SRTM (Shuttle Radar Topography Mission)"}', 10, 2, 'SRTM provides high-resolution elevation data covering most of Earth, crucial for analyzing slope, designing terraces, and modeling water flow and erosion risk.', NULL),
  
  ('true_false', 'Terrace farming on steep slopes reduces soil erosion and water runoff.', '{"correct": true}', 10, 1, 'Terraces create level platforms that slow water flow, reduce erosion, increase water infiltration, and allow farming on slopes that would otherwise be impossible to cultivate.', NULL),
  
  ('numeric', 'A hillside has a 30-degree slope. If terrace walls are 2 meters high, approximately how much horizontal distance does each terrace level cover? (Use: horizontal ≈ height/tan(angle), tan(30°) ≈ 0.577)', '{"correct": 3.5, "unit": "meters", "tolerance": 0.5}', 20, 5, 'Horizontal distance = height / tan(angle) = 2m / 0.577 ≈ 3.5 meters. This calculation helps engineers design appropriate terrace dimensions for different slopes.', NULL),
  
  ('mcq', 'What ancient civilization is famous for extensive terrace farming systems still used today?', '{"options": ["Ancient Rome", "Inca Empire", "Vikings", "Ancient Egypt"], "correct": "Inca Empire"}', 10, 2, 'The Inca developed sophisticated terrace systems in the Andes Mountains, some still functional after 500+ years, demonstrating remarkable engineering and agricultural knowledge.', NULL),
  
  ('free_text', 'Explain how terrace farming helps with water management on hillsides and prevents landslides.', '{"min_words": 25, "keywords": ["water", "infiltration", "runoff", "erosion", "stability"]}', 20, 4, 'Terraces slow water runoff, increasing infiltration time and reducing erosion. Level platforms prevent water from gaining erosive velocity down slopes. Retained soil moisture supports vegetation whose roots stabilize hillsides. This reduces landslide risk and conserves water for crops.', NULL),
  
  ('matching', 'Match terrace farming benefits with their explanations:', '{"pairs": [{"left": "Erosion control", "right": "Reduces soil loss from slopes"}, {"left": "Water conservation", "right": "Increases infiltration time"}, {"left": "Cultivable area", "right": "Makes steep land farmable"}, {"left": "Microclimate", "right": "Creates varied growing conditions"}], "correct": [["Erosion control", "Reduces soil loss from slopes"], ["Water conservation", "Increases infiltration time"], ["Cultivable area", "Makes steep land farmable"], ["Microclimate", "Creates varied growing conditions"]]}', 15, 3, 'Terraces provide multiple benefits: preventing erosion by breaking slope length, conserving water through slower runoff, expanding farmland to steep areas, and creating diverse microclimates at different elevations.', NULL),
  
  ('ordering', 'Arrange these steps in terrace construction sequence:', '{"items": ["Survey slope and plan terrace layout", "Mark contour lines at equal elevations", "Excavate and build retention walls", "Level terrace platforms", "Install drainage and irrigation systems"], "correct": ["Survey slope and plan terrace layout", "Mark contour lines at equal elevations", "Excavate and build retention walls", "Level terrace platforms", "Install drainage and irrigation systems"]}', 15, 3, 'Proper terrace construction starts with surveying and planning, marking contours, building sturdy walls, leveling platforms, and finally installing water management systems.', NULL),
  
  ('true_false', 'NASA ASTER GDEM (Advanced Spaceborne Thermal Emission and Reflection Radiometer Global Digital Elevation Model) provides free global elevation data useful for terrace planning.', '{"correct": true}', 10, 3, 'ASTER GDEM provides free 30-meter resolution elevation data covering 99% of Earth''s surface, invaluable for agricultural planning, especially terrace design and erosion modeling.', NULL),
  
  ('mcq', 'What is the primary purpose of retention walls in terrace farming?', '{"options": ["Decoration", "Hold soil and prevent collapse", "Provide shade", "Attract tourists"], "correct": "Hold soil and prevent collapse"}', 10, 1, 'Retention walls are structural elements that hold back soil on the terrace platform, preventing erosion and collapse while creating level growing surfaces on slopes.', NULL),
  
  ('numeric', 'A 100-meter hillside slope is converted to terraces 2.5 meters wide each. How many terrace levels are created?', '{"correct": 40, "unit": "terraces", "tolerance": 0}', 15, 2, 'Number of terraces = Total slope length / Terrace width = 100m / 2.5m = 40 terrace levels along the hillside.', NULL)
) AS q(question_type, question_text, question_data, points, difficulty, explanation, media_url)
ON CONFLICT DO NOTHING;