
# Teorica 15 - Leer y guardar archivos en formato NCDF
rm(list = ls())
################################################
# Cargar datos - Formato netcdf - lectura

# Al inicio del script o antes de llamar a las funciones de la librería debemos cargar el
# paquete
require(ncdf4)

# La instrucción para abrir un archivo es nc_open
# nc_open(filename,write=FALSE,readunlim=TRUE,verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )
# filename: nombre del archivo ncdf que desea abrirse
# write: si FALSE (default), entonces el archivo se abre solo para lectura. Si TRUE, la
# escritura también esta habilitada.

# EJEMPLO - Datos diarios de altura geopotencial en 850 hPa (1981-2015), 35 años de información diaria
require(ncdf4)

#Abro el archivo y lo asigno al objeto nc
nc <- nc_open ("/home/clinux01/LaboAtm2023/ClasesTeo/hgt850.nc")
#Para ver los atributos y que variables contiene de el archivo nc se puede escribir
class(nc)
nc

# short hgt[lon,lat,level,time] - las dimensiones que hay dentro del archivo
# long_name: Daily Geopotential Heights on Pressure Levels
# units: m  - la unidad de la variable principal
# add_offset: 31265 
# scale_factor: 1
# missing_value: 32766 - datos faltantes, sirve para poder identificarlos y redefinirlos

# 5 dimensions:
#   lon  Size:33            - la longitud de la dim lon
# units: degrees_east       - si se tiene en cuenta el este u oeste
# long_name: Longitude
# actual_range: 260         - entre que valores se va moviendo, puede ser de 0 a 180 y de -180 a 0
# actual_range: 340         - o de 0 a 360 directamente
# 
# lat  Size:27              - la longitud de la dim lat
# units: degrees_north      - especifica si es sur o norte
# actual_range: 0           - el rango, para el norte siempre se toma positivo y para el sur negativo
# actual_range: -65
# 
# level  Size:1             - se tiene en cuenta un solo nivel
# units: millibar
# 
# time  Size:12783   *** is unlimited *** - la longitud de la dim time
#   units: hours since 1800-1-1 00:00:0.0
#   long_name: Time
#   actual_range: 1586616                - el tiempo hay que codificarlo en un formato mas amigable
#   actual_range: 1893384
#
# nbnds  Size:2 (no dimvar)              - limites del tiempo, no tiene relevancia


# Para obtener una variable se utiliza el comando ncvar_get y asigno la salida a un objeto, en este caso hgt
hgt850 <- ncvar_get(nc, "hgt") # obtengo del archivo nc, la variable hgt
hgt850 # escribo el nombre de la variable para ver los datos. Como son??
# el factor de escala ya esta corregido, se encuentra en metros

# asigno las variables de coordenadas a distintas variables. Como son??
Longitud <- ncvar_get(nc,varid="lon")
Latitud <- ncvar_get(nc,varid="lat")
Time <- ncvar_get(nc,varid="time")

# dim(hgt850) - 1 dim = longitud, 2 dim = latitud, 3 dim = tiempo

# ¿Qué pasa con la variable Time?
head(Time) # pido por pantalla los primeros valores de Time ¿Son fechas? ¿Cuál es el paso (el delta t)? El delta t = 24, 24hs, son datos diarios
# Busquemos en la info, en que unidad esta expresado el tiempo - datos diarios, me muestra informacion diaria a traves de un numero muy grande
# Hay que codificar los datos del tiempo, aparecen en un formato muy poco amigable

# SOLUCIONES (una o la otra)
# UNA forma de poder leer la información de la fecha, tengo que saber cuando comienza, el delta t y la cantidad de información
z <- seq(as.Date("1981/1/1"), by= "day", length.out= 12783)
head(z)
# no es la mas recomendable para trabajar

# OTRA forma de leer las fechas es por medio de una libreria que hay que instalar libreria para transformar las fechas del ncdf a variable
library(lubridate)
require(lubridate)
# transformo los datos del tiempo
# NOTAR que el "comienzo es 1800-1-1)
time <- ymd_hms ("1800-1-1 00:00:00") + hours(Time)
# yms = años, meses, dias - hms = horas, minutos, segundos
# pongo el comienzo del tiempo (lo dice el archivo) y le sumo, en este caso en hs, lo que esta almacenado en la dim Time
# leer como vienen los datos, hay veces que se cambia el "hours" por "day" (va a depender de la unidad en la que este la info)
head(time)

# OTRA forma
fechas <- as.Date(Time/24, origin = "1800-01-01")
# Time lo divido por 24 ya que se que son datos diarios, para esto debo tener en cuenta que tipos de datos tengo
# defino el origen de los tiempos

##################################################################################
# Practicar: Cargar datos - Formato Netcdf

# defino las dimensiones de mi variable
dimnames(hgt850) <- list(lon = Longitud, lat = Latitud, date = as.character(time))
str(hgt850)

# 1) Leer el set de datos de hgt desde el archivo
# Corroborar su lectura ploteando un campo bidimensional (es decir 1 solo día)
# contour(“variable a graficar”)
contour(hgt850[,,1]) # mi variable es la altura geopotencial
                     # quiero un grafico para todas las lon y lat, pero lo defino para un solo tiempo (dia 1)
                     # no hay datos de ejes definidos, por default van de 0 a 1
                     # en el plot se observa que las lat estan invertidas pues el grafico aparece invertido (SIEMPRE hay que corregirlo en estos archivos)
                     # campo diario

# 2) Leer los datos de hgt para la banda de latitud 20 S - 40 S exclusivamente.
# Corroborar su lectura ploteando un campo bidimensional.

