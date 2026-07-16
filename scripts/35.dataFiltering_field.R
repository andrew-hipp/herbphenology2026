
dat_field_ph <- list(
    ph1.3 = dat.field[dat.field$Phenophase %in% 1:3, ],
    ph4.6 = dat.field[dat.field$Phenophase %in% 4:6, ],
    ph7.8 = dat.field[dat.field$Phenophase %in% 7:8, ]
)

#Something here makes the integer 0
dat.sum.field <- sapply(dat_field_ph, function(x, cultexclude = T) {
    
if (is.data.frame(x)) {if (cultexclude) {x <- x[!(x$cult %in% TRUE) & !is.na(x$cult), ]}
    x$spClean |>
    table() |>
    sort(decreasing = T)}
    
}
)

dat.sum.field$earlyAndPeak <- intersect(dat.sum.field[[1]], dat.sum.field[[2]])
