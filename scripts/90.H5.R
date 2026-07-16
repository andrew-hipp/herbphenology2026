
# lmer(outcome ~ fixed_predictor + (1| random_intercept_group), data)
##Direction
lmerTests_Field <- list(
    early = lmer(doy ~ Direction + (1 | PlantNumber), dat.sum.field[[1]]),
    peak = lmer(doy ~ Direction + (1 | PlantNumber), dat.sum.field[[2]]),
    late = lmer(doy ~ Direction + (1 | PlantNumber), dat.field[[3]])
)

# Shade
#Shade + Canopy Cover