/*
  # Seed Quiz Questions - Part 5 (Space Farming)

  ## Overview
  Quiz questions for all space farming subchapters.

  ## Subchapters Covered
  1. Space Station Farming (10 questions)
  2. Urban Farming (10 questions)
  3. Aerial Farming (10 questions)
*/

-- Space Station Farming Questions
INSERT INTO questions (subchapter_id, question_type, question_text, question_data, points, difficulty, explanation, media_url)
SELECT 
  (SELECT id FROM subchapters WHERE title = 'Space Station Farming' LIMIT 1),
  q.question_type,
  q.question_text,
  q.question_data::jsonb,
  q.points,
  q.difficulty,
  q.explanation,
  q.media_url
FROM (VALUES
  ('mcq', 'What is the primary NASA facility for growing plants on the ISS?', '{"options": ["Veggie Plant Growth System", "Space Kitchen", "Star Garden", "Cosmic Farm"], "correct": "Veggie Plant Growth System"}', 10, 2, 'Veggie is NASA''s plant growth facility on the ISS, using LED lights and rooting pillows to grow fresh vegetables for astronauts and conduct research for future missions.', NULL),
  
  ('true_false', 'Plants have been successfully grown from seed to seed (completing full life cycles) in space.', '{"correct": true}', 10, 3, 'Multiple plant species have completed full life cycles in microgravity on the ISS, including Arabidopsis, wheat, and lettuce, proving space agriculture viability for long missions.', NULL),
  
  ('numeric', 'If the ISS orbits Earth 16 times per day, how many "day-night" cycles do ISS plants experience daily?', '{"correct": 16, "unit": "cycles", "tolerance": 0}', 15, 3, 'Plants aboard the ISS experience 16 rapid day-night cycles (one per orbit) requiring artificial LED lighting on controlled schedules to maintain normal circadian rhythms.', NULL),
  
  ('mcq', 'What major challenge do plants face growing in microgravity?', '{"options": ["Too much gravity", "No gravity-directed root and shoot orientation", "Too much soil", "Excess rain"], "correct": "No gravity-directed root and shoot orientation"}', 10, 3, 'Without gravity, plants lack gravitropism cues for root/shoot direction. Special systems provide directional cues, and plants adapt by using light and moisture gradients instead.', NULL),
  
  ('free_text', 'Explain why growing food in space is critical for Mars missions and long-duration space exploration.', '{"min_words": 25, "keywords": ["distance", "fresh", "resupply", "psychological", "sustainability"]}', 20, 4, 'Mars missions require 2-3 years with no resupply possibility. Growing fresh food provides essential nutrients, reduces payload mass, ensures sustainability, improves psychological well-being through gardening, and validates closed-loop life support systems necessary for permanent space settlements.', NULL),
  
  ('matching', 'Match space farming challenges with their solutions:', '{"pairs": [{"left": "Microgravity", "right": "Specialized root chambers with moisture control"}, {"left": "Limited space", "right": "Compact LED-lit growing systems"}, {"left": "Water management", "right": "Enclosed systems with careful irrigation"}, {"left": "No wind for pollination", "right": "Manual or mechanical pollination"}], "correct": [["Microgravity", "Specialized root chambers with moisture control"], ["Limited space", "Compact LED-lit growing systems"], ["Water management", "Enclosed systems with careful irrigation"], ["No wind for pollination", "Manual or mechanical pollination"]]}', 15, 4, 'Space farming requires: root chambers controlling water distribution in zero-g, compact LED systems maximizing limited space, careful water containment preventing floating droplets, and assisted pollination without air movement.', NULL),
  
  ('ordering', 'Order the steps for conducting a plant growth experiment on the ISS:', '{"items": ["Prepare growing chambers with seeds and medium", "Launch to ISS aboard resupply vehicle", "Activate growth system with LED lights", "Monitor and document growth daily", "Harvest and return samples to Earth"], "correct": ["Prepare growing chambers with seeds and medium", "Launch to ISS aboard resupply vehicle", "Activate growth system with LED lights", "Monitor and document growth daily", "Harvest and return samples to Earth"]}', 15, 3, 'Space agriculture experiments: prepare chambers on Earth, launch via cargo spacecraft, activate aboard ISS, continuously monitor and photograph, harvest and return samples for detailed analysis.', NULL),
  
  ('true_false', 'NASA Advanced Plant Habitat on the ISS is a fully automated plant growth system that requires minimal astronaut intervention.', '{"correct": true}', 10, 3, 'The Advanced Plant Habitat (APH) is a highly automated system with controlled temperature, humidity, CO2, and irrigation, allowing extensive experiments with minimal crew time requirements.', NULL),
  
  ('mcq', 'Which crop has been most successfully grown and consumed by astronauts on the ISS?', '{"options": ["Corn", "Lettuce", "Watermelon", "Pumpkin"], "correct": "Lettuce"}', 10, 2, 'Red romaine lettuce ("Outredgeous") has been successfully grown multiple times in Veggie and eaten fresh by ISS crews, marking important milestones in space food production.', NULL),
  
  ('numeric', 'If a Mars mission lasts 900 days and astronauts need 500g of fresh food daily per person, how many kg are needed for a 4-person crew?', '{"correct": 1800, "unit": "kg", "tolerance": 0}', 20, 4, 'Total food = Days × People × Daily amount = 900 × 4 × 0.5 kg = 1,800 kg of fresh produce needed, demonstrating necessity of in-situ food production.', NULL)
) AS q(question_type, question_text, question_data, points, difficulty, explanation, media_url)
ON CONFLICT DO NOTHING;

