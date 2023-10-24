# Ciclos

# Ejercicio FOR
# Sea:
# a la secuencia de valores del 1 al 10
a <- 1:10
a
# b los primeros 10 números pares
# asumo 0 como numero par
b <- seq(0, length = 10, by = 2)
b
# Calcular usando el comando for
# La suma de a y b (guardar en un nuevo vector de 10 elementos)
c <- c()

for (i in 1:10) {
c[i] = a[i] + b[i]
}
print("la suma de a y b, posicion a posicion es:") ; c

# El producto entre los elementos 1,3 ,5 y 7 de a y b (guardar en un nuevo vector de 4 elementos)
d <- c()
j = 1

for (i in seq(1, length=4, by = 2)) {
  d[j] = a[i]*b[i]
  j = j + 1
}
print("el producto entre a y b en las posiciones 1, 3, 5 y 7 es:") ; d

# El cuadrado de cada elemento de a (guardar en un nuevo vector de 10 elementos)
e <- c()

for (i in 1:length(a)) {
  e[i] = a[i]^2
}
print("el cuadrado de cada elemento de a es:") ; e

# La raíz cuadrada de cada elemento de b (guardar en un nuevo vector de 10 elementos)
f <- c()

for (i in 1:length(b)) {
  f[i] = sqrt(b[i])
}
print("la raiz cuadrada de cada elemento de b es:") ; f
# Mostrar por pantalla los resultados, indicando lo calculado en cada caso


# -------------------------------------------------------------------------

rm(list=ls())
# Ejercicio WHILE
# Sea:
# a la secuencia de valores del 1 al 10
a <- 1:10
a
# b los primeros 10 números pares
# asumo 0 como numero par
b <- seq(0, length = 10, by = 2)
b

# Calcular usando el comando while

# La suma de a y b (guardar en un nuevo vector de 10 elementos)
c <- c()
i <- 1

while(i<=10) {
  c[i] = a[i] + b[i]
  i = i +1
}
print("la suma de a y b, posicion a posicion es:") ; c

# El producto entre los elementos 1,3 ,5 y 7 de a y b (guardar en un nuevo vector de 4 elementos)
d <- c()
j <- 1
i <- 1
while (i <= 7) {
  d[j] = a[i]*b[i]
  j = j + 1
  i = i + 2
}
print("el producto entre a y b en las posiciones 1, 3, 5 y 7 es:") ; d

# El cuadrado de cada elemento de a (guardar en un nuevo vector de 10 elementos)
e <- c()
i <- 1

while (i<=length(a)) {
  e[i] = a[i]^2
  i = i + 1
}
print("el cuadrado de cada elemento de a es:") ; e

# La raíz cuadrada de cada elemento de b (guardar en un nuevo vector de 10 elementos)
f <- c()
i <- 1

while (i <= length(b)) {
  f[i] = sqrt(b[i])
  i = i + 1
}
print("la raiz cuadrada de cada elemento de b es:") ; f


# -------------------------------------------------------------------------

# Ejercicios

# 1. Calcular la suma de los N primeros términos de la sucesión 1, 2x, 3x2, 4x3, … (uso de FOR)
exp <- 0
coef <- exp + 1
suma <- 0
N <- as.numeric(readline("ingrese un valor para N"))
x <- as.numeric(readline("ingrese un valor para x"))

for (coef in 1:N) {
  suma = suma + coef*x^(exp)
  exp = exp + 1
  coef = exp + 1
}
# revisar porque esta mal asi 

# 2. Cuál es el mayor valor de N tal que la suma 12 + 22 + 32 + … + N2 sea menor que 10 (uso de WHILE)


# 3. Cuál es el mayor valor de N tal que la suma 12 + 22 + 32 + … + N2 sea menor que 100 y N sea menor que 5 (uso de WHILE Y BREAK)


