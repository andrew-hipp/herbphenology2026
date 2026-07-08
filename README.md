# herbphenology2026
Phenology analyses of primarily cultivated trees, MOR 2026

This repository holds data and code from an NSF REU project in the Herbarium and Systematics Laboratories of The Morton Arboretum, summer 2026.

Contacts:
* REU participant: Miriam Hafkin
* Primary mentor, Herbarium Coordinator: Lindsey Worcester
* Co-mentor, Herbarium Director, Andrew Hipp <ahipp@mortonarb.org>

## Overarching hypothesis
Climate warming advances flowering phenology, and climate sensitivity (e.g., slope variance) varies among genera and continents (species provenance).

## Specific hypotheses
* H1. Spring temperature and year are associated with earlier flowering dates  
* H2. Non-native spp experience earlier average flowering phases as temperature changes (they can take advantage of climate change)  
* H3: Earlier flowering phases will exhibit greater climate sensitivity than later flowering phases
* H4 [for later]: Phylogeny matters: more closely-related species will have more similar climatic sensitivity

## Analysis questions
* How do we quantify climate sensitivity?  
* Supplementary data needed for taxa (created as a matrix with a line for each taxon):
    * Continent of origin (three columns: EU, AS, NA, with T or F in each) -- From WFO
    * Native in the Chicago region (T, F) -- from Plants of the Chicago Region

## Analysis overview for each hypothesis
* H1 : 
    * DOYx–y ~ Temp; 
    * DOYx–y ~ Year (where x, y = [1,3; 4,6; 7,8])
    * In the global model: Random effects: species, continent, individual
* H2 :
    * ClimateSens ~ nativity + 
