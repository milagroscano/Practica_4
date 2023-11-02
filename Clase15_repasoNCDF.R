
# Clase repaso NCDF

# primero se carga la libreria
library(ncdf4)

# como abrir los archivos generalmente
archivo <- "/home/clinux01/LaboAtm/Practica_4/air.mon.mean.nc"
nc <- nc_open(archivo)

# Si queremos extraer la variable Monthly Mean Air Temp:
temp_aire <- ncvar_get(nc, "air")
#Miro de que clase y las dimensiones de los datos
class(temp_aire) # es un array
dim(temp_aire) # 144(lon), 73(lat), 884(time)

# Si queremos extraer las variables lon. lat y time:
latitudes <- ncvar_get(nc, "lat")
longitudes <- ncvar_get(nc, "lon") 
tiempos <- ncvar_get(nc, "time")
# lo que va entre comillas esta definido en el archivo, prestar atencion

# imprimos por pantalla las primeras posiciones del
# vector que tiene los tiempos
head(tiempos)

# Como podemos ver los tiempos no son valores reales, entonces tengo que
# transformar estos valores. Usamos la función as.Date teniendo en cuenta
# la información que nos proporciona el archivo con respecto a los tiempos,
# en este caso si miramos la variable nc cuando nos dan los detalles de la
# dimension tiempo:
#   units: hours since 1800-01-01 00:00:0.0
# Esto quiere decir que la variable tiempos esta en horas (por eso dividire a la variable por las 24 horas) y que el inicio es el primero de enero de 1801,
# con esta información transformo.

tiempos_legibles<- as.Date(tiempos/24,origin="1800-01-01")
head(tiempos_legibles) #miro los primeros tiempos
tail (tiempos_legibles) #miro los ultimos tiempos
#entonces vemos que los datos son mensuales

##################### cambio los datos de tiempo con LUBRIDATE  
# Seleccionar los datos de temperatura del mes de marzo.
# Usaremos la función months para ver los meses de la variable tiempos_legibles
# miramos los primeros meses
head(months(tiempos_legibles))

# Con esta función podemos seleccionar de nuestro array los datos que son del mes de marzo:
datos_temp_marzo <- temp_aire[, , months(tiempos_legibles) == "marzo"]
dim(datos_temp_marzo) #tengo las 144 lon, 73 lat y 74 tiempos que corresponden a los datos de marzo

##########################################################
# OTRA FORMA DE ABRIR DATOS NCDF

# Otra forma de leer archivos netCDF es usando paquetes que abran
# para estos archivos. Uno de ellos es metR.
# Con la función GlanceNetCDF vamos a poder ver que tipo de
# variable y dimensiones tiene el archivo.
# Luego con la función ReadNetCDF para poder leer el archivo con
# sus respectivas variables

# Cargamos el paquete metR y udunits2
library(udunits2)
library(metR)
library(PCICt)

#Vemos las dimensiones del archivo con la función GlanceNetCDF
GlanceNetCDF(archivo)

# Para abrir el archivo usamos ReadNetCDF donde tenemos que
# especificar el archivo que queremos leer y la variable. Esta función
# nos va a devolver un data.frame con los datos
datos <- ReadNetCDF(archivo, vars = "air") # abro los datos
head(datos) # miro las primeras filas
dim(datos) #calculo las dimensiones

# Puede pasar que solo necesitemos los datos de una región, entonces
# podriamos leer todos los datos y luego recortarlos.
# Pero es mucho más eficiente leer sólo los datos que nos interesan,
# especialmente en archivos NetCDF grandes. ReadNetCDF() tiene un
# argumento llamado subset que sirve para especificar qué datos leer:

datos_region<- ReadNetCDF(archivo, vars = "air", subset = list(lat = c(-65, -20), lon = c(280, 310)))

# A subset hay que pasarle una lista donde cada elemento tiene el nombre de
# una dimensión con un vector cuyo rango define el rango de los datos a leer.
# El código de arriba, entonces, dice que de la dimensión lat, lea los valores
# que van entre -65 y -20, y de la dimensión lon, los valores entre 280 y 310.

###################################################################################
# EJERCICIO

# El archivo “datos_u850.nc” contiene datos diarios de la componente u del
# viento en el nivel de 850 hPa para los meses de octubre, noviembre y
# diciembre (OND), para el periodo 2005-2010 sobre Sudamérica.
rm(list = ls())
library(lubridate)

# abro el archivo
archivo_ej <- "/home/clinux01/LaboAtm/Practica_4/datos_u850.nc"
datos <- nc_open(archivo_ej)

# extraigo variables
viento <- ncvar_get(datos, "ua850")
latitudes <- ncvar_get(datos, "lat")
longitudes <- ncvar_get(datos, "lon") 
tiempos <- ncvar_get(datos, "time")
head(tiempos)

# reacomodo la variable tiempo
tiempos_legibles<- as.Date(tiempos, origin="1949-12-01") # as.Date siempre necesita la variable en dias
# en este caso la variable tiempos tiene la unidad de dias, si estuviera en otra hay que pasarlo a dias
head(tiempos_legibles) 
tail (tiempos_legibles)

###################
# Seleccionar el dominio sobre la Cuenca del Plata (38.75 S - 23.75 S; 64.25 O - 51.25 O) 
# y calcular el promedio sobre toda la región y para cada año.
# Deberán obtener un valor por año para toda la región de la Cuenca del Plata.

# defino las posiciones de las lat y lon
posiciones_lat <- which((latitudes>=-38.75) & (latitudes<=-23.75))

posiciones_lon <- which((longitudes>=-64.25) & (longitudes<=-51.25))

dim(viento)
# 100 142 552 - lon lat y time

# selecciono el dominio pedido
dominio_cuenca <- viento[posiciones_lon, posiciones_lat,] 
dim(dominio_cuenca)

# calculo el promedio para cada año
# utilizo la funcion year para ver los años
anios <- year(tiempos_legibles)

# genero un ciclo para calcular el promedio para cada anio
prom <- c()
j <- 1
for (i in 2005:2010) {
  prom[j] <- mean(dominio_cuenca[,,which(anios==i)])
  j = j + 1
}
prom 

#######################################
# Guardar esta información en un data frame que en una columna indique el
# año, y en la siguiente el valor de viento.

# defino un vector con los valores de los anios
anios_vect <- c("2005", "2006", "2007", "2008", "2009", "2010")
# me armo mi df con el vector de los anios y el de prom creado anteriormente
df <- data.frame("Años" = anios_vect, "Promedio" = prom)
df

