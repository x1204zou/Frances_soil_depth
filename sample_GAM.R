//Set up the environment for your project. Prepare necessary packages and call them using library() command in the R console
install.packages ("rgdal")
install.packages("raster")
install.packages("mgcv")
install.packages("itsadug")
install.packages("devtools")

library(mgcv)
library(itsadug)
library(raster)
library(rgdal)

//use setwd("the path of your own folder on your machine") here
setwd("C:/Users/Xueyang Zou/Desktop/frances")
data<-read.table(file="soildepth.csv",sep=",",header=TRUE)
names(data)
attach(data)

//import variables
plncurv1 = raster("normplncurv1.tif")
sca1 = raster("normsca1.tif")
sd8a1 = raster("normsd8a1.tif")
slope1 = rater("normslope1.tif")

//reproject the NAD83 raster files. This step is necessary because your input soil depth has WGS_84 GCS, different from your raster projection.
//Once the reprojection is done
coordinates(lat,long_)
var_1 = extract(plncrv1)
var_2 = extract("sca1")
var_3 = extract("sd8a1")
var_4 = extract("slope1")


//check the linear fit between the y and each x variables. Not sure if this step is necessary >_<
is_linear_var1 = gam(soil.depth,var_1)
is_linear_var2 = gam(soil.depth,var_2)
is_linear_var3 = gam(soil.depth,var_3)
is_linear_var4 = gam(soil.depth,var_4)
summary (is_linear_var1)
summary(is_linear_var2)
summary(is_linear_var3)
summary(is_linear_var4)

//construct the GAM model with the four variables
gam <- gam(soil.depth ~ s(var_1)+s(var_2)+s(var_3)+s(var_4))
summary(gam)