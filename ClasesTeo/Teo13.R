rm(list = ls())

file.create("/home/clinux01/Descargas/UnVec.txt")
file.exists("/home/clinux01/Descargas/UnVec.txt")
file.remove("/home/clinux01/Descargas/UnVec.txt")

file.copy("/home/clinux01/Descargas/UnVec.txt", "/home/clinux01/Descargas/Caudales01.txt", overwrite = T)

##################################################
# CARGAR DATOS - scan, para leer datos en formato vector

WKDIR = "/home/clinux01/Escritorio/LaboAtm2023/ClasesTeo/"
setwd(WKDIR)
vec <- scan("UnVec.txt") 
print(vec)

vec2 <- scan("IntVec.txt", integer())
print(vec2) ; class(vec2)

scan("IntVec.txt", integer(), skip = 1)

########################################################
# GRABAR DATOS - write

x <- matrix(1:10, ncol = 5)
x

# 1. Escribamos la matriz sin trasponer
write(x)  # como no se le asignó un nombre, por default se guarda el archivo como data
getwd()  # para ver mi directorio de trabajo y donde escribio la salida

# 2. Abramos el archivo “data” para ver como escribio los datos
# 3. Ahora escribamos la matriz traspuesta en el mismo archivo, y con un formato donde las columnas estan separadas por tabulaciones
write(t(x), sep = "\t", append=T)
unlink("data") # borra el archivo donde estuvo escribiendo los datos

# 4. Tambien podemos usar el comando write para escribir en pantalla
write(x, "", sep = "\t") # en el lugar del archivo colocamos comillas

# write.matrix
require(MASS)
l = matrix(rnorm(10000), ncol=10)
write.matrix(l, file="matriz1000x10")
write.matrix(l, file="matriz1000x10b", blocksize = 100)

head(l)

# write.table - sirve para leer en formato data.frame
#creo un data frame
x <- data.frame(a = I("a \ quote"), b = pi)
write.table(x, file = "foo.txt", sep = ",", col.names = NA, qmethod = "double")
write.table(x, file = "foo2.txt", sep = ",")
#Que diferencia encuentra en los archivos foo y foo2?

# COMPARAR write.matrix (en el paquete MASS) y write.table con write
# Precisión, nombres filas y columnas
# EJEMPLO
# 1. Crear una matriz “a” de 100 datos aleatorios con 10 columnas
a = matrix(rnorm(100), ncol=10)

# 2. Cargar la libreria MASS con require(MASS)
# 3. Escribir la matriz “a” en el archivo matriz_a.txt usando write.matrix
write.matrix(a, file="matriz_a.txt")

# 4. Escribir la matriz “a” en el mismo archivo con write y la opción append=TRUE
write(a, file="matriz_a.txt", append = T)

# 5. Escribir la matriz “a” en el mismo archivo con write.table y la opción append=TRUE
write.table(a, file="matriz_a.txt", append = T)

# Comparar los resultados, que diferencias encuentra??
# con append genero que vaya agregando el archivo uno abajo del otro
# las tres formas de abrir el archivo tiene distintos formatos al abrir el txt, es decir al mostrar los datos

# EJEMPLO 2
# 1. Crear la matriz b de 10 columnas a partir del vector 
b=c(1:95,NA,NA,NaN,NaN,Inf)
matriz_b <- matrix(b, ncol=10)
# 2. Repetir los pasos 3,4 y 5 para la matriz b en el archivo matriz_b.txt
# Que pasa con NAN y NA??

write.matrix(matriz_b, file="matriz_b.txt")
write(matriz_b, file="matriz_b.txt", append = T)
# tanto write y write.matrix trabaja con los NA y NaN

write.table(matriz_b, file="matriz_b.txt", append = T)
# pero write.table convierte los NaN en NA

# write.csv y write.csv2
write.csv(x, file = "foo.csv") #o bien
write.csv(x, file = "foo2.csv", row.names = FALSE) #abrir archivos y ver diferencias
# usa el punto para marcar el decimal, y la coma para separar los datos

write.csv2(x, file = "foo.csv2", row.names = FALSE) #y con este??
# usa el punto y coma ; para separar los datos y la coma para marcar el decimal

#####################################################
# CARGAR DATOS - read.table, leer datos en formato data.frame