-- Urban Farming Questions
INSERT INTO questions (subchapter_id, question_type, question_text, question_data, points, difficulty, explanation, media_url)
SELECT 
  (SELECT id FROM subchapters WHERE title = 'Urban Farming' LIMIT 1),
  q.question_type,
  q.question_text,
  q.question_data::jsonb,
  q.points,
  q.difficulty,
  q.explanation,
  q.media_url
FROM (VALUES
  ('mcq', 'How does NASA satellite data help identify suitable urban farming locations?', '{"options": ["By measuring coffee shop density", "By mapping heat islands and available rooftop space", "By counting cars", "By tracking social media"], "correct": "By mapping heat islands and available rooftop space"}', 10, 3, 'NASA thermal and high-resolution satellite imagery maps urban heat islands, identifies suitable rooftop areas, assesses air quality, and helps optimize urban agriculture site selection.', NULL),
  
  ('true_false', 'Urban farming can reduce urban heat island effects by providing cooling through evapotranspiration.', '{"correct": true}', 10, 2, 'Urban farms and rooftop gardens cool cities through plant evapotranspiration, reduce heat-absorbing surfaces, improve air quality, and decrease building cooling needs.', NULL),
  
  ('numeric', 'A city block has 20 buildings with average 500 m² rooftop space each. If 60% is suitable for farming, what is the total farming area (in m²)?', '{"correct": 6000, "unit": "square meters", "tolerance": 0}', 15, 3, 'Total rooftop = 20 buildings × 500 m² = 10,000 m². Suitable area = 10,000 × 0.60 = 6,000 m² available for urban agriculture.', NULL),
  
  ('mcq', 'What is a primary benefit of urban farming for cities?', '{"options": ["Increases traffic congestion", "Reduces food transportation distance and emissions", "Makes cities hotter", "Uses more water"], "correct": "Reduces food transportation distance and emissions"}', 10, 2, 'Urban farming shortens food supply chains dramatically, reducing transportation emissions, ensuring freshness, creating local employment, and improving food security in dense areas.', NULL),
  
  ('free_text', 'Describe how NASA Earth observation data supports urban agriculture planning and addresses food deserts.', '{"min_words": 25, "keywords": ["mapping", "access", "poverty", "distribution", "satellite"]}', 20, 4, 'NASA satellite data combined with socioeconomic information identifies food deserts—areas lacking fresh food access. High-resolution imagery maps potential urban farming sites (vacant lots, rooftops), while land surface data assesses conditions. This guides targeted urban agriculture programs where they''re most needed.', NULL),
  
  ('matching', 'Match urban farming methods with their characteristics:', '{"pairs": [{"left": "Rooftop gardens", "right": "Utilize underused building tops"}, {"left": "Community gardens", "right": "Shared plots for residents"}, {"left": "Vertical walls", "right": "Growing on building facades"}, {"left": "Vacant lot conversion", "right": "Reclaim abandoned urban space"}], "correct": [["Rooftop gardens", "Utilize underused building tops"], ["Community gardens", "Shared plots for residents"], ["Vertical walls", "Growing on building facades"], ["Vacant lot conversion", "Reclaim abandoned urban space"]]}', 15, 2, 'Urban farming takes various forms: rooftops maximize vertical space, community gardens build social connections, living walls beautify buildings while producing food, and vacant lots transform blight into productivity.', NULL),
  
  ('ordering', 'Arrange the steps to establish a community urban farm:', '{"items": ["Identify and secure urban land or space", "Test soil and remediate if contaminated", "Design layout and growing systems", "Engage community and recruit participants", "Begin planting and establish maintenance schedule"], "correct": ["Identify and secure urban land or space", "Test soil and remediate if contaminated", "Design layout and growing systems", "Engage community and recruit participants", "Begin planting and establish maintenance schedule"]}', 15, 3, 'Urban farm establishment: secure land access, assess and treat soil contamination (common in cities), plan efficient layouts, build community involvement, and start sustainable production cycles.', NULL),
  
  ('true_false', 'NASA SEDAC (Socioeconomic Data and Applications Center) provides data linking satellite observations with population demographics useful for urban farming planning.', '{"correct": true}', 10, 3, 'SEDAC integrates Earth science with socioeconomic data, providing tools to analyze urban agriculture potential, food access, environmental justice, and sustainable development.', NULL),
  
  ('mcq', 'Which urban farming challenge is addressed by using NASA air quality monitoring data?', '{"options": ["Plant boredom", "Pollution exposure affecting food safety", "Too much sunshine", "Excessive rain"], "correct": "Pollution exposure affecting food safety"}', 10, 3, 'NASA air quality sensors (like TEMPO and AIRS) detect pollutants that could accumulate in urban crops, helping farmers choose safe locations and implement protective measures.', NULL),
  
  ('numeric', 'An urban farm produces 8 kg of vegetables per square meter annually. A 250 m² rooftop farm supplies how many kg yearly?', '{"correct": 2000, "unit": "kg", "tolerance": 0}', 15, 2, 'Annual production = Area × Yield = 250 m² × 8 kg/m² = 2,000 kg of fresh vegetables produced from a single rooftop.', NULL)
) AS q(question_type, question_text, question_data, points, difficulty, explanation, media_url)
ON CONFLICT DO NOTHING;

