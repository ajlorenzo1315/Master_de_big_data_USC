install.packages("ISLR")
library(ISLR)
data("Default")
head(Default)
# los extaigo de la tabla
attach(Default)
# redecodifico la variable para intercambiar yes no por 1 o 0
default01=rep(0,length(default))

default01[defaukt=="Yes"]=1
plot(balance,default01)