library(data.table)
library(rattle)
library(rpart)
library(randomForest)
library(caret)
library(plyr)
library(dplyr)
#read dataset
rattle()
setwd('C:/Users/Hasee/Desktop/dsfun/data/Framed-purchaseData')
train = fread('training_incidence.csv')
response = read.table('training_response.csv',header = F,sep = ',')

dim(train)
dim(response)
table(response)

sum(is.na(train)) #no missing data

try = train
try = as.data.frame(try)
#null
lt = c()
n=1
for (i in 1:1818){
  if (length(levels(as.factor(try[,i])))<2){
      lt[n] = i 
      n = n+1
      }
  
}
lt
dim(try)
try = try[,-lt]
head(response)
names(DATA)[DATA[,1]]="y"
DATA = cbind(response,try)
dim(DATA)
names(DATA)[DATA[,1]]="y"
j = unique(DATA)
dim(j)
# randomForest(formula = as.factor(y) ~ .,
#              data = crs$dataset[crs$sample, c(crs$input, crs$target)],
#              ntree = 1000, mtry = 3)
#rf1 <- randomForest(y ~ ., j, ntree=700,mtry = 3, norm.votes=FALSE)
#save(rf1, file = "C:/Users/Hasee/Desktop/dsfun/data/Framed-purchaseData/.Rdata")
load("C:/Users/Hasee/Desktop/dsfun/data/Framed-purchaseData/.Rdata") #load randomforest tree
summary(rf1)
k = rf1$importance
t =importance(rf1,type = 2)


head(importance(rf1,type=2))  #Gini指数
write.csv(t,'C:/Users/Hasee/Desktop/t.csv')
plot(rf1)  #error rate:which is not important
varImpPlot(rf1)         #可视化  
prediction <- predict(rf1,type="class") 
table(j$y,prediction)   

# one = filter(j,j$y == 1)
# dim(one)