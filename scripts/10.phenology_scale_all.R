#Pearson—Applications in Plant Sciences 2019 7(3). Data Supplement S2
#DOI

#############################
#Date: August 13, 2018
#Author: Katelin D. Pearson, ORCID 0000-0003-4947-7662, correspondence: katelin.d.pearson24@gmail.com
#Script name: PhenophaseAssignment.R
#Description: This code assigns the phenophase of each specimen according to its relative percentages of buds, flowers, and fruits
#Input requirements: The input file should be a CSV of specimen records, each with a unique identifier and any other necessary data. Each specimen should have a determine percentage (0, 25, 50, or 100) of buds, flowers, and fruits stored in columns labeled PercentBud, PercentFlower, and PercentFruit, respectively. There should be no empty cells in any of these three columns (empty cells should be replaced by a 0).
#Output file: The output file will be the same CSV as the input file plus an additional "Phenophase" column. This is the assigned numerical phenophase (1-9) of the specimen. Specimens that were not assessable will be listed as NA in this column.
#############################

dat <- dat.mat

for(i in 1:dim(dat)[1]){
# print(i)
  if((dat.mat$Percent.Buds[i]>=95) & (dat.mat$Percent.Flowers[i]<5) & (dat.mat$Percent.Fruit[i]<5)){ dat.mat$Phenophase[i]=1 } else {
    if((dat.mat$Percent.Buds[i]<=95) & (dat.mat$Percent.Buds[i]>=70) & (dat.mat$Percent.Flowers[i]<=30) & (dat.mat$Percent.Flowers[i]>=5) & (dat.mat$Percent.Fruit[i]<10)){dat.mat$Phenophase[i]=2} else{ 
      if((dat.mat$Percent.Buds[i]<=70) & (dat.mat$Percent.Buds[i]>=40) & (dat.mat$Percent.Flowers[i]<=60) & (dat.mat$Percent.Flowers[i]>=25) & (dat.mat$Percent.Fruit[i]<15)){dat.mat$Phenophase[i]=3} else{ 
         if((dat.mat$Percent.Buds[i]<=40) & (dat.mat$Percent.Flowers[i]>=50) & (dat.mat$Percent.Fruit[i]<=30)){dat.mat$Phenophase[i]=5} else {
           if((dat.mat$Percent.Buds[i]<=45) & (dat.mat$Percent.Buds[i]>=10) & (dat.mat$Percent.Flowers[i]<=50) & (dat.mat$Percent.Flowers[i]>=40) & (dat.mat$Percent.Fruit[i]<=20) & (dat.mat$Percent.Fruit[i]>=0)){ dat.mat$Phenophase[i]=4} else {
              if((dat.mat$Percent.Buds[i]<=25) & (dat.mat$Percent.Flowers[i]<70) & (dat.mat$Percent.Flowers[i]>=20) & (dat.mat$Percent.Fruit[i]<=60) & (dat.mat$Percent.Fruit[i]>=0)){ dat.mat$Phenophase[i]=6} else {
                if((dat.mat$Percent.Buds[i]<=15) & (dat.mat$Percent.Flowers[i]<=40) & (dat.mat$Percent.Flowers[i]>=10) & (dat.mat$Percent.Fruit[i]<=80) & (dat.mat$Percent.Fruit[i]>=30)){ dat.mat$Phenophase[i]=7} else {
                  if((dat.mat$Percent.Buds[i]<=25) & (dat.mat$Percent.Flowers[i]<=20) & (dat.mat$Percent.Flowers[i]>=0) & (dat.mat$Percent.Fruit[i]<95) & (dat.mat$Percent.Fruit[i]>=60)){ dat.mat$Phenophase[i]=8} else {
                    if((dat.mat$Percent.Buds[i]<5) & (dat.mat$Percent.Flowers[i]<=5) & (dat.mat$Percent.Fruit[i]>=95)){ dat.mat$Phenophase[i]=9} else {dat.mat$Phenophase[i]=NA}
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }

write.csv(dat.mat, 'out/dat_mat_phenologyOut.csv')


#old one
dat <- dat.mat

for(i in 1:dim(dat)[1]){
# print(i)
  if((dat.mat$Percent.Buds[i]>=90) & (dat.mat$Percent.Flowers[i]<10) & (dat.mat$Percent.Fruit[i]<10)){ dat.mat$Phenophase[i]=1 } else {
    if((dat.mat$Percent.Buds[i]<=90) & (dat.mat$Percent.Buds[i]>=60) & (dat.mat$Percent.Flowers[i]<=40) & (dat.mat$Percent.Flowers[i]>=10) & (dat.mat$Percent.Fruit[i]<10)){dat.mat$Phenophase[i]=2} else{ 
      if((dat.mat$Percent.Buds[i]<=60) & (dat.mat$Percent.Buds[i]>=35) & (dat.mat$Percent.Flowers[i]<=65) & (dat.mat$Percent.Flowers[i]>=35) & (dat.mat$Percent.Fruit[i]<15)){dat.mat$Phenophase[i]=3} else{ 
         if((dat.mat$Percent.Buds[i]<20) & (dat.mat$Percent.Flowers[i]>=70) & (dat.mat$Percent.Fruit[i]<20)){dat.mat$Phenophase[i]=5} else {
           if((dat.mat$Percent.Buds[i]<=40) & (dat.mat$Percent.Buds[i]>=10) & (dat.mat$Percent.Flowers[i]<=70) & (dat.mat$Percent.Flowers[i]>=40) & (dat.mat$Percent.Fruit[i]<=30) & (dat.mat$Percent.Fruit[i]>=10)){ dat.mat$Phenophase[i]=4} else {
              if((dat.mat$Percent.Buds[i]<15) & (dat.mat$Percent.Flowers[i]<=80) & (dat.mat$Percent.Flowers[i]>=50) & (dat.mat$Percent.Fruit[i]<=50) & (dat.mat$Percent.Fruit[i]>=20)){ dat.mat$Phenophase[i]=6} else {
                if((dat.mat$Percent.Buds[i]<10) & (dat.mat$Percent.Flowers[i]<=70) & (dat.mat$Percent.Flowers[i]>=30) & (dat.mat$Percent.Fruit[i]<=70) & (dat.mat$Percent.Fruit[i]>=30)){ dat.mat$Phenophase[i]=7} else {
                  if((dat.mat$Percent.Buds[i]<10) & (dat.mat$Percent.Flowers[i]<=40) & (dat.mat$Percent.Flowers[i]>=10) & (dat.mat$Percent.Fruit[i]<=90) & (dat.mat$Percent.Fruit[i]>=60)){ dat.mat$Phenophase[i]=8} else {
                    if((dat.mat$Percent.Buds[i]<5) & (dat.mat$Percent.Flowers[i]<10) & (dat.mat$Percent.Fruit[i]>=90)){ dat.mat$Phenophase[i]=9} else {dat.mat$Phenophase[i]=NA}
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }

write.csv(dat.mat, 'out/dat_mat_phenologyOut.csv')
