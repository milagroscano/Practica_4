
rm(list = ls())

# cargo las librerias requeridas
require(ncdf4)
require(lubridate)

# concateno un directorio de salida OUTPUTS con el nombre del archivo que quiero crear
OUTPUTS <- ("/home/clinux01/LaboAtm/Practica_4/")

# defino los valores de las variables lon y lat
lon <- seq(270,320,5)
lats <- seq(-10,-50,-5)
# me fijo su largo para definir luego las dimensiones
length(lon)
length(lats)

# defino la variable de tiempo, en meses con as.Date
Months <- as.numeric(seq(as.Date("1979/1/1"), by= "month", length.out= 432))
# me fijo que el formato de la fecha esté bien
Months

# creo las dimensiones
dimX <- ncdim_def("long", "degrees", lon)
dimY <- ncdim_def ("lat", "degrees", lats)
dimT <- ncdim_def("Time", "days", Months, unlim=TRUE)

# defino mi varible asociada a las dimensiones
var1d <- ncvar_def("mslp", units= "hPa", longname= "mean sea level pressure",
                   dim= list(dimX,dimY,dimT), missval= -999, prec="double",verbose=TRUE)

# creo el espacio donde van a estar mis datos, y genero mi lista de valores
nc <- nc_create(paste(OUTPUTS,"mslp_hPa.nc",sep=""), list(var1d))

MSLP <- runif(42768) # length(lon)*length(lats)*432 = 42768

# cargo las variables con ncvar_put
ncvar_put(nc, var1d, MSLP)

# cierro el archivo
nc_close(nc)

###########################

#### ABRIR lo que guardamos
nc <- nc_open("/home/clinux01/LaboAtm/Practica_4/mslp_hPa.nc")
nc
class(nc)

# cargo las variables
presion <- ncvar_get(nc,varid="mslp") 

Longitud <- ncvar_get(nc,varid="long")
Latitud <- ncvar_get(nc,varid="lat")
Time <- ncvar_get(nc,varid="Time")

class(presion)
class(Longitud)
class(Latitud)
class(Time)

# me fijo que valores y formato tiene Time
head(Time)
# el archivo no me dice donde inicializa la fecha, hay que corregirlo y agregar esa info al archivo

# como nosotros creamosel archivo , sabemos que inicializa el 1-1-1970
fecha<-ymd_hms ("1970-1-1 00:00:00") + days(Time) 
# observo que me de bien los formatos de las fechas
head(fecha)
tail(fecha)

# me fjo el valor de la presion en una posicion random
presion[2,2,3]

#####################################################
# PRACTICAR SOLOS

# De la clase pasada, vuelvan a correr el último archivo “XS…..” y guarden en un nuevo archivo sst_corta.nc 
# el período enero_1990 a diciembre_1999.

rm(list = ls())
archivo <- "/home/clinux01/LaboAtm/Practica_4/X157.92.28.55.252.12.27.10.nc"
variable <- nc_open(archivo)
class(variable)
variable

# la variable es el promedio mensual de la temperatura de la superficie del mar
# tiene tres dim: lon (va de 100 a 340), lat (va de 20 a -60) - se agarra la region del pacifico, 
#                 y time (unidad en dias, comienza el 1800-01-01, delta_T : 0000-01-00)

sst <- ncvar_get(variable, "sst")
sst

Longitud <- ncvar_get(variable,varid="lon")
Latitud <- ncvar_get(variable,varid="lat")
Time <- ncvar_get(variable,varid="time")

# hay que reacomodar los datos del tiempo
library(lubridate)
require(lubridate)
# transformo los datos del tiempo
time <- ymd_hms ("1800-01-01 00:00:00") + days(Time)
head(time)

# me genero las posiciones desde donde empieza enero y termina diciembre para los anios pedidos
posicion_time_enero_1990 <- which(format(time, "%Y-%m-%d") == "1990-01-01")
posicion_time_dic_1999 <- which(format(time, "%Y-%m-%d") == "1999-12-01")

periodo_pedido <- time[posicion_time_enero_1990:posicion_time_dic_1999]

sst_cortada <- sst[,,posicion_time_enero_1990:posicion_time_dic_1999]

# ahora debo guardar la variable cortada en un archivo como pide el ejercicio (fijarme en la teorica que esta subida)
