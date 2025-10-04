/*
  # Seed Quiz Questions - Part 3 (Water-Based Farming)

  ## Overview
  Quiz questions for all water-based farming subchapters.

  ## Subchapters Covered
  1. Aquaculture (10 questions)
  2. Mariculture (10 questions)
  3. Freshwater Aquaculture (10 questions)
  4. Algae Farming (10 questions)
*/

-- Aquaculture Questions
INSERT INTO questions (subchapter_id, question_type, question_text, question_data, points, difficulty, explanation, media_url)
SELECT 
  (SELECT id FROM subchapters WHERE title = 'Aquaculture' LIMIT 1),
  q.question_type,
  q.question_text,
  q.question_data::jsonb,
  q.points,
  q.difficulty,
  q.explanation,
  q.media_url
FROM (VALUES
  ('mcq', 'Which NASA sensor monitors ocean color to detect algal blooms that can threaten aquaculture?', '{"options": ["MODIS Ocean Color", "Radio telescope", "Barometer", "Compass"], "correct": "MODIS Ocean Color"}', 10, 2, 'MODIS (Moderate Resolution Imaging Spectroradiometer) measures ocean color to detect chlorophyll concentrations, identifying harmful algal blooms that can devastate aquaculture operations.', NULL),
  
  ('true_false', 'Aquaculture is the fastest-growing food production sector globally.', '{"correct": true}', 10, 2, 'Aquaculture has been the fastest-growing food sector for decades, now providing over half of all seafood consumed globally, helping meet protein demands as wild fish stocks decline.', NULL),
  
  ('numeric', 'An aquaculture pond holds 50,000 liters of water with dissolved oxygen at 4 mg/L. If fish require minimum 5 mg/L, how many mg of oxygen must be added?', '{"correct": 50000, "unit": "mg", "tolerance": 0}', 15, 4, 'Oxygen needed = (Target - Current) × Volume = (5 - 4) mg/L × 50,000 L = 1 mg/L × 50,000 L = 50,000 mg of oxygen required.', NULL),
  
  ('mcq', 'What water quality parameter is most critical for fish health in aquaculture?', '{"options": ["Color", "Dissolved oxygen", "Saltiness preference", "pH of coffee"], "correct": "Dissolved oxygen"}', 10, 2, 'Dissolved oxygen is critical for fish respiration. Low oxygen causes stress, disease susceptibility, and death. NASA sensors help monitor factors affecting oxygen levels like temperature and algae.', NULL),
  
  ('free_text', 'Describe how satellite sea surface temperature data helps aquaculture farmers prevent disease outbreaks.', '{"min_words": 20, "keywords": ["temperature", "stress", "disease", "monitoring"]}', 20, 4, 'Satellite SST data helps farmers anticipate temperature stress events. Sudden temperature changes weaken fish immune systems, making them vulnerable to pathogens. Early warning allows farmers to adjust feeding, increase aeration, or harvest before disease outbreaks occur.', NULL),
  
  ('matching', 'Match each aquaculture challenge with the relevant NASA data:', '{"pairs": [{"left": "Harmful algal blooms", "right": "Ocean color chlorophyll"}, {"left": "Temperature stress", "right": "Sea surface temperature"}, {"left": "Water quality decline", "right": "Turbidity measurements"}, {"left": "Storm damage risk", "right": "Weather forecasting"}], "correct": [["Harmful algal blooms", "Ocean color chlorophyll"], ["Temperature stress", "Sea surface temperature"], ["Water quality decline", "Turbidity measurements"], ["Storm damage risk", "Weather forecasting"]]}', 15, 3, 'NASA provides multiple datasets for aquaculture: ocean color for algal blooms, thermal data for temperature monitoring, water clarity measurements, and weather predictions for operational safety.', NULL),
  
  ('ordering', 'Arrange these aquaculture production steps in order:', '{"items": ["Select suitable water body and species", "Stock juvenile fish or larvae", "Monitor water quality daily", "Feed and manage growth", "Harvest at market size"], "correct": ["Select suitable water body and species", "Stock juvenile fish or larvae", "Monitor water quality daily", "Feed and manage growth", "Harvest at market size"]}', 15, 2, 'Aquaculture production follows: site and species selection, stocking young fish, continuous water quality monitoring, growth management through feeding and care, and finally harvesting.', NULL),
  
  ('true_false', 'NASA Ocean Color Web provides free access to global water quality data useful for aquaculture site selection.', '{"correct": true}', 10, 3, 'NASA Ocean Color Web offers free access to satellite-derived water quality parameters including chlorophyll, turbidity, and temperature, valuable for assessing potential aquaculture sites.', NULL),
  
  ('mcq', 'What is the main environmental concern with intensive aquaculture?', '{"options": ["Too much silence", "Nutrient pollution and waste", "Excessive oxygen", "Too much darkness"], "correct": "Nutrient pollution and waste"}', 10, 3, 'Intensive aquaculture can release excess nutrients (from uneaten feed and fish waste) into surrounding waters, potentially causing eutrophication and algal blooms in natural ecosystems.', NULL),
  
  ('numeric', 'If an aquaculture farm produces 80 tons of fish annually and has a feed conversion ratio of 1.5, how many tons of feed are used yearly?', '{"correct": 120, "unit": "tons", "tolerance": 0}', 15, 3, 'Feed used = Fish production × Feed conversion ratio = 80 tons × 1.5 = 120 tons of feed required annually.', NULL)
) AS q(question_type, question_text, question_data, points, difficulty, explanation, media_url)
ON CONFLICT DO NOTHING;

