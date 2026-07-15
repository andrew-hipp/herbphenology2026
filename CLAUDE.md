# CLAUDE.md

<!-- Written by Claude (Anthropic) in an interactive Claude Code session with
     Andrew Hipp <ahipp@mortonarb.org>, 2026-07-15. -->

Guidance for Claude Code when working in this repository.

## What this project is

`herbphenology2026` holds data and R code for an **NSF REU project** in the
Herbarium and Systematics Laboratories of The Morton Arboretum (summer 2026).
It analyzes **flowering phenology of primarily cultivated trees** — four focal
genera: *Acer*, *Cercis*, *Cornus*, and *Tilia* — using digitized herbarium
specimens scored for buds/flowers/fruits, joined to local climate data.

People:
- REU participant: Miriam Hafkin
- Primary mentor (Herbarium Coordinator): Lindsey Worcester
- Co-mentor (Herbarium Director): Andrew Hipp <ahipp@mortonarb.org>

## Overarching hypothesis

Climate warming advances flowering phenology, and climate sensitivity (e.g.
slope variance) varies among genera and continents of provenance.

Specific hypotheses (see `README.md` for full detail):
- **H1** — Spring temperature and year are associated with earlier flowering.
- **H2** — Non-native species experience earlier average flowering as
  temperature changes.
- **H3** — Earlier flowering phases show greater climate sensitivity than later.
- **H4** *(later)* — Phylogeny: closer relatives have more similar sensitivity.
- **H5** — Field-collected branches from the four cardinal directions differ.

## ⚠️ Hard constraints for Claude

- **Never write to the `data/` folder.** It holds the raw source spreadsheets.
  Treat it as read-only. Do not create, edit, move, or delete anything under it.
- **Only `CLAUDE.md` may be written without asking.** For any other file write,
  edit, or deletion, stop and get the user's authorization first.
- The R scripts themselves write outputs to `out/` and to a few CSVs in the
  repo root — that is the pipeline's own behavior, not something you should
  reproduce by hand-editing files.
- **Every file Claude writes or substantially rewrites must carry a header**
  noting it was written by Claude in an interactive session with Andrew Hipp,
  with the date (e.g. `# Written by Claude ... with Andrew Hipp <ahipp@mortonarb.org>, YYYY-MM-DD`).
  Use the comment syntax of the file type (`#` for R, `<!-- -->` for Markdown).

## Tech stack

- **Language:** R (no package/project scaffolding — plain scripts run in order).
- **Key packages:** `openxlsx` (read `.xlsx`), `dplyr`/`tidyverse`, `ggplot2`,
  `lme4` + `lmerTest` (mixed models), `patchwork`.
- Scripts use **relative paths** (`data/…`, `out/…`, `scripts/…`), so the R
  working directory must be the **repository root**.

## Repository layout

- `data/` — raw input spreadsheets (**read-only, off-limits to Claude**):
  per-genus specimen files (`Acer.xlsx`, `Cercis.xlsx`, `Cornus.xlsx`,
  `Tilia_americana.xlsx`, `Tilia_everything_else.xlsx`), `Field_Data.xlsx`,
  `Herbarium_GREEN_Specimens.xlsx`, `climate_old.xlsx` / `climate_young.xlsx`,
  `Distribution.xlsx`, `nameFixes.xlsx`, and `data/archive/`.
- `scripts/` — the analysis pipeline (see below); `scripts/ARCHIVE/` holds
  superseded per-genus versions of the same steps.
- `out/` — generated CSVs, logs, and per-species/phenophase PDF plots;
  `out/archive/` holds older outputs.
- Root-level `*_Phenology_Output.csv` — pipeline outputs written to the repo
  root (e.g. `Data_Phenology_Output.csv`, `Field_Data_Phenology_Output.csv`).

## Pipeline / how to run

`scripts/000.doItAll.R` sources every script in `scripts/` in filename order,
skipping `doItAll`, `15`, `99_`, and `ARCHIVE`. Scripts share state through the
in-memory `dat.mat` data frame (and `dat_ph`, `keepsies`) rather than by
re-reading intermediate files, so they must run in sequence, in one session:

1. `00.readData_all.R` — reads all genus spreadsheets, checks headers match,
   `rbind`s them, applies `nameFixes.xlsx`, cleans rows, computes day-of-year
   (`doy`), a two-word `spClean` name, and `cult`/`hyb` flags → builds `dat.mat`.
2. `05.readClimateAndDist.R` — reads climate + distribution data; derives
   per-year spring max-temp windows (`T2_4`, `T3_5`, `T4_6`), precipitation
   windows (`P11_1`, `P12_2`), and continent-of-origin columns; merges onto
   `dat.mat`.
3. `10.phenology_scale_all.R` — assigns a numeric **Phenophase (1–9)** to each
   specimen from percent buds/flowers/fruits (Pearson 2019, *APPS* method).
4. `15.phenology_scale_field_tilia.R` — same phenophase scaling for the field
   *Tilia* data (H5). **Not part of `000.doItAll.R`; run separately.**
5. `30.dataFiltering.R` — splits into phenophase groups (`ph1.3`, `ph4.6`,
   `ph7.8`), and builds `keepsies` = species with ≥ `threshold` (5) specimens
   per phase. Requires `dat.mat` to exist (stops otherwise).
6. `40.basicPlots.R` — per-species year-vs-`doy` scatter + `lm` PDFs into `out/`.
7. `50.H1.R` — H1 mixed models: `doy ~ Year` and `doy ~ Temp` with
   `(1 | spClean)` random effects, plus summary ggplots.
8. `60.H2.R` — H2 mixed models: `doy ~ Europe + Asia + NAm + (1 | spClean)`.

To run everything: set the working directory to the repo root and
`source('scripts/000.doItAll.R')` (then run `15` separately if needed).

## Conventions and gotchas

- The core data object is `dat.mat`; downstream scripts `stop()` if it or
  `keepsies` is missing — always run earlier steps first in the same session.
- `spClean` is the genus + species (two words); cultivar (`'`) and hybrid (`×`)
  specimens are flagged in `cult` / `hyb` and often excluded in filtering.
- Numbers stored as text in spreadsheets are coerced with `class(x) <-
  "numeric"`; percent columns are multiplied by 100 during cleanup.
- Climate `TMAX`/`PRCP` are divided by 10 (GHCN tenths → °C / mm); precipitation
  uses a shifted "climate year" (Nov–Dec roll into the next year).
- Filenames are numeric-prefixed to enforce run order; keep that scheme when
  adding steps, and prefer moving obsolete scripts into `ARCHIVE/` over deleting.
