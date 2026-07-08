# Acer v4
dat <- dat.acer
# names (dat)

for(i in 1:dim(dat)[1]){
# print(i)
  if((dat$Percent.Buds[i]>=90) & (dat$Percent.Flowers[i]<10) & (dat$Percent.Fruit[i]<10)){ dat$Phenophase[i]=1 } else {
    if((dat$Percent.Buds[i]<=90) & (dat$Percent.Buds[i]>=60) & (dat$Percent.Flowers[i]<=40) & (dat$Percent.Flowers[i]>=10) & (dat$Percent.Fruit[i]<10)){dat$Phenophase[i]=2} else{
      if((dat$Percent.Buds[i]<=60) & (dat$Percent.Buds[i]>=35) & (dat$Percent.Flowers[i]<=65) & (dat$Percent.Flowers[i]>=35) & (dat$Percent.Fruit[i]<15)){dat$Phenophase[i]=3} else{
         if((dat$Percent.Buds[i]<20) & (dat$Percent.Flowers[i]>=70) & (dat$Percent.Fruit[i]<20)){dat$Phenophase[i]=5} else {
           if((dat$Percent.Buds[i]<=40) & (dat$Percent.Buds[i]>=10) & (dat$Percent.Flowers[i]<=70) & (dat$Percent.Flowers[i]>=40) & (dat$Percent.Fruit[i]<=30) & (dat$Percent.Fruit[i]>=10)){ dat$Phenophase[i]=4} else {
              if((dat$Percent.Buds[i]<15) & (dat$Percent.Flowers[i]<=80) & (dat$Percent.Flowers[i]>=50) & (dat$Percent.Fruit[i]<=50) & (dat$Percent.Fruit[i]>=20)){ dat$Phenophase[i]=6} else {
                if((dat$Percent.Buds[i]<10) & (dat$Percent.Flowers[i]<=70) & (dat$Percent.Flowers[i]>=30) & (dat$Percent.Fruit[i]<=70) & (dat$Percent.Fruit[i]>=30)){ dat$Phenophase[i]=7} else {
                  if((dat$Percent.Buds[i]<10) & (dat$Percent.Flowers[i]<=40) & (dat$Percent.Flowers[i]>=10) & (dat$Percent.Fruit[i]<=90) & (dat$Percent.Fruit[i]>=60)){ dat$Phenophase[i]=8} else {
                    if((dat$Percent.Buds[i]<5) & (dat$Percent.Flowers[i]<10) & (dat$Percent.Fruit[i]>=90)){ dat$Phenophase[i]=9} else {dat$Phenophase[i]=NA}
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
write.csv(dat, file.path(path.expand("~"), "Desktop", "Acer_Phenology_Output.csv"))
write.csv(dat, "Acer_Phenology_Output.csv")
phenoPh.acer <- dat