-- Mariculture Questions
INSERT INTO questions (subchapter_id, question_type, question_text, question_data, points, difficulty, explanation, media_url)
SELECT 
  (SELECT id FROM subchapters WHERE title = 'Mariculture' LIMIT 1),
  q.question_type,
  q.question_text,
  q.question_data::jsonb,
  q.points,
  q.difficulty,
  q.explanation,
  q.media_url
FROM (VALUES
  ('mcq', 'Which NASA mission measured ocean salinity, important for mariculture species selection?', '{"options": ["Aquarius", "Hubble", "Cassini", "New Horizons"], "correct": "Aquarius"}', 10, 3, 'The Aquarius mission (2011-2015) mapped global ocean salinity from space, providing data on salt distribution crucial for marine species habitat requirements and mariculture planning.', NULL),
  
  ('true_false', 'Mariculture specifically refers to farming marine organisms in ocean or coastal environments.', '{"correct": true}', 10, 1, 'Mariculture is a subset of aquaculture focused on saltwater species like oysters, seaweed, and marine fish in coastal or ocean settings, distinct from freshwater aquaculture.', NULL),
  
  ('numeric', 'Oysters filter approximately 200 liters of water per day. How many liters would 500 oysters filter daily?', '{"correct": 100000, "unit": "liters", "tolerance": 0}', 15, 2, 'Total filtration = Oysters × Filtration rate = 500 × 200 L/day = 100,000 liters filtered daily. This natural filtering improves coastal water quality.', NULL),
  
  ('mcq', 'What NASA dataset helps mariculture farmers track ocean currents for site selection?', '{"options": ["OSCAR (Ocean Surface Current Analysis Real-time)", "Netflix queue", "Shopping cart", "Playlist"], "correct": "OSCAR (Ocean Surface Current Analysis Real-time)"}', 10, 3, 'OSCAR provides near-real-time global ocean surface current data, essential for mariculture site selection to ensure adequate water circulation, nutrient delivery, and waste dispersal.', NULL),
  
  ('free_text', 'Explain why seaweed mariculture is considered beneficial for climate change mitigation.', '{"min_words": 20, "keywords": ["carbon", "CO2", "absorption", "ocean"]}', 20, 4, 'Seaweed absorbs CO2 through photosynthesis, sequestering carbon in biomass. When harvested and used for food, biofuel, or biodegradable products, it locks carbon away. Seaweed farms also reduce ocean acidification locally by consuming dissolved CO2.', NULL),
  
  ('matching', 'Match mariculture species with their primary products:', '{"pairs": [{"left": "Oysters", "right": "Pearls and seafood"}, {"left": "Kelp/Seaweed", "right": "Food and biofuel"}, {"left": "Salmon", "right": "High-value fish protein"}, {"left": "Mussels", "right": "Seafood and water filtration"}], "correct": [["Oysters", "Pearls and seafood"], ["Kelp/Seaweed", "Food and biofuel"], ["Salmon", "High-value fish protein"], ["Mussels", "Seafood and water filtration"]]}', 15, 2, 'Different mariculture species serve various purposes: oysters for food and pearls, seaweed for nutrition and energy, salmon as premium protein, and mussels for food while naturally filtering water.', NULL),
  
  ('ordering', 'Arrange the steps for establishing a shellfish mariculture operation:', '{"items": ["Survey coastal site for water quality", "Obtain permits and licenses", "Install cultivation structures (rafts/lines)", "Introduce shellfish larvae or juveniles", "Monitor growth and harvest at maturity"], "correct": ["Survey coastal site for water quality", "Obtain permits and licenses", "Install cultivation structures (rafts/lines)", "Introduce shellfish larvae or juveniles", "Monitor growth and harvest at maturity"]}', 15, 3, 'Shellfish mariculture requires: site assessment for suitable conditions, regulatory approval, infrastructure installation, stocking with young organisms, and ongoing management until harvest.', NULL),
  
  ('true_false', 'NASA satellites can detect coastal water temperature changes that signal when to harvest temperature-sensitive mariculture species.', '{"correct": true}', 10, 3, 'Satellite sea surface temperature data helps mariculture operators time harvests. Many species are sensitive to temperature extremes, and early detection allows harvest before stress or mortality occurs.', NULL),
  
  ('mcq', 'What is a major advantage of shellfish mariculture over finfish farming?', '{"options": ["Requires feeding", "Filters water naturally without feed", "Needs antibiotics", "Produces more waste"], "correct": "Filters water naturally without feed"}', 10, 2, 'Shellfish (oysters, mussels, clams) are filter feeders that naturally extract nutrients from water, requiring no supplemental feeding and actually improving water quality while producing protein.', NULL),
  
  ('numeric', 'A seaweed farm covers 5 hectares and produces 30 tons per hectare annually. What is the total annual production (in tons)?', '{"correct": 150, "unit": "tons", "tolerance": 0}', 15, 2, 'Total production = Area × Yield = 5 hectares × 30 tons/hectare = 150 tons of seaweed produced annually.', NULL)
) AS q(question_type, question_text, question_data, points, difficulty, explanation, media_url)
ON CONFLICT DO NOTHING;