#read.fwf cat
ff <- tempfile()
cat(file = ff, "123456", "987654", sep = "\n")
read.fwf(ff, widths = c(1,2,3)) # 1 23 456 \ 9 87 654
# widths aplica el formato, el primer elemento es uno, el segundo tiene 2 y el tercero 3 elementos
# es decir, los numeros que estaban todos juntos los separa en ese formato

read.fwf(ff, widths = c(1,-2,3)) # 1 456 \ 9 654
# el -2 significa que saltea la segunda columna, es decir los elementos de 2

unlink(ff) # borro ff

cat(file = ff, "123", "987654", sep = "\n")
read.fwf(ff, widths = c(1,0, 2,3)) # 1 NA 23 NA \ 9 NA 87 654
# el 0 me marca los NA

cat(file = ff, "123456", "987654", sep = "\n")
read.fwf(ff, widths = list(c(1,0, 2,3), c(2,2,2))) # 1 NA 23 456 98 76 54

ff # [1] "/tmp/RtmpYQvPWg/file7d2d60838a70" es un archivo temporario

#######################################################################3333

# ejemplo13: Leer datos en formato ascii
#
# CASO 1: matriz numerica cuadrada
# Archivo a leer: Caudales01.txt
# Funcion scan
#
# CASO 2: tabla conteniendo columnas de numeros mas leyendas
# Archivo a leer: Caudales04.txt
# Funcion read.table
#
# CASO 3:tabla conteniendo columnas de numeros mas leyendas
# Archivo a leer: Caudales04.txt
# Funcion read.table
# Leer los datos de latitud, longitud, altitud y area. Conservarlos como un arreglo
# numerico para eventualmente operar con ellos.
##########################################################

## CASO 1
# Limpio el espacio de trabajo
rm(list=ls())
# Lectura
dir_datos="/home/clinux01/Escritorio/LaboAtm2023/ClasesTeo/Caudales01.txt"
a<-scan(dir_datos)
a  # me lo guarda en el mismo formato que aparece en el txt

# CASO 2: tabla conteniendo columnas de números mas leyendas
# Archivo a leer: Caudales04.txt (slide anterior)
# Funcion: read.table
# Limpio el espacio de trabajo
rm(list=ls())
# Leo los datos 
# considerar "dato" los números que encuentra
dir_datos="/home/clinux01/Escritorio/LaboAtm2023/ClasesTeo/Caudales04.txt"
datos2=read.table(dir_datos,nrows=24,skip=11) # el 11 indica cuantas líneas salta antes
datos2
class(datos2)

# Limpio el espacio de trabajo para estudiar otro ejemplo
# en este caso cambio el ultimo flag (11 a 35)
rm(list=ls())
# Leo los datos (el 36 indica cuantas líneas salta antes de
# considerar "dato" los números que encuentra
dir_datos="/home/clinux01/Escritorio/LaboAtm2023/ClasesTeo/Caudales04.txt"
datos2=read.table(dir_datos,nrows=3,skip=36)
datos2

# CASO 3:tabla conteniendo columnas de numeros mas leyendas
# Archivo a leer: Caudales04.txt
# Funcion read.table
# Leer los datos de latitud, longitud, altitud y area. Conservarlos como un arreglo
# numerico para eventualmente operar con ellos.
rm(list=ls())
dir_datos="/home/clinux01/Escritorio/LaboAtm2023/ClasesTeo/Caudales04.txt"

#primera forma usando scan
datos1=scan(dir_datos,character(),nmax=28)

#creo una matriz solo con los datos que me interesan
latitud1=as.integer(c(datos1[7],datos1[8],datos1[9]))
longitud1=as.integer(c(datos1[14],datos1[15],datos1[16]))
altitud1=as.integer(c(datos1[21],NA,NA))
area1=as.integer(c(datos1[28],NA,NA))
parametros1=rbind(latitud1,longitud1,altitud1,area1)

#segunda forma usando read.fwf
datos2=read.fwf(dir_datos,widths = list(c(15,-39,21,-30,9,-7,2,-1,2,-1,2),c(16,-2,10,-78,10,-5,2,-1,2,-1,2),c(17,-89,14,-6,3),c(25,-81,11,-9,3)),n=1)

#tercera forma usando read.table
datos3=read.table(dir_datos,nrows=4,fill=TRUE)

##################################################3
# EJEMPLO 14
# Lectura de datos ascii con datos faltantes usando la función scan

# Leer el archivo test1.dat que contiene la siguiente información:
datos <- scan(file= "test1.dat", sep =",")
datos





