# defino las posiciones donde la lat es -20 y -40
lat_20 <- which(Latitud==-20)
lat_40 <- which(Latitud==-40)
# defino lo que quiero graficar teniendo en cuenta las lat
# contour(hgt850[,lat_20:lat_40,1])
contour(hgt850[,lat_40:lat_20,1]) # de esta forma tengo en cuenta que los valores va de forma ascendente, de la for0ma correcta como se encuentra en el Sur

# 3) Leer los datos de hgt para el periodo 1990-2000 exclusivamente.
time_1990 <- which(substr(time, 1, 4)=="1990")[1]
time_2000 <- which(substr(time, 1, 4)=="2000")[1]

time[time_1990:time_2000]

# Corroborar su lectura ploteando un campo bidimensional (31/12/1996)
fecha_especifica <- which(format(time, "%Y-%m-%d") == "1996-12-31") # se debe agregar lo del formato para especificar como esta codificada la fecha
contour(hgt850[,,fecha_especifica])

#################################################################################
# Practicar SOLOS
rm(list = ls())

# El primero es olr.mon.mean.nc

# – ¿Qué variable es? (fácil, el nombre lo dice)
#   promedio mensual de onda larga

# – Abrir el archivo
nc1 <- nc_open ("/home/clinux01/LaboAtm2023/ClasesTeo/olr.mon.mean.nc")

# – Extraer la información
class(nc1)
nc1
# 4 dimensiones: lon , lat, time, nmiss(que no se tiene en cuenta)
olr <- ncvar_get(nc1, "olr")
olr

# – Los tiempos???
# son 438 tiempos, unidad en horas, empieza el 1-1-1 a las 00hs
# el delta_t es cada un mes (0000-01-00), recordar que los datos son medias mensuales
# es decir que pone datos mensuales en hs

# – Hacer un gráfico de algún tiempo

# se debe extraerlas variables para poder trabajar
# asigno las variables de coordenadas a distintas variables
Longitud <- ncvar_get(nc1,varid="lon")
Latitud <- ncvar_get(nc1,varid="lat")
Time <- ncvar_get(nc1,varid="time")

# luego hay que reacomodar los datos del tiempo
library(lubridate)
require(lubridate)
# transformo los datos del tiempo
# NOTAR que el "comienzo es 1-1-1), pero poniendo 1-1-1 me tira error, debo ponerlo en formato AAAA-MM-DD
time <- ymd_hms ("0001-01-01 00:00:00") + hours(Time)
head(time) # me muestra que esta fijado en el dia 3, pero son datos por mes

# realizo el grafico pedido ya con los tiempos acomodados
contour(olr[,,4])

##########################################
# El segundo X157.92.28.55.252.12.27.10.nc

# – ¿Qué variable es? ¿Dónde lo leemos?
rm(list = ls())

# abro el archivo
variable <- nc_open ("/home/clinux01/LaboAtm2023/ClasesTeo/X157.92.28.55.252.12.27.10.nc")
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

# – ¿En que período de tiempo?

# hay que reacomodar los datos del tiempo
library(lubridate)
require(lubridate)
# transformo los datos del tiempo
time <- ymd_hms ("1800-01-01 00:00:00") + days(Time)
head(time)

# – Extraer la información.
# grafico algun tiempo cualquiera
contour(sst[,,3])

# – Graficar la serie temporal para algún punto de retícula.

# en este caso ebo fijar una lat y lon, quedandome con todos los tiempos
# plot me genera una serie temporal
plot(sst[10, 10,], type = "l", col= "red")

###########################################
# El tercero es pp_gfdl_hist_2001-05.nc
rm(list = ls())

# – ¿Qué variable es? (fácil, el nombre lo dice)
# flujo de precipitacion del anio 2001

# abro el archivo
nc2 <- nc_open ("/home/clinux01/LaboAtm2023/ClasesTeo/pp_gfdl_hist_2001.nc")
class(nc2)

# – ¿Espacialmente donde estamos?
nc2 # veo lo que hay dentro de la variable

# tiene tres dim: lon (unidades: grados este), lat (unidades: grados norte), 
#                 y time (unidad en dias, comienza el 1861-01-01, calendario gregoriano, solo tiene un anio de datos, del 2001)

# – Extraer la información
pr <- ncvar_get(nc2, "pr")
pr

Longitud <- ncvar_get(nc2,varid="lon")
Latitud <- ncvar_get(nc2,varid="lat")
Time <- ncvar_get(nc2,varid="time")

# hay que reacomodar los datos del tiempo
library(lubridate)
require(lubridate)
# transformo los datos del tiempo
time <- ymd_hms ("1861-01-01 00:00:00") + days(Time)
head(time)

# – Cómo está expresada la variable. Ahora que hacemos?!?!?! 

# la unidad esta en kg/m^2.s^1 (unidades de flujo)
# necesito unidades de pp, ej mm

# debo realizar una conversion de unidades para obtener mmxdia
# 1 kg m-2 s-1 = 86400 mm day-1.

# como se obtuvo? 
# 1 kg - 1L - 1dm^3 - 0,001m^3
# 0,001 m^3 / m^2 = 1 mm
# luego solo quedan los segundos para pasarlos a dias

# cambio los datos a mm
pp_mm <- pr*86400

# busco donde es pp max
max_pp <- max(pp_mm)
posicion_PP_max <- which(pp_mm == max_pp, arr.ind = T)
lon_pp_max <- Longitud[posicion_PP_max[1]]
lat_pp_max <- Latitud[posicion_PP_max[2]]
dia_pp_max <- time[posicion_PP_max[3]]
