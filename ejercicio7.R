
# Ejercicio 7 

# Dado el archivo hgt250REFORECAST.nc y el archivo ncdumpout.txt que contiene la salida del comando ncdump-h: 

rm(list = ls())
require(ncdf4)

# a) Abrir el archivo, obtener el n´umero de variables, de atributos y de dimensiones. 

# abro el archivo
nc <- nc_open ("/LIANA/Escritorio/LicAtmosfera/Laboratorio de Procesamiento de Información Meteorológica/2C 2023/Clases Pract/Practica_4/archivos_practica4/usados/hgt250_REFORECAST.nc")

# extraigo la información
class(nc)
nc

# la variable es la altura geopotencial
# tiene 5 dimensiones: lon, lat, hrs, members (no tiene relevancia) y time
# time tiene unidades de hora, empieza el 1-1-1 00:00:00, delta_t 0000-00-00 12:00:00, dim = 90
# lat tiene grados norte, dim = 38
# lon tiene grados este, dim = 144
# hrs tiene dim = 1, un rango de 12, es decir los datos cambian cada 12hs

# 4 atributos ¿¿???

# b) Asignar los datos de geopotencial a una variable de R. 

hgt <- ncvar_get(nc, "hgt")
hgt

# c) Obtener las latitudes y las longitudes que corresponden a cada punto de ret´ıcula de los datos. 

# se debe extraerlas variables para poder trabajar
# asigno las variables de coordenadas a distintas variables
Longitud <- ncvar_get(nc,varid="lon")
Latitud <- ncvar_get(nc,varid="lat")

# d) Obtener la variable tiempo. ¿En qu´e unidades est´a expresada dicha variable? 
#    Utilizando la funci´on de R as.Date convertir el tiempo al formato YYYY/MM/DD:HH. 

Time <- ncvar_get(nc,varid="time")
# esta en un formato que no se puede trabajar

# UNA forma de poder leer la información de la fecha, tengo que saber cuando comienza, el delta t y la cantidad de información
time1 <- seq(as.Date("0001-01-01"), by= "day", length.out= 90) # ESTA MAL, COMO CAMBIAR ¿¿¿¿??????
head(time1)
# no es la mas recomendable para trabajar

# EL ARCHIVO TXT PARA QUE SERIA ???????

# Nota: Es ´util consultar la convenci´on de tiempos utilizada por R en el help del comando as.Date, notar que
# esta convenci´on no es exactamente la misma que se utiliza en el archivo netcdf.

##########################################
# la forma que se recomienda en la teorica

# luego hay que reacomodar los datos del tiempo
# library(lubridate)
# require(lubridate)
# transformo los datos del tiempo
# NOTAR que el "comienzo es 1-1-1), pero poniendo 1-1-1 me tira error, debo ponerlo en formato AAAA-MM-DD
# time <- ymd_hms ("0001-01-01 00:00:00") + hours(Time)
# head(time) 
