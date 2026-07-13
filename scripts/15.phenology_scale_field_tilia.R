dat.phenoPh.field <- dat.field

for(i in 1:dim(dat.phenoPh.field)[1]){
# print(i)
  if((dat.phenoPh.field$Percent.Buds[i]>=95) & (dat.phenoPh.field$Percent.Flowers[i]<5) & (dat.phenoPh.field$Percent.Fruit[i]<5)){ dat.phenoPh.field$Phenophase[i]=1 } else {
    if((dat.phenoPh.field$Percent.Buds[i]<=95) & (dat.phenoPh.field$Percent.Buds[i]>=70) & (dat.phenoPh.field$Percent.Flowers[i]<=30) & (dat.phenoPh.field$Percent.Flowers[i]>=5) & (dat.phenoPh.field$Percent.Fruit[i]<10)){dat.phenoPh.field$Phenophase[i]=2} else{ 
      if((dat.phenoPh.field$Percent.Buds[i]<=70) & (dat.phenoPh.field$Percent.Buds[i]>=40) & (dat.phenoPh.field$Percent.Flowers[i]<=60) & (dat.phenoPh.field$Percent.Flowers[i]>=25) & (dat.phenoPh.field$Percent.Fruit[i]<15)){dat.phenoPh.field$Phenophase[i]=3} else{ 
         if((dat.phenoPh.field$Percent.Buds[i]<=40) & (dat.phenoPh.field$Percent.Flowers[i]>=50) & (dat.phenoPh.field$Percent.Fruit[i]<=30)){dat.phenoPh.field$Phenophase[i]=5} else {
           if((dat.phenoPh.field$Percent.Buds[i]<=45) & (dat.phenoPh.field$Percent.Buds[i]>=10) & (dat.phenoPh.field$Percent.Flowers[i]<=50) & (dat.phenoPh.field$Percent.Flowers[i]>=40) & (dat.phenoPh.field$Percent.Fruit[i]<=20) & (dat.phenoPh.field$Percent.Fruit[i]>=0)){ dat.phenoPh.field$Phenophase[i]=4} else {
              if((dat.phenoPh.field$Percent.Buds[i]<=25) & (dat.phenoPh.field$Percent.Flowers[i]<70) & (dat.phenoPh.field$Percent.Flowers[i]>=20) & (dat.phenoPh.field$Percent.Fruit[i]<=60) & (dat.phenoPh.field$Percent.Fruit[i]>=0)){ dat.phenoPh.field$Phenophase[i]=6} else {
                if((dat.phenoPh.field$Percent.Buds[i]<=15) & (dat.phenoPh.field$Percent.Flowers[i]<=40) & (dat.phenoPh.field$Percent.Flowers[i]>=10) & (dat.phenoPh.field$Percent.Fruit[i]<=80) & (dat.phenoPh.field$Percent.Fruit[i]>=30)){ dat.phenoPh.field$Phenophase[i]=7} else {
                  if((dat.phenoPh.field$Percent.Buds[i]<=25) & (dat.phenoPh.field$Percent.Flowers[i]<=20) & (dat.phenoPh.field$Percent.Flowers[i]>=0) & (dat.phenoPh.field$Percent.Fruit[i]<95) & (dat.phenoPh.field$Percent.Fruit[i]>=60)){ dat.phenoPh.field$Phenophase[i]=8} else {
                    if((dat.phenoPh.field$Percent.Buds[i]<5) & (dat.phenoPh.field$Percent.Flowers[i]<=5) & (dat.phenoPh.field$Percent.Fruit[i]>=95)){ dat.phenoPh.field$Phenophase[i]=9} else {dat.phenoPh.field$Phenophase[i]=NA}
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }

write.csv(dat.phenoPh.field, 'Data_Phenology_Output.csv')
