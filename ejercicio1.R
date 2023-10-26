
# Ejercicio 1 

# El archivo de datos 87576.dat es un archivo ascii. Abrir el archivo 87576.dat en modo solo lectura. 

rm(list = ls())

archivo <- "/LIANA/Escritorio/LicAtmosfera/Laboratorio de Procesamiento de Información Meteorológica/2C 2023/Clases Pract/Practica_4/archivos_practica4/usados/87576.dat"
datos <- read.table(archivo)

# a) Verificar que la apertura del archivo fue exitosa (impedir que el c´odigo se interrumpa si el archivo no se encuentra, 
#    en este caso el script debe informar que el archivo no fue encontrado). 

#  NO ENTIENDO LA CONSIGNA ¿¿¿¿?????????

# b) Asignar los valores de la columna 2 a la variable ‘Td’ y el contenido de la columna 3 a la variable ‘Temperatura’. 

datos <- read.table(archivo, col.names = c("1", "Td", "Temperatura", "4", "5"))
# el item me pide crear dos variables Td y Temperatura
Td = datos[,2]
Temperatura = datos[, 3]

# c) Leer s´olo las primeras 20 l´ıneas del archivo almacenando la primera columna en una variable integer, y la segunda 
#    y tercera columna en una variable real. 

primeras_lineas = read.table(archivo, nrows = 20)
integer = as.integer(primeras_lineas[,1])
real = as.numeric(c(primeras_lineas[,2], primeras_lineas[,3]))

#  A QUE SE REFIERE CON VARIABLE REAL ¿¿¿¿????

# d) Leer s´olo las primeras 20 l´ıneas y las primeras 3 columnas.

prim_lin_3col = primeras_lineas[,1:3]
