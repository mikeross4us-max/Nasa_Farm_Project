/*
  # Seed Quiz Questions - Part 4 (Innovative Farming)

  ## Overview
  Quiz questions for innovative farming subchapters.

  ## Subchapters Covered
  1. Hydroponics (10 questions)
  2. Aeroponics (10 questions)
  3. Vertical Farming (10 questions)
  4. Greenhouse Farming (10 questions)
*/

-- Hydroponics Questions
INSERT INTO questions (subchapter_id, question_type, question_text, question_data, points, difficulty, explanation, media_url)
SELECT 
  (SELECT id FROM subchapters WHERE title = 'Hydroponics' LIMIT 1),
  q.question_type,
  q.question_text,
  q.question_data::jsonb,
  q.points,
  q.difficulty,
  q.explanation,
  q.media_url
FROM (VALUES
  ('mcq', 'What is the NASA Veggie experiment on the ISS primarily testing?', '{"options": ["Growing vegetables in microgravity", "Making pizza", "Playing games", "Watching movies"], "correct": "Growing vegetables in microgravity"}', 10, 2, 'NASA Veggie is a plant growth facility on the ISS testing hydroponic crop production in microgravity to support long-duration space missions and develop technologies for Earth applications.', NULL),
  
  ('true_false', 'Hydroponic systems use approximately 90% less water than traditional soil-based agriculture.', '{"correct": true}', 10, 2, 'Hydroponics recirculates water in closed systems, drastically reducing consumption compared to soil farming where water is lost to evaporation, runoff, and deep percolation.', NULL),
  
  ('numeric', 'A hydroponic nutrient solution needs 200 ppm nitrogen. If 1 gram of fertilizer per liter provides 250 ppm, how many grams should be added to achieve 200 ppm per liter?', '{"correct": 0.8, "unit": "grams", "tolerance": 0.1}', 20, 4, 'Proportion: 1 g gives 250 ppm, so X g gives 200 ppm. X = (200/250) × 1 = 0.8 grams per liter needed.', NULL),
  
  ('mcq', 'What is the main advantage of hydroponics over soil cultivation?', '{"options": ["Uses more water", "Precise nutrient control and faster growth", "Requires more space", "Lower yields"], "correct": "Precise nutrient control and faster growth"}', 10, 2, 'Hydroponics allows precise nutrient delivery directly to roots, resulting in faster growth rates (up to 50% faster) and higher yields compared to soil-based methods.', NULL),
  
  ('free_text', 'Describe how NASA water recovery technology from the ISS benefits hydroponic farming systems.', '{"min_words": 20, "keywords": ["recycle", "water", "closed-loop", "efficient"]}', 20, 4, 'NASA''s ISS water recovery systems recycle nearly 100% of water through filtration and purification. This closed-loop technology has been adapted for hydroponic systems, enabling maximum water efficiency, reduced waste, and sustainable operation in water-scarce regions.', NULL),
  
  ('matching', 'Match hydroponic system types with their descriptions:', '{"pairs": [{"left": "Deep Water Culture", "right": "Roots suspended in oxygenated water"}, {"left": "Nutrient Film Technique", "right": "Thin film flows past roots"}, {"left": "Ebb and Flow", "right": "Periodic flooding and draining"}, {"left": "Drip System", "right": "Slow nutrient drip to plants"}], "correct": [["Deep Water Culture", "Roots suspended in oxygenated water"], ["Nutrient Film Technique", "Thin film flows past roots"], ["Ebb and Flow", "Periodic flooding and draining"], ["Drip System", "Slow nutrient drip to plants"]]}', 15, 3, 'Different hydroponic methods suit different crops and scales: DWC for leafy greens, NFT for continuous production, ebb-and-flow for flexibility, and drip systems for larger plants.', NULL),
  
  ('ordering', 'Arrange the steps to set up a basic hydroponic system:', '{"items": ["Choose appropriate growing container", "Install pump and aeration system", "Prepare nutrient solution", "Place plants in growing medium", "Monitor pH and nutrient levels"], "correct": ["Choose appropriate growing container", "Install pump and aeration system", "Prepare nutrient solution", "Place plants in growing medium", "Monitor pH and nutrient levels"]}', 15, 2, 'Hydroponic setup: select container, install water circulation and aeration, mix nutrient solution to specifications, establish plants in inert medium, and maintain optimal conditions through monitoring.', NULL),
  
  ('true_false', 'Hydroponically grown plants can be certified as organic in all countries.', '{"correct": false}', 10, 3, 'Organic certification for hydroponics is controversial and varies by country. Some jurisdictions don''t allow it since organic standards traditionally require soil, while others permit certified organic hydroponics.', NULL),
  
  ('mcq', 'What pH range is optimal for most hydroponic nutrient solutions?', '{"options": ["2.0-3.0", "5.5-6.5", "8.0-9.0", "11.0-12.0"], "correct": "5.5-6.5"}', 10, 3, 'Most hydroponic crops thrive at pH 5.5-6.5, where nutrient availability is optimal. Outside this range, nutrients can become locked out and unavailable to plants despite being present.', NULL),
  
  ('numeric', 'A hydroponic lettuce crop grows to harvest in 30 days, while soil-grown takes 45 days. What percentage faster is hydroponic growth?', '{"correct": 50, "unit": "percent", "tolerance": 5}', 15, 3, 'Time saved = 45 - 30 = 15 days. Percentage faster = (15/30) × 100 = 50% faster growth with hydroponics.', NULL)
) AS q(question_type, question_text, question_data, points, difficulty, explanation, media_url)
ON CONFLICT DO NOTHING;

