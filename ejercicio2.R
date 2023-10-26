
# Ejercicio 2 

# El archivo datosgts.txt contiene datos de estaciones. Visualizar el archivo con un editor de texto y dise˜nar una 
# funci´on de R que requiera como argumento el nombre del archivo y que devuelva lo siguiente: 

rm(list = ls())
# DEBO ABRIR EL ARCHIVO ???? SE HACE CON READ.TABLE ????

# a) Una lista de estaciones acompa˜nada de la cantidad de observaciones disponibles para cada estaci´on. 

funcion = function(nombre_archivo) {
  list_est = list(nombre_archivo[,1], length(nombre_archivo[,1])) ### ¿¿¿ A QUE SE REFIERE CON LA CANT DE OBS ??
  return(list_est)
}

# b) Escribir esta lista en un archivo ascii en dos columnas donde la primera es el nombre de la estaci´on y la segunda 
#    es la cantidad de datos. Incluir un encabezado que indique qu´e es cada columna. 

#    ????????

# Nota: no alterar el archivo previo a la lectura, el archivo debe ser le´ıdo por la funci´on con su encabezado presente.
