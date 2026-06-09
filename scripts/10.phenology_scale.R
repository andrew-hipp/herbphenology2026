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

dat=read.csv("Desktop/Tilia - For R.csv")
names(dat)

for(i in 1:dim(dat)[1]){
  print(i)
  if((dat$Percent.Bud[i]>=90) & (dat$Percent.Flower[i]<10) & (dat$Percent.Fruit[i]<10)){ dat$Phenophase[i]=1 } else {
    if((dat$Percent.Bud[i]<=90) & (dat$Percent.Bud[i]>=60) & (dat$Percent.Flower[i]<=40) & (dat$Percent.Flower[i]>=10) & (dat$Percent.Fruit[i]<10)){dat$Phenophase[i]=2} else{
      if((dat$Percent.Bud[i]<=60) & (dat$Percent.Bud[i]>=35) & (dat$Percent.Flower[i]<=65) & (dat$Percent.Flower[i]>=35) & (dat$Percent.Fruit[i]<15)){dat$Phenophase[i]=3} else{
         if((dat$Percent.Bud[i]<20) & (dat$Percent.Flower[i]>=70) & (dat$Percent.Fruit[i]<20)){dat$Phenophase[i]=5} else {
           if((dat$Percent.Bud[i]<=40) & (dat$Percent.Bud[i]>=10) & (dat$Percent.Flower[i]<=70) & (dat$Percent.Flower[i]>=40) & (dat$Percent.Fruit[i]<=30) & (dat$Percent.Fruit[i]>=10)){ dat$Phenophase[i]=4} else {
              if((dat$Percent.Bud[i]<15) & (dat$Percent.Flower[i]<=80) & (dat$Percent.Flower[i]>=50) & (dat$Percent.Fruit[i]<=50) & (dat$Percent.Fruit[i]>=20)){ dat$Phenophase[i]=6} else {
                if((dat$Percent.Bud[i]<10) & (dat$Percent.Flower[i]<=70) & (dat$Percent.Flower[i]>=30) & (dat$Percent.Fruit[i]<=70) & (dat$Percent.Fruit[i]>=30)){ dat$Phenophase[i]=7} else {
                  if((dat$Percent.Bud[i]<10) & (dat$Percent.Flower[i]<=40) & (dat$Percent.Flower[i]>=10) & (dat$Percent.Fruit[i]<=90) & (dat$Percent.Fruit[i]>=60)){ dat$Phenophase[i]=8} else {
                    if((dat$Percent.Bud[i]<5) & (dat$Percent.Flower[i]<10) & (dat$Percent.Fruit[i]>=90)){ dat$Phenophase[i]=9} else {dat$Phenophase[i]=NA}
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
write.csv(dat, "/Users/MiriamHafkin/Desktop/Phenology_Output.csv")