-- Aeroponics Questions
INSERT INTO questions (subchapter_id, question_type, question_text, question_data, points, difficulty, explanation, media_url)
SELECT 
  (SELECT id FROM subchapters WHERE title = 'Aeroponics' LIMIT 1),
  q.question_type,
  q.question_text,
  q.question_data::jsonb,
  q.points,
  q.difficulty,
  q.explanation,
  q.media_url
FROM (VALUES
  ('mcq', 'NASA pioneered aeroponic technology primarily for which purpose?', '{"options": ["Making perfume", "Growing plants in space with minimal water", "Cooking food", "Entertainment"], "correct": "Growing plants in space with minimal water"}', 10, 2, 'NASA developed aeroponics in the 1990s to grow food on space stations with minimal water and maximum efficiency, a critical technology for long-duration space missions.', NULL),
  
  ('true_false', 'Aeroponics uses even less water than hydroponics, up to 95% less than traditional farming.', '{"correct": true}', 10, 2, 'Aeroponics is the most water-efficient cultivation method, using up to 95% less water than soil farming by misting roots with nutrient solution and recapturing excess in closed systems.', NULL),
  
  ('numeric', 'If aeroponic misting occurs for 5 seconds every 5 minutes, what percentage of time are roots being misted?', '{"correct": 1.67, "unit": "percent", "tolerance": 0.2}', 20, 4, 'In 5 minutes = 300 seconds, misting occurs for 5 seconds. Percentage = (5/300) × 100 = 1.67% of the time roots receive mist.', NULL),
  
  ('mcq', 'What is the primary advantage of aeroponics over hydroponics?', '{"options": ["Uses more water", "Maximum oxygen availability to roots", "Requires soil", "Slower growth"], "correct": "Maximum oxygen availability to roots"}', 10, 3, 'Suspended roots in air receive optimal oxygen exposure, promoting faster growth, healthier plants, and better nutrient uptake than any other method including hydroponics.', NULL),
  
  ('free_text', 'Explain how aeroponic systems could be advantageous for Mars colonization missions.', '{"min_words": 25, "keywords": ["water", "space", "efficient", "weight", "closed"]}', 20, 5, 'Aeroponics is ideal for Mars due to: extreme water efficiency (critical where water is precious), minimal system weight for transport, closed-loop operation preventing resource loss, rapid growth for food security, and easy monitoring of root health. The technology maximizes food production per unit of water and space.', NULL),
  
  ('matching', 'Match aeroponic system components with their functions:', '{"pairs": [{"left": "Misting nozzles", "right": "Deliver fine nutrient spray"}, {"left": "High-pressure pump", "right": "Generate fine mist droplets"}, {"left": "Root chamber", "right": "Enclosed dark space for roots"}, {"left": "Collection reservoir", "right": "Recapture unused solution"}], "correct": [["Misting nozzles", "Deliver fine nutrient spray"], ["High-pressure pump", "Generate fine mist droplets"], ["Root chamber", "Enclosed dark space for roots"], ["Collection reservoir", "Recapture unused solution"]]}', 15, 3, 'Aeroponic systems require: nozzles for uniform misting, high-pressure pumps (60-90 PSI) to atomize solution, dark chambers protecting roots from light, and reservoirs recycling solution.', NULL),
  
  ('ordering', 'Order the steps in an aeroponic misting cycle:', '{"items": ["Timer triggers misting sequence", "Pump pressurizes nutrient solution", "Fine mist sprays onto root zone", "Roots absorb nutrients and oxygen", "Excess solution drains back to reservoir"], "correct": ["Timer triggers misting sequence", "Pump pressurizes nutrient solution", "Fine mist sprays onto root zone", "Roots absorb nutrients and oxygen", "Excess solution drains back to reservoir"]}', 15, 3, 'Aeroponic cycles: timer initiates, pump creates high pressure, mist is released, roots take up nutrients while oxygenated, excess returns for reuse.', NULL),
  
  ('true_false', 'NASA aeroponic technology has been successfully commercialized and is used in agriculture worldwide.', '{"correct": true}', 10, 2, 'NASA-developed aeroponic technology has been licensed and adapted for commercial agriculture, indoor farming, and research, demonstrating successful technology transfer from space to Earth applications.', NULL),
  
  ('mcq', 'What droplet size range is ideal for aeroponic misting?', '{"options": ["1-5 millimeters", "50-100 micrometers", "1-2 centimeters", "500 millimeters"], "correct": "50-100 micrometers"}', 10, 4, 'Optimal aeroponic droplets are 50-100 micrometers (microns), small enough to stay suspended, large enough not to be inhaled by roots, and ideal for nutrient absorption.', NULL),
  
  ('numeric', 'An aeroponic system uses 10 liters of water daily for 100 plants. How many liters does traditional soil farming require for the same plants if it uses 20 times more water?', '{"correct": 200, "unit": "liters", "tolerance": 0}', 15, 2, 'Traditional water use = Aeroponic use × 20 = 10 L × 20 = 200 liters daily for the same 100 plants in soil.', NULL)
) AS q(question_type, question_text, question_data, points, difficulty, explanation, media_url)
ON CONFLICT DO NOTHING;

