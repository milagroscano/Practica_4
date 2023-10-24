# ARCHIVOS BINARIOS

# EJEMPLO
# Vamos a trabajar con los archivos data.ctl y data.r4
# Es conveniente primero definir las dimensiones del archivo y el código del
# dato faltante en función de los datos del archivo .ctl
rm(list = ls())

nlat <- 181 #cantidad total de la dimension y (o latitudes)
nlon <- 360 #cantidad total de la dimension x (o longitudes)
ntiempos<- 348 #cantidad total de la dimension time (tiempos)
nnivel<- 1 #cantidad total de la dimension z (o niveles)
nvar <- 1 #Cantidad total de variables
dato_faltante<- -999

# Una vez que definí las dimensiones, se que el archivo binario va a tener
# como largo total la multiplicación entre las distintas dimensiones

## N que va a ser longitud del vectorque voy a leer del binario
N<- nlat*nlon*ntiempos*nnivel*nvar

# Ahora puedo abrir leer el archivo binario a partir de la funcion readBin
## antes defino la ruta donde esta el archivo
archivo <- "/home/clinux01/Descargas/data.r4"

# ahora si abro los datos
datos <- readBin(archivo, "numeric", n = N, endian = "big", size = 4)
# el archivo es de precision simple (4bytes) y es un archivo big endian (lo sabemos de ante mano)

length(datos)
# Chequeo que N sea igual
N

# Ahora puedo cambiar los datos que sean faltantes por NA
datos[which(datos== dato_faltante)] <- NA

# Luego puedo crear un array que tenga los datos que ahora estan en el
# vector. En este caso la variable solo tiene 3 dimensiones, segun el .ctl, y
# son las latitudes, longitudes y tiempos ya que hay un solo nivel y una sola variable

# Armo el array teniendo en cuenta que la primer dimension tiene que ser la de las longitudes
# luego las latitudes y luego el tiempo

datos_array<- array(data = datos, dim = c(nlon, nlat, ntiempos))
dim(datos_array)

# Puedo crear un vector con las longitudes y latitudes, para esto voy a
# necesitar los datos del .ctl:
#   ydef 181 linear -90.000000 1.000
#  xdef 360 linear 0.000000 1.000000
# Entonces las latitudes, van a ser 181 en total, comienzan en -90° y van cada 1°.

# creo el vector latitudes
latitudes <- seq(-90,90,1)

# chequeo que tenga como longitud 181
length(latitudes)

# Las longitudes seran 360 en total, comienzan en 0° y van cada 1°.

# creo el vector longitudes
longitudes <- seq(0,359,1)
# chequeo que tenga como longitud 360
length(longitudes)

# EJERCICIOS SOLOS

# Ahora voy a quedarme con el array pero solo para la región de
# Argentina. Las latitudes de Argentina: -55°S a -20° S
# Longitudes : -75°O a -50°O (o tambien 285° a 310°)

pos1 <- which(latitudes==-55)
pos2 <- which(latitudes==-20)
# renmbrar variables para que sean mas especificas

pos_1 <- which(longitudes==285)
pos_2 <- which(longitudes==310)


datos_arg <- datos_array[pos_1:pos_2, pos1:pos2,]
dim(datos_arg)

# Los datos que tenemos van desde Enero de 1982 a Diciembre de 2010.
# Calculemos el promedio anual, es decir para cada año me
# quedo con una matriz que tenga todas las longitudes y latitudes

# debo reacomodar los datos de la tercera dimension, ya que necesito años
# pues es un promedio anual

# 348/12 = 29, es decir 29 años, por lo tanto me genero otra array separando los meses y años
# entonces me queda un array con 4 dimensiones reacomodando los datos
datos_arg2 <- array(datos_arg, dim = c(26, 36, 12, 29)) 

# realizo el promedio anual sobre los meses
prom_anual <- apply(datos_arg2, c(1,2,4), mean)
# me fijo que las dimensiones sean coherentes
dim(prom_anual)

################################################

# Leer el archivo SepIC_nmme_anom_std_anom.dat que contiene el
# pronóstico de temperatura superficial hecho con un conjunto de
# modelos iniciados en Septiembre para los 6 meses siguientes.

# Seleccionar la variable anomalía pronosticada para el mes de
# Diciembre de 2020 sobre Argentina.

rm(list = ls())

# Es conveniente primero definir las dimensiones del archivo y el código del
# dato faltante en función de los datos del archivo .ctl
archivo <- "/home/clinux01/Descargas/SepIC_nmme_tmpsfc_anom_stdanom.dat"

nlat <- 181 #cantidad total de la dimension y (o latitudes)
nlon <- 360 #cantidad total de la dimension x (o longitudes)
ntiempos<- 6 #cantidad total de la dimension time (tiempos)
nnivel<- 1 #cantidad total de la dimension z (o niveles)
nvar <- 4 #Cantidad total de variables
dato_faltante<- 9.999E+20

N<- nlat*nlon*ntiempos*nnivel*nvar

# ahora si abro los datos
datos <- readBin(archivo, "numeric", n = N, endian = "big", size = 4)
# el archivo es de precision simple (4bytes) y es un archivo big endian (lo sabemos de ante mano)
length(datos)
# Chequeo que N sea igual
N

# Ahora puedo cambiar los datos que sean faltantes por NA
datos[which(datos== dato_faltante)] <- NA

# Seleccionar la variable anomalía pronosticada para el mes de
# Diciembre de 2020 sobre Argentina.

# reacomodo los datos en un array
datos_array<- array(data = datos, dim = c(nlon, nlat, nvar, ntiempos))
dim(datos_array)

# me quedo con los datos de la variable anomalia para el mes de diciembre, pero me falta que sea para argentina
datos_dic <- datos_array[,,4,4]
dim(datos_dic)

# creo el vector latitudes
latitudes <- seq(-90,90,1)

# chequeo que tenga como longitud 181
length(latitudes)

# Las longitudes seran 360 en total, comienzan en 0° y van cada 1°.

# creo el vector longitudes
longitudes <- seq(0,359,1)
# chequeo que tenga como longitud 360
length(longitudes)


# defino el area de argentina
lat_inicio <- which(latitudes==-55)
lat_final <- which(latitudes==-20)

long_inicio <- which(longitudes==285)
long_final <- which(longitudes==310)

datos_arg <- datos_array[long_inicio:long_final, lat_inicio:lat_final,,]
dim(datos_arg)

# me quedo con los datos de la variable anomalia para el mes de diciembre en argentina
datos_arg_dic <- datos_arg[,,4,4]
dim(datos_arg_dic)
