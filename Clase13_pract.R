
# Clase lectura de archivos Excel


# primero borramos todas las variables
rm(list=ls())
setwd("/home/clinux01/LaboAtm/")

#cargo libreria
require(readxl)

# Ejemplo

# Vamos a abrir el archivo datos.xls a modo de ejemplo
# Primero veamos como es el archivo original

library(readxl)

archivo_ejemplo = "/home/clinux01/LaboAtm/datos.xls"
cantidad_hojas <- length(excel_sheets(archivo_ejemplo)) #veo la cantidad de hojas del archivo
print(paste("El archivo tiene ", cantidad_hojas, " hojas"))

nombre_hojas <- excel_sheets(archivo_ejemplo) #veo los nombres de las hojas del archivo
print("Estas hojas se llaman:")
print(nombre_hojas)

# Abramos la tercer hoja del archivo

abro_archivo_ejemplo <- read_excel(archivo_ejemplo, sheet = 3) #por numero de hoja
#abro_archivo_ejemplo <- read_excel(archivo_ejemplo, sheet = "serie") #otra opcion, por nombre de hoja

head(abro_archivo_ejemplo) #veo las primeras 6 filas

class(abro_archivo_ejemplo) #veo que tipo de objeto es
# Verificamos con esto que read_excel abre los archivos Excel como Data Frames

################################################################################################ 
# Ejercicio
# Se dispone de los datos de altura del río Paraná en la estación Timbúes (Santa Fe) en el archivo: Historicos_Estacion_3316.xlsx
rm(list = ls())


# Abrir el archivo
archivo_ejercicio <- "/home/clinux01/LaboAtm/Historicos_Estacion_3316.xlsx"
nombre_de_hojas <- excel_sheets(archivo_ejercicio)
print(nombre_de_hojas)
cantidad_de_hojas <- length(excel_sheets(archivo_ejercicio))
print(cantidad_de_hojas)

datos_ejercicio <- read_excel(archivo_ejercicio, sheet = 1)

# Acomodar los datos en un data frame donde la primera columna sean los anios (de cada fecha), la segunda sean los meses (de cada fecha), la tercera  
# sean el dia (de cada fecha) y la cuarta la altura. Ayuda: usar la funcion dmy_hm de la libreria lubridate (ver clase de netcdf)

#paso las fechas a dates
library(lubridate) #cargo libreria 

tiempos <- dmy_hm(datos_ejercicio$`Fecha y Hora`) #paso columna de fechas a 

anios <- year(tiempos) #extraigo los anios
meses <- month(tiempos) #extraigo los meses
dias <- day(tiempos)

#Armo DataFrame
mi_data_frame_datos <- data.frame("Anio" = anios, "Mes" = meses, "Dia" = dias,
                                    "Alturas" = datos_ejercicio$`Altura [m]`)
head(mi_data_frame_datos)

######################################
# Calcular el promedio de la altura del río de enero para cada año entre 1980 y 2021
alturas_enero_prom <- c()

for (i in 1980:2021) {
  posiciones_anio <- which(anios==i)
  alturas_anio <- mi_data_frame_datos$Alturas[posiciones_anio]
  alturas_enero_prom <- c(alturas_enero_prom, mean(alturas_anio[1:31]))
}

# corroboro con el primer anio, el primer valor del vector de alturas_enero_prom
prom_enero_1980 = mean(mi_data_frame_datos[which(mi_data_frame_datos$Anio == 1980),4][1:31])
prom_enero_1980 == alturas_enero_prom[1]

########################################
# Estimar cual es el minimo de la media de altura de río de enero y a que año corresponde
length(alturas_enero_prom)
min_media <- min(alturas_enero_prom)
posicion_min_media <- which(alturas_enero_prom==min_media)

valores_anios <- c(1980:2021)
length(valores_anios)
anio_media_min <- valores_anios[posicion_min_media]

########################################
# Hacer una función que haga el calculo para cualquier mes, calcular la temperatura minima para cada mes y crear un dataframe con los resultados

# el inciso me pide crear una funcion que haga lo mismo que se fue haciendo para enero pero para cualquier mes
# luego los datos que me va tirando para cada mes lo guardo en un data frame

# intento de funcion
# mi_data_frame_datos$Mes
# 
# funcion <- function(mes) {
#   temp_min <- min(mes)
#   return(temp_min)
# }
# 
# data_frame_temp_min <- data.frame(temp_min)

########################################
# Guardar el dataframe en un archivo .csv y un archivo .xlsx












