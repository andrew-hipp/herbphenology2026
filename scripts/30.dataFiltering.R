# Data filtering will be for filtering our concatenated data by sp 
# and threshold amts of data
# 2026-07-08 ahipp@mortonarb.org, mhalfkin@mortonarb.org, lworcester@mortonarb.org

if(!exists('dat.mat')) stop('** Run scripts 00 and 10 before this one **')

dat.sum.byTaxname <- dat.mat$spClean |>
  table() |>
  sort(decreasing = T)
