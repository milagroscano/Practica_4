# Clase Funciones
#################
rm(list = ls())

factorial<-function(x) prod(1:x)


factorial(4)
factorial(8)

#####################
hipotenusa <- function(x, y) {
  sqrt(x^2 + y^2)
}

hipotenusa <- function(x, y) {
  return(sqrt(x^2 + y^2))
}

class(hipotenusa)
hipotenusa(2,3)
hipotenusa(y=3,x=2)

#############################
ff <- function(r) {
  return(PI * r^2)
}

ff(2)

# pi debe estar en minuscula


# -------------------------------------------------------------------------
# ejemplo8.R

# Creamos una funcion que calcula el modulo a un vector
############################################

modulo <- function(v) {         # nombro a la funci?n con el nombre "modulo"
  s <- 0                        # inicializo en 0 a la suma de los cuadrados
  for (e_v in v) {              # me desplazo por los elementos del vector
    s <- s + e_v^2              # incremeto la suma de los cuadrados
  }
  sqrt(s)                     # calculo la ra?z cuadrado y ese es el resultado
}

###############################################

### Probamos con un vector

vv <- c(-2, 3, 4, -5)

### Evaluamos la funcion
modulo(vv)

# OPTIMIZO la pogramación usando la función de agregación sum()
# que toma como argumento un vector y 
# suma uno a uno sus elementos y entrega esa suma como resultado

####################################################
# Se simplifica la función MODULO

modulo_1 <- function(v) {sqrt(sum(v^2))}

#################################################

# lo evaluamos con algún vector

modulo_1(vv)

# -------------------------------------------------------------------------
# ejemplo9.R

# Creamos una función que calcule el valor medio de un vector
##############################################
promedio <- function(v) {
  
  suma <- 0            # inicializo la suma en cero
  n <- 0               # voy a contar los elementos del vector
  
  for (e_v in v) {
    suma <- suma + e_v      # sumo cada elemento del vector
    n <- n+1                # voy contando los elementos
  }
  
calculo <- suma/n # Se calcula e imprime el promedio
write(calculo, "resultado.txt") # ahora si almaceno el resultado en un archivo

  return(suma/n)
}

#################################################################

# construyo un vector con elementos numéricos
# arbitrarios, con un generador de números aleatorios
# (distribución uniforme), entre 10.5 y 40.8, generamos 32
nums <- runif(32, 10.5, 40.8)
promedio(nums)

#########################################################
## utilizando las funciones para vectores sum y length optimizamos el programa

hacer_promedio <- function(v) {
  sum(v)/length(v)
}

#############################################

#con el mismo vector que antes
nums <- runif(32, 10.5, 40.8)
hacer_promedio(nums)

# -------------------------------------------------------------------------

######################
ejem.fun <- function(x, y, label = "nombre de variable"){
  plot(x, y, xlab = label) }

ejem.fun(1:5,c(2,4,6,8,10))



ejem.fun.2<-function(x){
  y<-x^2
  plot(x, y) }
######################

grande<-function(x,y){
  y.g<-y>x
  x[y.g]<-y[y.g]
  x
}

# y.g es un vector logical, de T y F, guarda las posiciones cuando y > x
# x[y.g]<-y[y.g] = cuando y es T, asignale lo que esta en y a x

grande(1:5, c(1,6,2,7,3))
grande(x=1:5, y=c(1,6,2,7,3))
grande(y=c(1,6,2,7,3), x=1:5)
grande(1:5, y=c(1,6,2,7,3))

# Funciones de control
# • R nos permite utilizar funciones que controlen y frenen el funcionamiento
# de una función.
# • Podemos hacer que compruebe “algo” y si no es un error grave que nos de
# un mensaje de “warning” y la función se continúe ejecutando.
# • Podemos frenar mediante la función “stop”, nos devuelve un mensaje de
# error y frena la ejecución.
# • También podemos emplear la función “missing” cuando algún argumento
# no fue especificado.

############################
media.total<-function(...) { mean(c(...)) }

############################
media.total<-function(...){
  for (x in list(...)){
    if (!is.numeric(x)) stop("No son numeros")
  }
  mean(c(...))
}

############################
myplot <- function(x,y) {
  if(missing(y)) {
    y <- x
    x <- 1:length(y)
  }
  plot(x,y)
}


myplot(1:20,11:30)
myplot(12:20)

########################

grande<-function(x,y=0*x){	# por defecto compara siempre con 0
  y.g<-y>x                  # si ponemos y=0 lo toma como numero y no funciona
  x[y.g]<-y[y.g]
  x
}

grande(c(-12:3))
grande(c(1,5),2:3)

############################
grande<-function(x,y=0*x){	# funcion grande arreglada con avisos
  if (missing(y)) warning("Estamos comparando con 0")
  y.g<-y>x
  x[y.g]<-y[y.g]
  x
}
grande(-3:3)

# voy a llamar a mis funciones, voy a leer el programa de mis funciones desde el archivo
# utilizo source
# ejemplo source("C:/Users/Usuario/Documents/LABO_COMPU/mis_funciones.R"), hay que setear nuestro directorio
# hay que probar como usarlas y como aparecen en el script
