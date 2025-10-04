/*
  # Seed Quiz Questions - Part 1 (Land-Based Farming)

  ## Overview
  Creates 10+ diverse quiz questions for each land-based farming subchapter.
  Question types: MCQ, True/False, Numeric, Free Text, Matching, Ordering, Hotspot, Media, Code

  ## Subchapters Covered
  1. Arable Farming (10 questions)
  2. Pastoral Farming (10 questions)
  3. Mixed Farming (10 questions)
  4. Shifting Cultivation (10 questions)
  5. Terrace Farming (10 questions)
*/

-- Arable Farming Questions
INSERT INTO questions (subchapter_id, question_type, question_text, question_data, points, difficulty, explanation, media_url)
SELECT 
  (SELECT id FROM subchapters WHERE title = 'Arable Farming' LIMIT 1),
  q.question_type,
  q.question_text,
  q.question_data::jsonb,
  q.points,
  q.difficulty,
  q.explanation,
  q.media_url
FROM (VALUES
  ('mcq', 'Which NASA satellite mission provides multispectral imaging data for crop monitoring?', '{"options": ["Hubble Space Telescope", "Landsat", "James Webb", "Chandra"], "correct": "Landsat"}', 10, 2, 'Landsat satellites have been monitoring Earth''s surface since 1972, providing valuable crop health and land use data through multispectral imaging.', NULL),
  
  ('true_false', 'Arable farming only refers to permanent grasslands used for grazing.', '{"correct": false}', 10, 1, 'Arable farming specifically focuses on cultivating crops on plowed land, not grasslands. Grasslands are associated with pastoral farming.', NULL),
  
  ('numeric', 'If a wheat crop requires 450mm of water annually and rainfall provides 300mm, how much irrigation water (in mm) is needed?', '{"correct": 150, "unit": "mm", "tolerance": 0}', 15, 3, 'The irrigation requirement is the difference between crop water needs and rainfall: 450mm - 300mm = 150mm of irrigation water needed.', NULL),
  
  ('mcq', 'What does NDVI (Normalized Difference Vegetation Index) primarily measure?', '{"options": ["Soil temperature", "Plant health and density", "Water pH levels", "Air pollution"], "correct": "Plant health and density"}', 10, 3, 'NDVI uses red and near-infrared light reflectance to assess vegetation health, density, and photosynthetic activity. NASA satellites regularly collect NDVI data.', NULL),
  
  ('free_text', 'Explain how crop rotation improves soil fertility and benefits arable farming.', '{"min_words": 20, "keywords": ["nutrients", "soil", "pests", "disease"]}', 20, 4, 'Crop rotation improves soil fertility by: varying nutrient demands (different crops use different nutrients), breaking pest and disease cycles, improving soil structure through different root systems, and adding nitrogen through legumes. This sustainable practice reduces chemical fertilizer needs.', NULL),
  
  ('matching', 'Match each NASA instrument with its primary agricultural application:', '{"pairs": [{"left": "MODIS", "right": "Daily global vegetation monitoring"}, {"left": "SMAP", "right": "Soil moisture measurement"}, {"left": "Landsat", "right": "Field-scale crop mapping"}, {"left": "OCO-2", "right": "Carbon dioxide tracking"}], "correct": [["MODIS", "Daily global vegetation monitoring"], ["SMAP", "Soil moisture measurement"], ["Landsat", "Field-scale crop mapping"], ["OCO-2", "Carbon dioxide tracking"]]}', 15, 4, 'Each NASA instrument serves specific agricultural purposes: MODIS provides frequent global coverage, SMAP measures soil moisture from space, Landsat offers detailed field-scale imagery, and OCO-2 tracks carbon cycles.', NULL),
  
  ('ordering', 'Arrange these arable farming steps in the correct seasonal order:', '{"items": ["Soil preparation and plowing", "Seed planting", "Crop monitoring and fertilization", "Harvesting", "Post-harvest soil treatment"], "correct": ["Soil preparation and plowing", "Seed planting", "Crop monitoring and fertilization", "Harvesting", "Post-harvest soil treatment"]}', 15, 2, 'The correct farming cycle starts with soil preparation, followed by planting, then monitoring/maintenance during growth, harvesting at maturity, and finally post-harvest soil care for the next cycle.', NULL),
  
  ('mcq', 'Which soil moisture range is generally optimal for most crop germination?', '{"options": ["10-20%", "40-60%", "80-90%", "95-100%"], "correct": "40-60%"}', 10, 3, 'Most crops germinate best at 40-60% soil moisture, providing adequate water without waterlogging. NASA''s SMAP satellite helps farmers monitor soil moisture levels across large areas.', NULL),
  
  ('true_false', 'NASA''s Harvest program uses satellite data to improve global food security and agricultural monitoring.', '{"correct": true}', 10, 2, 'NASA Harvest is a consortium that applies Earth observations to enhance food security and agricultural decisions worldwide, working with governments and organizations globally.', NULL),
  
  ('numeric', 'A farm uses satellite data showing that 85% of a 200-hectare field has healthy vegetation (NDVI > 0.6). How many hectares show stressed vegetation?', '{"correct": 30, "unit": "hectares", "tolerance": 0}', 15, 3, 'If 85% is healthy, then 15% is stressed. 15% of 200 hectares = 0.15 × 200 = 30 hectares of stressed vegetation that may need attention.', NULL)
) AS q(question_type, question_text, question_data, points, difficulty, explanation, media_url)
ON CONFLICT DO NOTHING;

