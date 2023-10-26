
# Ejercicio 3 

# Dado el archivo sondeo.txt que tiene las observaciones correspondientes al sondeo de la localidad de Ezeiza del d´ıa 
# 24 de diciembre de 2008, en el siguiente orden: presi´on, temperatura, humedad espec´ıfica. 

rm(list = ls())

# a) Leer los datos y asignar un c´odigo de -999 a los datos faltantes. 

# leo los datos
archivo = "/LIANA/Escritorio/LicAtmosfera/Laboratorio de Procesamiento de Información Meteorológica/2C 2023/Clases Pract/Practica_4/archivos_practica4/usados/sondeo.txt"
datos = read.table(archivo, nrows= 801, skip = 7)

# COMO SE ABREN LOS ARCHIVOS .TXT ????? RESPUESTA : con read.table va bien , solo debo especificar como esta separado el archivo en el editor de texto y eso 

# b) Calcular la altura geopotencial de todos los niveles de presi´on informados en el archivo. 
# 
# c) Generar un nuevo archivo ascii en donde se incluya toda la informaci´on contenida en el archivo sondeo.txt, pero 
# adem´as que incluya una nueva columna con los valores calculados de altura geopotencial.


