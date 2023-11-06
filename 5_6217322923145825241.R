rm(list=ls())
setwd("C:/Users/ASUS/Documents")
sites=read.csv("401.1.csv",header=TRUE)
attach(sites)
View(sites)
sites.veg=dist(cbind(sites$moss,sites$sedge,sites$forb,sites$fern,sites$woody,sites$shrub)
,method="euclidean")
#veg=vegetable variable
sites.veg
#comment
sites.veg.matrix=as.matrix(sites.veg)
dimnames(sites.veg.matrix)=list(locality,locality)
sites.veg.matrix

sites.pheno=dist(cbind(sites$fwlwngth,sites$thorax,sites$spotting,sites$rfray,
sites$rhray),method="euclidean")
sites.pheno
#pheno=phenotypic variable

sites.geo=dist(cbind(sites$lat_utm,sites$lon_utm),method="euclidean")
sites.geo
#geo=geographic variable

# Hierrarchical clustering

veg.clust=hclust(sites.veg,method="average")
veg.clust
plot(veg.clust,labels=sites$code,main="Figure1.clustering of sites by vegetation structure",
xlab="x_values",ylab="Euclidean distance",sub="")
text(10.5,16,labels='1',cex=2)
text(2,11,labels='2',cex=2)
text(6,11,labels='3',cex=2)

pheno.clust=hclust(sites.pheno,method="average")
pheno.clust
plot(pheno.clust,labels=code,main="Figure2.clustering of sites by phenotypic structure",xlab="x_values",
ylab="Euclidean distance",sub="")
text(10.1,16,labels='1',cex=2)
text(2,11,labels='2',cex=2)
text(6.5,11,labels='3',cex=2)


cluster=cutree(veg.clust,h=16)
vars=c('moss','sedge','forb','fern','woody','shrub')
veg.groups=cbind(cluster,sites[vars])
table1=aggregate(veg.groups[vars],list(veg.groups$cluster),FUN=mean)
colnames(table1)[1]='cluster'
print(signif(table1,1),row.names=FALSE)


cluster=cutree(pheno.clust,h=.59)
vars=c('fwlwngth','thorax','spotting','rfray','rhray')
pheno.groups=cbind(cluster,sites[vars])
table2=aggregate(pheno.groups[vars],list(pheno.groups$cluster),FUN=mean)
colnames(table2)[1]='cluster'
print(signif(table2,2),row.names=FALSE)

## monte carlo test
library(ade4)
mt1<- mantel.rtest(sites.pheno, sites.geo, nrepet=10000)
mt2<- mantel.rtest(sites.pheno, sites.veg, nrepet=10000)
mt3<- mantel.rtest(sites.geo, sites.veg, nrepet=10000)
mt1
mt2
mt3




library(partykit)



#Poblem-2
library(MASS)
mds=isoMDS(sites.veg,k=2)
mds$points
mds$stress
mds1=mds$points[,1]
mds2=mds$points[,2]
sites.mds=cbind(sites,mds1,mds2)
plot(mds1,mds2,main="Figure4.Multidimensional Scaling plot of site vegetation data",cex.axis=1.5,cex.lab=1.5)
text(mds1,mds2,labels=code,pos=2)

####problem-2


bumpus=read.csv("bumpus.csv",header=TRUE)
attach(bumpus)
print(bumpus[1:5,],row.names=FALSE)
dfa=lda(survive~length+alar+weight+lbh+lhum+lfem+ltibio+wskull+lkeel)
dfa
#dfa=discriminant function analysis
predict(dfa)$x
plot(dfa)
    

#######3######

library(FactoMineR)
mydata<- read.csv("C:/Users/ASUS/Documents/bumpus.csv", header=TRUE)
summary(mydata)
head(mydata)
n.fact<- 3
library(stats)
fit1<- factanal(mydata, n.fact, scores=c("regression"), rotation="none")
fit2<- factanal(mydata, n.fact, scores=c("regression"), rotation="varimax")
print(fit1, digit=2, cutoff=0.3, sort=TRUE)
head(fit1$scores)
load=fit1$loadings[,1:3]
plot(load,type="n")
text(load,labels=names(mydata),cex=0.7)

library(psych)
library(psy)
scree.plot(fit1$correlation)
DataMatrix<-cor(mydata)
cortest.bartlett(DataMatrix)
load1=fit1$load

print(fit2, digit=2, cutoff=0.3, sort=TRUE)
head(fit2$scores)
load=fit2$loadings[,1:3]
load1=fit2$load




