-- Vertical Farming Questions
INSERT INTO questions (subchapter_id, question_type, question_text, question_data, points, difficulty, explanation, media_url)
SELECT 
  (SELECT id FROM subchapters WHERE title = 'Vertical Farming' LIMIT 1),
  q.question_type,
  q.question_text,
  q.question_data::jsonb,
  q.points,
  q.difficulty,
  q.explanation,
  q.media_url
FROM (VALUES
  ('mcq', 'What NASA technology revolutionized vertical farming by enabling energy-efficient plant lighting?', '{"options": ["Nuclear reactors", "LED grow lights", "Candles", "Flashlights"], "correct": "LED grow lights"}', 10, 2, 'NASA developed specific LED light spectrums for optimal plant growth in space. This technology now powers vertical farms, reducing energy costs by 70% compared to traditional grow lights.', NULL),
  
  ('true_false', 'Vertical farms can produce crops year-round regardless of external weather conditions.', '{"correct": true}', 10, 1, 'Vertical farms operate in controlled indoor environments, allowing continuous production regardless of season, weather, or climate, ensuring consistent food supply.', NULL),
  
  ('numeric', 'A vertical farm with 10 growing levels produces 5 tons per level annually. A traditional farm produces 15 tons on the same floor space. How much more does the vertical farm produce?', '{"correct": 35, "unit": "tons", "tolerance": 0}', 15, 3, 'Vertical production = 10 levels × 5 tons = 50 tons. Traditional = 15 tons. Difference = 50 - 15 = 35 additional tons from vertical farming.', NULL),
  
  ('mcq', 'What is a primary challenge facing vertical farming adoption?', '{"options": ["Too much space available", "High energy costs for lighting and climate control", "Crops grow too fast", "Too much sunlight"], "correct": "High energy costs for lighting and climate control"}', 10, 3, 'Energy costs for LED lighting and HVAC systems are significant in vertical farming, though improving LED efficiency and renewable energy are making operations increasingly viable.', NULL),
  
  ('free_text', 'Describe how vertical farming addresses food security challenges in densely populated urban areas.', '{"min_words": 25, "keywords": ["local", "transport", "space", "fresh", "urban"]}', 20, 4, 'Vertical farming produces fresh food in urban centers, eliminating long transportation, reducing spoilage, and cutting carbon emissions. It maximizes production in limited space, provides year-round supply independent of weather, and brings agriculture closer to consumers, increasing food security and freshness.', NULL),
  
  ('matching', 'Match vertical farming advantages with their impacts:', '{"pairs": [{"left": "Space efficiency", "right": "More crops per square meter"}, {"left": "Water conservation", "right": "90% less water usage"}, {"left": "No pesticides", "right": "Controlled pest-free environment"}, {"left": "Local production", "right": "Reduced food miles"}], "correct": [["Space efficiency", "More crops per square meter"], ["Water conservation", "90% less water usage"], ["No pesticides", "Controlled pest-free environment"], ["Local production", "Reduced food miles"]]}', 15, 2, 'Vertical farming benefits include: vertical stacking multiplies growing area, closed systems recycle water, sealed environments eliminate pest pressure, and urban location shortens supply chains.', NULL),
  
  ('ordering', 'Arrange the steps to establish a vertical farm operation:', '{"items": ["Secure suitable building or warehouse space", "Install growing racks and infrastructure", "Set up LED lighting and climate systems", "Implement automated monitoring and control", "Begin crop production cycles"], "correct": ["Secure suitable building or warehouse space", "Install growing racks and infrastructure", "Set up LED lighting and climate systems", "Implement automated monitoring and control", "Begin crop production cycles"]}', 15, 3, 'Vertical farm development: acquire indoor space, build multi-level growing structures, install lighting and environmental controls, integrate automation systems, and start production.', NULL),
  
  ('true_false', 'NASA research on plant responses to different light wavelengths directly contributed to optimizing LED spectrums for vertical farms.', '{"correct": true}', 10, 2, 'NASA''s space agriculture research identified specific red and blue LED wavelengths most efficient for photosynthesis, knowledge that vertical farming industry adopted to minimize energy use while maximizing growth.', NULL),
  
  ('mcq', 'Which crops are most commonly grown in vertical farms?', '{"options": ["Wheat and corn", "Leafy greens and herbs", "Large trees", "Root vegetables only"], "correct": "Leafy greens and herbs"}', 10, 2, 'Vertical farms primarily grow leafy greens (lettuce, kale, arugula) and herbs due to their short growth cycles, high value, and suitability for stacked cultivation with limited height.', NULL),
  
  ('numeric', 'A vertical farm uses 50,000 kWh annually. If LED upgrades reduce consumption by 40%, how many kWh are saved?', '{"correct": 20000, "unit": "kWh", "tolerance": 0}', 15, 3, 'Energy saved = Original consumption × Reduction percentage = 50,000 kWh × 0.40 = 20,000 kWh saved annually with LED upgrades.', NULL)
) AS q(question_type, question_text, question_data, points, difficulty, explanation, media_url)
ON CONFLICT DO NOTHING;