-- Freshwater Aquaculture Questions
INSERT INTO questions (subchapter_id, question_type, question_text, question_data, points, difficulty, explanation, media_url)
SELECT 
  (SELECT id FROM subchapters WHERE title = 'Freshwater Aquaculture' LIMIT 1),
  q.question_type,
  q.question_text,
  q.question_data::jsonb,
  q.points,
  q.difficulty,
  q.explanation,
  q.media_url
FROM (VALUES
  ('mcq', 'Which NASA mission will provide comprehensive data on inland water bodies useful for freshwater aquaculture?', '{"options": ["SWOT (Surface Water and Ocean Topography)", "Mars Rover", "Voyager", "Apollo"], "correct": "SWOT (Surface Water and Ocean Topography)"}', 10, 3, 'SWOT, launched in 2022, measures water levels in lakes, rivers, and reservoirs with unprecedented detail, providing valuable data for freshwater aquaculture site assessment and monitoring.', NULL),
  
  ('true_false', 'Freshwater aquaculture produces more total tonnage globally than mariculture.', '{"correct": true}', 10, 2, 'Freshwater aquaculture dominates global production, particularly carp, tilapia, and catfish farming in Asia, accounting for roughly 60% of total aquaculture production worldwide.', NULL),
  
  ('numeric', 'A fish pond has a carrying capacity of 2 kg of fish per cubic meter. If the pond is 50m × 20m × 2m deep, what is the maximum fish biomass (in kg)?', '{"correct": 4000, "unit": "kg", "tolerance": 0}', 15, 3, 'Volume = 50m × 20m × 2m = 2,000 m³. Maximum biomass = Volume × Capacity = 2,000 m³ × 2 kg/m³ = 4,000 kg of fish.', NULL),
  
  ('mcq', 'What is the primary advantage of pond-based freshwater aquaculture?', '{"options": ["Requires ocean access", "Lower startup costs than marine farming", "No water needed", "Works in deserts only"], "correct": "Lower startup costs than marine farming"}', 10, 2, 'Freshwater pond aquaculture typically has lower infrastructure and operational costs than marine farming, can be located inland, and is accessible to more farmers globally.', NULL),
  
  ('free_text', 'Describe how integrated rice-fish farming systems benefit both rice and fish production.', '{"min_words": 25, "keywords": ["pest", "fertilizer", "yield", "protein"]}', 20, 4, 'In rice-fish systems, fish control rice pests and weeds, their waste fertilizes rice, and their movement oxygenates water and soil. Rice provides shade and habitat for fish. This integration increases rice yields, adds protein production, reduces chemical inputs, and improves farm income.', NULL),
  
  ('matching', 'Match freshwater aquaculture systems with their characteristics:', '{"pairs": [{"left": "Pond culture", "right": "Most common and traditional"}, {"left": "Cage culture", "right": "Suspended in lakes or rivers"}, {"left": "Raceway systems", "right": "Flowing water channels"}, {"left": "Recirculating systems", "right": "Water treatment and reuse"}], "correct": [["Pond culture", "Most common and traditional"], ["Cage culture", "Suspended in lakes or rivers"], ["Raceway systems", "Flowing water channels"], ["Recirculating systems", "Water treatment and reuse"]]}', 15, 3, 'Different freshwater systems suit different needs: ponds are traditional and widespread, cages use existing water bodies, raceways provide high water quality with flow, and recirculating systems conserve water.', NULL),
  
  ('ordering', 'Order the steps in preparing a new freshwater fish pond:', '{"items": ["Clear vegetation and level land", "Excavate pond to desired depth", "Compact bottom and install drainage", "Fill with water and test quality", "Add lime and fertilizers to prepare"], "correct": ["Clear vegetation and level land", "Excavate pond to desired depth", "Compact bottom and install drainage", "Fill with water and test quality", "Add lime and fertilizers to prepare"]}', 15, 3, 'Pond construction follows: land preparation, excavation, structural work with drainage, filling and quality testing, and finally conditioning water chemistry before stocking fish.', NULL),
  
  ('true_false', 'NASA Landsat satellites can monitor water quality and algae levels in freshwater aquaculture ponds.', '{"correct": true}', 10, 3, 'Landsat''s multispectral sensors can detect water color changes indicating algae blooms, turbidity, and other quality parameters in water bodies as small as individual aquaculture ponds.', NULL),
  
  ('mcq', 'Which freshwater fish species is most widely farmed globally?', '{"options": ["Trout", "Carp", "Shark", "Whale"], "correct": "Carp"}', 10, 2, 'Carp (various species) is the most farmed freshwater fish globally, particularly in Asia, valued for rapid growth, feed efficiency, and adaptability to various conditions.', NULL),
  
  ('numeric', 'A tilapia farm achieves 3 harvests per year with 10 tons per harvest. What is the annual production (in tons)?', '{"correct": 30, "unit": "tons", "tolerance": 0}', 15, 2, 'Annual production = Harvests per year × Production per harvest = 3 × 10 tons = 30 tons of tilapia yearly.', NULL)
) AS q(question_type, question_text, question_data, points, difficulty, explanation, media_url)
ON CONFLICT DO NOTHING;