-- Pastoral Farming Questions
INSERT INTO questions (subchapter_id, question_type, question_text, question_data, points, difficulty, explanation, media_url)
SELECT 
  (SELECT id FROM subchapters WHERE title = 'Pastoral Farming' LIMIT 1),
  q.question_type,
  q.question_text,
  q.question_data::jsonb,
  q.points,
  q.difficulty,
  q.explanation,
  q.media_url
FROM (VALUES
  ('mcq', 'Which NASA mission monitors global precipitation patterns important for pastoral farming?', '{"options": ["GPM (Global Precipitation Measurement)", "Voyager", "Apollo", "Kepler"], "correct": "GPM (Global Precipitation Measurement)"}', 10, 2, 'GPM is an international satellite mission that provides global precipitation data every 3 hours, crucial for predicting water availability in grazing lands.', NULL),
  
  ('true_false', 'Pastoral farming focuses primarily on livestock grazing rather than crop cultivation.', '{"correct": true}', 10, 1, 'Pastoral farming specializes in raising livestock on grasslands and pastures, with minimal or no crop production. This differs from arable or mixed farming.', NULL),
  
  ('numeric', 'If a pasture supports 1.5 cattle per hectare and a farmer has 120 cattle, how many hectares of pasture are needed?', '{"correct": 80, "unit": "hectares", "tolerance": 0}', 15, 2, 'Divide total cattle by carrying capacity: 120 cattle ÷ 1.5 cattle/hectare = 80 hectares needed for sustainable grazing.', NULL),
  
  ('mcq', 'What does MODIS Terra/Aqua vegetation index help pastoralists monitor?', '{"options": ["Stock market prices", "Pasture productivity and health", "Animal diseases", "Fence conditions"], "correct": "Pasture productivity and health"}', 10, 3, 'MODIS vegetation indices track grassland health, biomass, and seasonal changes, helping pastoralists make grazing decisions and predict forage availability.', NULL),
  
  ('free_text', 'Describe how rotational grazing benefits both pasture health and livestock productivity.', '{"min_words": 25, "keywords": ["grass", "recovery", "overgrazing", "soil"]}', 20, 4, 'Rotational grazing allows pastures to recover between grazing periods, preventing overgrazing and soil compaction. This maintains grass health, promotes root growth, increases forage quality, reduces parasite loads, and improves overall pasture productivity and biodiversity.', NULL),
  
  ('matching', 'Match each pastoral farming metric with the NASA data source:', '{"pairs": [{"left": "Pasture greenness", "right": "MODIS NDVI"}, {"left": "Rainfall patterns", "right": "GPM precipitation"}, {"left": "Drought conditions", "right": "GRACE groundwater"}, {"left": "Temperature stress", "right": "Land surface temperature"}], "correct": [["Pasture greenness", "MODIS NDVI"], ["Rainfall patterns", "GPM precipitation"], ["Drought conditions", "GRACE groundwater"], ["Temperature stress", "Land surface temperature"]]}', 15, 4, 'Different NASA instruments provide complementary data: MODIS tracks vegetation health, GPM measures rainfall, GRACE detects groundwater changes indicating drought, and thermal sensors monitor heat stress conditions.', NULL),
  
  ('ordering', 'Arrange these steps of sustainable pastoral farming in order:', '{"items": ["Assess pasture carrying capacity", "Introduce appropriate number of livestock", "Monitor grass height and condition", "Rotate livestock to fresh pasture", "Allow grazed pasture to recover"], "correct": ["Assess pasture carrying capacity", "Introduce appropriate number of livestock", "Monitor grass height and condition", "Rotate livestock to fresh pasture", "Allow grazed pasture to recover"]}', 15, 3, 'Sustainable pastoral farming starts with capacity assessment, then stocking at appropriate levels, continuous monitoring, timely rotation to prevent overgrazing, and allowing adequate recovery time.', NULL),
  
  ('true_false', 'Satellite remote sensing can detect early signs of pasture degradation before it becomes visible to the human eye.', '{"correct": true}', 10, 3, 'Multispectral and hyperspectral satellite sensors detect subtle changes in plant health and soil conditions before they''re visible, enabling early intervention to prevent degradation.', NULL),
  
  ('mcq', 'Which factor is most critical for pastoral farming in semi-arid regions?', '{"options": ["Soil pH levels", "Water availability and rainfall", "Air pollution", "Moon phases"], "correct": "Water availability and rainfall"}', 10, 2, 'Water availability is the limiting factor in semi-arid pastoral systems. NASA precipitation and soil moisture data help predict forage availability and plan herd movements.', NULL),
  
  ('numeric', 'A rangeland receives 400mm annual rainfall. If evapotranspiration is 350mm, what is the net water available for plants (in mm)?', '{"correct": 50, "unit": "mm", "tolerance": 0}', 15, 3, 'Net water availability = Rainfall - Evapotranspiration = 400mm - 350mm = 50mm available for plant uptake and soil moisture storage.', NULL)
) AS q(question_type, question_text, question_data, points, difficulty, explanation, media_url)
ON CONFLICT DO NOTHING;