-- Greenhouse Farming Questions
INSERT INTO questions (subchapter_id, question_type, question_text, question_data, points, difficulty, explanation, media_url)
SELECT 
  (SELECT id FROM subchapters WHERE title = 'Greenhouse Farming' LIMIT 1),
  q.question_type,
  q.question_text,
  q.question_data::jsonb,
  q.points,
  q.difficulty,
  q.explanation,
  q.media_url
FROM (VALUES
  ('mcq', 'Which NASA dataset helps greenhouse farmers optimize daily operations?', '{"options": ["Solar radiation data from POWER", "Video game scores", "Music playlists", "Movie ratings"], "correct": "Solar radiation data from POWER"}', 10, 3, 'NASA POWER (Prediction Of Worldwide Energy Resources) provides solar radiation, temperature, and other meteorological data helping greenhouse managers optimize heating, cooling, and shading.', NULL),
  
  ('true_false', 'Greenhouses extend growing seasons by creating controlled microclimates that protect plants from external weather.', '{"correct": true}', 10, 1, 'Greenhouses trap solar heat and shield crops from cold, wind, and excessive rain, enabling cultivation of warm-season crops year-round in temperate climates and season extension everywhere.', NULL),
  
  ('numeric', 'A greenhouse maintains 25°C inside while outside temperature is 5°C. What is the temperature difference being maintained (in °C)?', '{"correct": 20, "unit": "degrees Celsius", "tolerance": 0}', 15, 2, 'Temperature difference = Inside - Outside = 25°C - 5°C = 20°C maintained through greenhouse insulation and heating.', NULL),
  
  ('mcq', 'What is the "greenhouse effect" in agricultural greenhouses?', '{"options": ["Plants becoming sad", "Trapped solar radiation heating interior air", "Growing only green plants", "Using only green materials"], "correct": "Trapped solar radiation heating interior air"}', 10, 2, 'Transparent greenhouse materials allow sunlight in but trap resulting infrared heat radiation, warming the interior—the same principle as atmospheric greenhouse effect but utilized for agriculture.', NULL),
  
  ('free_text', 'Explain how NASA climate modeling and automation research benefits modern greenhouse management systems.', '{"min_words": 20, "keywords": ["sensors", "control", "climate", "automation", "efficient"]}', 20, 4, 'NASA climate modeling provides predictive data for greenhouse climate control. Space-developed automation technology enables sensor networks monitoring temperature, humidity, CO2, and light. Automated systems adjust ventilation, heating, shading, and irrigation in real-time, optimizing conditions while minimizing resource use and labor.', NULL),
  
  ('matching', 'Match greenhouse technologies with their purposes:', '{"pairs": [{"left": "Automated venting", "right": "Temperature and humidity control"}, {"left": "Shade screens", "right": "Prevent overheating and light stress"}, {"left": "CO2 enrichment", "right": "Enhance photosynthesis"}, {"left": "Drip irrigation", "right": "Precise water delivery"}], "correct": [["Automated venting", "Temperature and humidity control"], ["Shade screens", "Prevent overheating and light stress"], ["CO2 enrichment", "Enhance photosynthesis"], ["Drip irrigation", "Precise water delivery"]]}', 15, 3, 'Modern greenhouses use: automated vents managing climate, retractable shades controlling light and heat, CO2 injection boosting growth rates, and drip systems delivering water efficiently to each plant.', NULL),
  
  ('ordering', 'Order the daily management sequence for an automated greenhouse:', '{"items": ["Sensors measure environmental conditions", "Computer analyzes data vs. optimal ranges", "Automated systems adjust as needed", "Plants grow under optimized conditions", "System logs data for analysis"], "correct": ["Sensors measure environmental conditions", "Computer analyzes data vs. optimal ranges", "Automated systems adjust as needed", "Plants grow under optimized conditions", "System logs data for analysis"]}', 15, 3, 'Automated greenhouse operation: sensors continuously monitor conditions, control systems compare to setpoints, actuators adjust climate factors, plants thrive in optimal environment, data is recorded for optimization.', NULL),
  
  ('true_false', 'High-tech greenhouses can achieve yields 10-20 times higher per area than open-field cultivation.', '{"correct": true}', 10, 2, 'Modern controlled-environment greenhouses with optimal conditions, CO2 enrichment, precise fertigation, and extended growing seasons routinely achieve 10-20x yields compared to field production.', NULL),
  
  ('mcq', 'What is a major sustainability challenge for heated greenhouses?', '{"options": ["Too many butterflies", "High energy consumption for heating", "Plants growing too tall", "Too much oxygen production"], "correct": "High energy consumption for heating"}', 10, 3, 'Heating greenhouses in cold climates requires significant energy. Sustainable operations increasingly use geothermal heating, waste heat recovery, improved insulation, and renewable energy sources.', NULL),
  
  ('numeric', 'A greenhouse adds 800 ppm CO2 during peak photosynthesis hours. If ambient CO2 is 400 ppm, what is the total concentration (in ppm)?', '{"correct": 1200, "unit": "ppm", "tolerance": 0}', 15, 3, 'Total CO2 = Ambient + Added = 400 ppm + 800 ppm = 1200 ppm, which can increase photosynthesis rates by 20-50% in many crops.', NULL)
) AS q(question_type, question_text, question_data, points, difficulty, explanation, media_url)
ON CONFLICT DO NOTHING;