-- Algae Farming Questions
INSERT INTO questions (subchapter_id, question_type, question_text, question_data, points, difficulty, explanation, media_url)
SELECT 
  (SELECT id FROM subchapters WHERE title = 'Algae Farming' LIMIT 1),
  q.question_type,
  q.question_text,
  q.question_data::jsonb,
  q.points,
  q.difficulty,
  q.explanation,
  q.media_url
FROM (VALUES
  ('mcq', 'Which NASA mission tracks atmospheric CO2 levels that algae farming can help reduce?', '{"options": ["OCO-2 (Orbiting Carbon Observatory)", "Hubble", "Voyager", "Apollo 11"], "correct": "OCO-2 (Orbiting Carbon Observatory)"}', 10, 3, 'OCO-2 measures atmospheric CO2 concentrations globally, providing data on carbon sources and sinks. Algae farming''s potential for carbon sequestration is evaluated using such measurements.', NULL),
  
  ('true_false', 'Algae can grow much faster than terrestrial plants and produce more biomass per area.', '{"correct": true}', 10, 2, 'Algae can double their biomass in as little as 24 hours, growing 10-100 times faster than land plants per unit area, making them highly efficient for biofuel and food production.', NULL),
  
  ('numeric', 'Algae absorb approximately 2 kg of CO2 to produce 1 kg of biomass. How much CO2 (in kg) is absorbed when producing 500 kg of algae?', '{"correct": 1000, "unit": "kg CO2", "tolerance": 0}', 15, 3, 'CO2 absorbed = Biomass × CO2 ratio = 500 kg × 2 = 1,000 kg of CO2 sequestered during algae growth.', NULL),
  
  ('mcq', 'What is a primary commercial use of farmed algae besides biofuel?', '{"options": ["Building bricks", "Nutritional supplements and food", "Concrete", "Steel production"], "correct": "Nutritional supplements and food"}', 10, 2, 'Algae like spirulina and chlorella are farmed extensively for human nutrition, animal feed, and supplements due to high protein, omega-3 fatty acids, and vitamin content.', NULL),
  
  ('free_text', 'Explain how algae farming could help address both energy needs and climate change simultaneously.', '{"min_words": 25, "keywords": ["biofuel", "CO2", "carbon", "renewable", "sequester"]}', 20, 4, 'Algae absorb CO2 during growth, sequestering carbon from the atmosphere or industrial emissions. When harvested, algae can be converted to biodiesel, bioethanol, or biogas as renewable fuels. This creates a carbon-neutral or carbon-negative energy cycle while reducing fossil fuel dependence.', NULL),
  
  ('matching', 'Match algae products with their applications:', '{"pairs": [{"left": "Biodiesel", "right": "Renewable transportation fuel"}, {"left": "Spirulina", "right": "Protein-rich food supplement"}, {"left": "Astaxanthin", "right": "Antioxidant and pigment"}, {"left": "Bioplastics", "right": "Biodegradable materials"}], "correct": [["Biodiesel", "Renewable transportation fuel"], ["Spirulina", "Protein-rich food supplement"], ["Astaxanthin", "Antioxidant and pigment"], ["Bioplastics", "Biodegradable materials"]]}', 15, 3, 'Algae have diverse applications: lipid-rich strains for biodiesel, protein-rich species for nutrition, pigment-producing varieties for supplements, and carbohydrate sources for biodegradable plastics.', NULL),
  
  ('ordering', 'Arrange the algae cultivation and harvesting process:', '{"items": ["Select suitable algae strain", "Inoculate growth medium", "Provide light and CO2", "Monitor and maintain culture", "Harvest and process biomass"], "correct": ["Select suitable algae strain", "Inoculate growth medium", "Provide light and CO2", "Monitor and maintain culture", "Harvest and process biomass"]}', 15, 2, 'Algae farming process: strain selection for desired products, inoculation in nutrient medium, providing optimal light and CO2, continuous culture management, and finally harvesting for processing.', NULL),
  
  ('true_false', 'NASA PACE mission studies phytoplankton (marine algae) to understand ocean ecology and carbon cycles.', '{"correct": true}', 10, 3, 'PACE (Plankton, Aerosol, Cloud, ocean Ecosystem) launched in 2024 to study ocean phytoplankton diversity, health, and their role in carbon cycling and climate regulation.', NULL),
  
  ('mcq', 'What environmental advantage does algae farming have over traditional crop-based biofuels?', '{"options": ["Requires prime agricultural land", "Does not compete with food crops for arable land", "Needs more water", "Grows slower"], "correct": "Does not compete with food crops for arable land"}', 10, 3, 'Algae can be grown in non-arable areas, wastewater, or seawater, avoiding food-versus-fuel competition that affects corn or soy-based biofuels requiring agricultural land.', NULL),
  
  ('numeric', 'An algae farm produces 20 grams of dry biomass per liter of culture daily. With 10,000 liters, how many kg are produced daily?', '{"correct": 200, "unit": "kg", "tolerance": 0}', 15, 3, 'Total production = Concentration × Volume = 20 g/L × 10,000 L = 200,000 g = 200 kg of dry algae biomass daily.', NULL)
) AS q(question_type, question_text, question_data, points, difficulty, explanation, media_url)
ON CONFLICT DO NOTHING;