-- Aerial Farming Questions
INSERT INTO questions (subchapter_id, question_type, question_text, question_data, points, difficulty, explanation, media_url)
SELECT 
  (SELECT id FROM subchapters WHERE title = 'Aerial Farming' LIMIT 1),
  q.question_type,
  q.question_text,
  q.question_data::jsonb,
  q.points,
  q.difficulty,
  q.explanation,
  q.media_url
FROM (VALUES
  ('mcq', 'What NASA technology area contributes to agricultural drone development?', '{"options": ["Pizza delivery", "Autonomous systems and UAS research", "Video games", "Music production"], "correct": "Autonomous systems and UAS research"}', 10, 2, 'NASA Unmanned Aircraft Systems (UAS) research develops autonomous navigation, sense-and-avoid technology, and AI systems that enable agricultural drones to operate safely and efficiently.', NULL),
  
  ('true_false', 'Agricultural drones can detect crop stress and disease before visible symptoms appear using multispectral cameras.', '{"correct": true}', 10, 3, 'Drones equipped with multispectral or hyperspectral cameras detect subtle changes in plant reflectance indicating stress, nutrient deficiency, or disease days before symptoms become visible to humans.', NULL),
  
  ('numeric', 'A drone covers 10 hectares per hour. How many hours are needed to survey a 250-hectare farm?', '{"correct": 25, "unit": "hours", "tolerance": 0}', 15, 2, 'Survey time = Total area / Coverage rate = 250 hectares / 10 hectares per hour = 25 hours of flight time needed.', NULL),
  
  ('mcq', 'What precision agriculture application do drones excel at?', '{"options": ["Making coffee", "Variable-rate application mapping and spot treatment", "Washing dishes", "Playing music"], "correct": "Variable-rate application mapping and spot treatment"}', 10, 3, 'Drones create high-resolution maps showing within-field variability, enabling precise, site-specific input application only where needed, reducing costs and environmental impact.', NULL),
  
  ('free_text', 'Explain how NASA computer vision and AI technology benefits drone-based crop monitoring and decision-making.', '{"min_words": 25, "keywords": ["image", "analysis", "detection", "automated", "patterns"]}', 20, 4, 'NASA AI and computer vision algorithms automatically analyze drone imagery, detecting patterns indicating pest infestations, disease, water stress, or nutrient deficiencies. Machine learning trained on millions of images provides instant automated insights, making precision agriculture accessible and actionable for farmers in real-time.', NULL),
  
  ('matching', 'Match drone sensors with their agricultural applications:', '{"pairs": [{"left": "RGB cameras", "right": "Visual documentation and scouting"}, {"left": "Multispectral sensors", "right": "Vegetation health indices (NDVI)"}, {"left": "Thermal cameras", "right": "Water stress and irrigation needs"}, {"left": "LiDAR", "right": "Canopy height and 3D structure"}], "correct": [["RGB cameras", "Visual documentation and scouting"], ["Multispectral sensors", "Vegetation health indices (NDVI)"], ["Thermal cameras", "Water stress and irrigation needs"], ["LiDAR", "Canopy height and 3D structure"]]}', 15, 4, 'Different drone sensors serve specific purposes: RGB for visible assessment, multispectral for health analysis, thermal for water stress detection, and LiDAR for structural measurements and biomass estimation.', NULL),
  
  ('ordering', 'Order the workflow for drone-based precision agriculture:', '{"items": ["Plan flight path and mission parameters", "Drone autonomously surveys field", "Collect multispectral and GPS-tagged images", "Process data into actionable maps", "Implement variable-rate treatments based on maps"], "correct": ["Plan flight path and mission parameters", "Drone autonomously surveys field", "Collect multispectral and GPS-tagged images", "Process data into actionable maps", "Implement variable-rate treatments based on maps"]}', 15, 3, 'Precision ag workflow: plan coverage, execute autonomous flight, gather georeferenced data, analyze to create prescription maps, and apply targeted interventions only where needed.', NULL),
  
  ('true_false', 'NASA airborne science missions test sensors and algorithms that are later adapted for agricultural drone applications.', '{"correct": true}', 10, 3, 'NASA aircraft carry prototype sensors and test advanced algorithms for Earth observation. Many of these technologies are miniaturized and adapted for agricultural drones, democratizing access to space-age monitoring.', NULL),
  
  ('mcq', 'What advantage do drones have over satellites for farm monitoring?', '{"options": ["Can fly to Mars", "Higher resolution and on-demand timing", "More expensive", "Slower data collection"], "correct": "Higher resolution and on-demand timing"}', 10, 2, 'Drones provide centimeter-level resolution images on-demand, operating below clouds and on farmer schedules, complementing satellite data with detailed, timely field-specific information.', NULL),
  
  ('numeric', 'A drone multispectral camera costs $5,000 and saves $50 per hectare annually through optimized inputs. For a 200-hectare farm, what is the payback period (in years)?', '{"correct": 0.5, "unit": "years", "tolerance": 0.1}', 20, 4, 'Annual savings = $50/hectare × 200 hectares = $10,000. Payback = Cost / Savings = $5,000 / $10,000 = 0.5 years (6 months) return on investment.', NULL)
) AS q(question_type, question_text, question_data, points, difficulty, explanation, media_url)
ON CONFLICT DO NOTHING;

SELECT 'All quiz questions seeded successfully - 160 total questions across 16 subchapters' as status;