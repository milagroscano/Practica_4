x<-c(2,5,3,7,1,8,9,4,6)
sum(x)          # suma todos los elementos del vector x
length(x)       # largo total del vector x
sum(x<5)        # cuantos cumplen la condición x<5, vector lógico
x[x<5]          # valores de quienes cumplen la condición
sum(x[x<5])     # ahora si, los sumo
length(x[x<5])
x*(x<5)         # el valor de x solo en las posiciones TRUE
sum(x*(x<5))    # ahora los sumo
which(x<5)      # que posiciones cumplen con la condición
sum(which(x<5)) # sumo posiciones, NO valores
z<-numeric(10)  # genero otro vector
id<-which(x<5)  # en “id” asigno los valores que cumplen la condición
z[id] <- x[x<5]
z[which(x<5)] <- x[x<5] 

# 1) ¿Qué ocurre si hacemos x[1:3] cuando x tiene los datos 2; 1; 0; 3; 6; 1?
x <- c(2, 1, 0, 3, 6, 1)
x[1:3]
# 2) 1:5 # genera los valores 1 2 3 4 5, 2*1:5 ¿qué operador “gana”?
2*1:5
# 3) ¿Pueden predecir el valor de la expresión 1:7*1:2?
1:7*1:2
# 4) ¿Qué pasa con esta expresión 1:8*1:2?
1:8*1:2

# De un edificio, a una altura de 15 m, se ha lanzado con un ángulo de 50 grados, un proyectil a una velocidad de 7 m/s.
# ¿Cuáles serán las alturas (coordenadas y) del proyectil a cada 0.5 m de distancia horizontal desde donde se lanzó y hasta los 11 m?
# Ecuaciones:   x = v0x*t + x0    y = -1/2*g*t^2 + v0y*t + y0
# g: aceleración de la gravedad, t: tiempo, v0x y v0y: componentes de la velocidad.

# Vx = Vo*cos(50°)
# Vy = Vo*sen(50°)

# despejo t en funcion de la primer ecuacion de x, t = x/Vx (x0 = 0)
# luego y = -1/2*g*(x/Vx)² + Vy*t + y0, será un valor con 23 valores

# debo convertir el angulo de grados a radianes
alpha <- (50*pi)/180
# defino los valores de x
x <- seq(0, 11, by = 0.5)
# defino t a partir de la ecuacion de x
t <- x/(7*cos(alpha))

y <- -1/2*9.8*t^2 + (7*sin(alpha))*t + 15
y
length(y)

x <- pi
y <- 2*pi
xor(x>3, y<3)
any(x<3, y<3)

x<-c(T,T,F,F)
y<-c(T,F,T,F)
x&y       # produce TRUE FALSE FALSE FALSE
x|y       # produce TRUE TRUE TRUE FALSE
xor(x,y)  # produce FALSE TRUE TRUE FALSE
any(x)    # produce TRUE
all(x)    # produce FALSE

rm(list=ls())             # Borra todas las variables
seq(0, 3*pi, by=.1) -> x  # Genera un vector con valores entre 0 y 3*pi cada 0.1. Lo guarda en x
y=sin(x)
z=(y>0)                   # interrogación lógica… si y>0 TRUE sino FALSE
z
plot(z)                   # los identifica como 0 y 1 para armar el grafico
