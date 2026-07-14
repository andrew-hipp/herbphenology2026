# Data filtering will be for filtering our concatenated data by sp 
# and threshold amts of data
# 2026-07-08 ahipp@mortonarb.org, mhalfkin@mortonarb.org, lworcester@mortonarb.org

if(!exists('dat.mat')) stop('** Run scripts 00 and 10 before this one **')

## variables that matter
threshold = 5 # min number of inds / phenophase

## doing stuff
dat_ph <- list(
    ph1.3 = dat.mat[dat.mat$Phenophase %in% 1:3, ],
    ph4.6 = dat.mat[dat.mat$Phenophase %in% 4:6, ],
    ph7.8 = dat.mat[dat.mat$Phenophase %in% 7:8, ]
)

dat.sum <- sapply(dat_ph, function(x, hybexclude = T, cultexclude = T) {
    if(hybexclude) x <- x[!x$hyb, ]
    if(cultexclude) x <- x[!x$cult, ]
    x$spClean |>
    table() |>
    sort(decreasing = T)
    
}
)

whosin <- function(x, thresh = threshold) {
    names(which(x >= thresh))
}

keepsies <- sapply(dat.sum, whosin)
keepsies$earlyAndPeak <- intersect(keepsies[[1]], keepsies[[2]])