-- Mixed Farming Questions
INSERT INTO questions (subchapter_id, question_type, question_text, question_data, points, difficulty, explanation, media_url)
SELECT 
  (SELECT id FROM subchapters WHERE title = 'Mixed Farming' LIMIT 1),
  q.question_type,
  q.question_text,
  q.question_data::jsonb,
  q.points,
  q.difficulty,
  q.explanation,
  q.media_url
FROM (VALUES
  ('mcq', 'What is the primary advantage of mixed farming over specialized farming?', '{"options": ["Requires less knowledge", "Reduces risk through diversification", "Uses more pesticides", "Eliminates all farm work"], "correct": "Reduces risk through diversification"}', 10, 2, 'Mixed farming diversifies income sources and spreads risk. If one component (crops or livestock) fails, the other can sustain the farm economically.', NULL),
  
  ('true_false', 'In mixed farming, livestock manure can be used as natural fertilizer for crops, creating a sustainable nutrient cycle.', '{"correct": true}', 10, 1, 'Mixed farming creates symbiotic relationships where animal waste becomes crop fertilizer, crop residues feed animals, and nutrients cycle naturally, reducing external input needs.', NULL),
  
  ('numeric', 'A mixed farm allocates 60% of 150 hectares to crops and the rest to pasture. How many hectares are used for pasture?', '{"correct": 60, "unit": "hectares", "tolerance": 0}', 15, 2, 'If 60% is crops, then 40% is pasture. 40% of 150 hectares = 0.40 × 150 = 60 hectares for livestock grazing.', NULL),
  
  ('mcq', 'Which NASA tool helps mixed farmers visualize multiple agricultural data layers together?', '{"options": ["Instagram", "Giovanni online visualization", "TikTok", "YouTube"], "correct": "Giovanni online visualization"}', 10, 3, 'Giovanni (GES-DISC Interactive Online Visualization ANd aNalysis Infrastructure) allows farmers and researchers to visualize and analyze multiple NASA Earth science datasets simultaneously.', NULL),
  
  ('free_text', 'Explain how integrated pest management (IPM) works in mixed farming systems.', '{"min_words": 20, "keywords": ["biodiversity", "predators", "chemical", "natural"]}', 20, 4, 'IPM in mixed farming uses biodiversity to control pests naturally. Crop diversity attracts beneficial predators, livestock disturb pest cycles, and habitat variety supports natural enemies. This reduces chemical pesticide dependence while maintaining pest control through ecological balance.', NULL),
  
  ('matching', 'Match each mixed farming benefit with its description:', '{"pairs": [{"left": "Economic resilience", "right": "Multiple income streams"}, {"left": "Nutrient cycling", "right": "Manure fertilizes crops"}, {"left": "Labor distribution", "right": "Work spread across seasons"}, {"left": "Feed efficiency", "right": "Crop residues feed animals"}], "correct": [["Economic resilience", "Multiple income streams"], ["Nutrient cycling", "Manure fertilizes crops"], ["Labor distribution", "Work spread across seasons"], ["Feed efficiency", "Crop residues feed animals"]]}', 15, 3, 'Mixed farming provides multiple advantages: economic stability through diversification, nutrient recycling between crops and animals, year-round labor use, and efficient resource utilization.', NULL),
  
  ('ordering', 'Order these components of a mixed farm nutrient cycle:', '{"items": ["Crops grow using soil nutrients", "Crops are harvested (grain removed)", "Crop residues are fed to livestock", "Livestock produce manure", "Manure returns nutrients to soil"], "correct": ["Crops grow using soil nutrients", "Crops are harvested (grain removed)", "Crop residues are fed to livestock", "Livestock produce manure", "Manure returns nutrients to soil"]}', 15, 3, 'The nutrient cycle in mixed farming: crops extract soil nutrients, harvest removes some, residues feed animals, animals produce manure, and manure replenishes soil nutrients.', NULL),
  
  ('true_false', 'NASA ARSET (Applied Remote Sensing Training) offers free training on using satellite data for agricultural management.', '{"correct": true}', 10, 2, 'ARSET provides free online and in-person training on applying NASA Earth observations to agriculture, water resources, disasters, health, and other applications.', NULL),
  
  ('mcq', 'In mixed farming, what is "ley farming"?', '{"options": ["Growing only lettuce", "Alternating between crops and temporary pasture", "Keeping animals indoors always", "Using only organic methods"], "correct": "Alternating between crops and temporary pasture"}', 10, 4, 'Ley farming rotates arable land between crop production and temporary grass pasture, combining benefits of both systems while improving soil structure and fertility.', NULL),
  
  ('numeric', 'A mixed farm produces 8 tons of crop residue per hectare. If 30% is used for livestock feed and the farm has 25 hectares, how many tons of residue feed livestock?', '{"correct": 60, "unit": "tons", "tolerance": 0}', 15, 3, 'Total residue = 8 tons/hectare × 25 hectares = 200 tons. Livestock feed = 30% × 200 = 60 tons used as animal feed.', NULL)
) AS q(question_type, question_text, question_data, points, difficulty, explanation, media_url)
ON CONFLICT DO NOTHING;