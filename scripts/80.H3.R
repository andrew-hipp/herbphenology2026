
library(lme4)
if(!exists('dat_sum.field')) stop('** Run scripts 01 + 15 + 35 **')
# lmer(outcome ~ fixed_predictor + (1| random_intercept_group), data)
##Direction
lmerTests_Field <- list(
    early = lmer(doy ~ Direction + (1 | PlantNumber), dat.sum.field[[1]]),
    peak = lmer(doy ~ Direction + (1 | PlantNumber), dat.sum.field[[2]]),
    late = lmer(doy ~ Direction + (1 | PlantNumber), dat.sum.field[[3]])
)

lapply(lmerTests_Field, summary)

# Shade
lmerTests_Field <- list(
    early = lmer(doy ~ Direction + Shade + (1 | PlantNumber), dat.sum.field[[1]]),
    peak = lmer(doy ~ Direction + Shade + (1 | PlantNumber), dat.sum.field[[2]]),
    late = lmer(doy ~ Direction + Shade + (1 | PlantNumber), dat.sum.field[[3]])
)

#Shade + Canopy Cover
lmerTests_Field <- list(
    early = lmer(doy ~ Direction + Shade + (Direction * Shade) + (1 | PlantNumber), dat.sum.field[[1]]),
    peak = lmer(doy ~ Direction + Shade + (Direction * Shade) + (1 | PlantNumber), dat.sum.field[[2]]),
    late = lmer(doy ~ Direction + Shade + (Direction * Shade) + (1 | PlantNumber), dat.sum.field[[3]])
)
