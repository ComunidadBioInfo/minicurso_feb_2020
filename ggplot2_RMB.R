#!/usr/bin/env Rscript
#  ggplot2.R
#  Copyright 2021- E. Ernestina Godoy Lozano (tinagodoy@gmail.com) & Carmina Barberena Jonas (car.barjon@gmail.com)
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.

#  Texto sin acentos

################################################################################################
#####                  Visualizacion de datos usando gramatica de ggplot2                  #####
#####                          Ponentes: E. Ernestina Godoy Lozano                         #####
#####                                    Carmina Barberena Jonas                           #####
################################################################################################

#########################################################
####           Cargar librerias de trabajo           ####
#########################################################

library(ggplot2)
getwd()

#########################################################
####               Ejercicio: qplot()                ####
####             Diapositivas: 17-20                 ####
#########################################################

# Usar datos de vectores numericos
x <- 1:10
y <- rnorm(10, 4.5, 0.1)

# Explorar datos
x
y

# Plot basico
qplot(x,y)

# Añadir una linea
qplot(x, y, geom=c("point", "line"))

# Usar datos de un data.frame, "mtcars" se incluye en la libreria ggplot2
# Explorar los datos
head(mtcars)
dim(mtcars)
summary(mtcars)

qplot(x=mpg, y=wt, data=mtcars)

# Smoothing (agregar una línea suavizada con su error estandar)
qplot(x=mpg, y=wt, data = mtcars, geom = c("point", "smooth"))

# Ajuste lineal por grupo
qplot(x=mpg, y=wt, data = mtcars, color = factor(cyl), geom=c("point", "smooth"))

# Cambiar el color por una variable numerica continua
qplot(x=mpg, y=wt, data = mtcars, colour = cyl)

# Cambiar el color por grupos (factor)
df <- mtcars
df[,'cyl'] <- as.factor(df[,'cyl'])
qplot(x=mpg, y=wt, data = df, colour = cyl)

# Añadir lineas
qplot(mpg, wt, data = df, colour = cyl, geom=c("point", "line"))
    
# Adiccion de temas
qplot(mpg, wt, data = df, colour = cyl, geom=c("point", "line")) + theme_bw()  

#########################################################
####               Ejercicio: ggplot()               ####
####             Diapositivas: 23-31                 ####
#########################################################

## Usaremos el set de datos "iris" que se incluye en la libreria de ggplot2
# Explorar los datos
head(iris)
summary(iris)
dim(iris)

# Agregar datos a un objeto con la funcion ggplot ()
p <- ggplot(data=iris)

## Añadir aesthetics
p <- p + aes(x= Petal.Length, y = Petal.Width, colour = Species)

### Otra forma de hacer el codigo anterior en una sola linea

p <- ggplot(data=iris, aes(x = Petal.Length, y = Petal.Width, colour = Species))

### Vamos a explorar nuestro objeto "p"
summary(p)

## Agregar capas (layers)
p <- p + geom_point()
p

### Hazlo en una linea
ggplot(data=iris, aes(x = Petal.Length, y = Petal.Width, colour = Species)) 
  + geom_point()

### Transformaciones estadisticas de los datos 
p <- p + geom_smooth()

# En una sola linea
ggplot(data=iris, aes(x = Petal.Length, y = Petal.Width, colour = Species)) + 
  geom_point() + 
  geom_smooth()

## Facet grid (Cuadrícula de facetas)
### Vertical
ggplot(data=iris, aes(x = Petal.Length, y = Petal.Width, colour = Species)) + 
  geom_point() + 
  geom_smooth() +  
  facet_grid(~ Species)

### Horizontal
ggplot(data=iris, aes(x = Petal.Length, y = Petal.Width, colour = Species)) + 
  geom_point() + 
  geom_smooth() +  
  facet_grid(Species ~.)

### Quitar leyenda
ggplot(data=iris, aes(x=Petal.Length, y=Petal.Width, colour=Species)) + 
  geom_point(show.legend = FALSE) +
  geom_smooth(show.legend = FALSE) +  
  facet_grid(Species~.)


## Cambio de temas
ggplot(data=iris, aes(x = Petal.Length, y = Petal.Width, colour = Species)) + 
  geom_point(show.legend = FALSE) + 
  facet_grid(Species~.) +
  theme_bw()

ggplot(data=iris, aes(x = Petal.Length, y = Petal.Width, colour = Species)) + 
  geom_point(show.legend = FALSE) + 
  facet_grid(Species~.) +
  theme_linedraw()

#  Cambiar otros elementos en el tema
ggplot(data=iris, aes(x = Petal.Length, y = Petal.Width, colour = Species)) + 
  geom_point(show.legend = FALSE) + 
  facet_grid(Species~.) +
  theme_bw() +  
  theme(panel.background = element_rect(fill = "skyblue"), panel.grid.minor = element_line(linetype = "dotted"))


#### Guardar imagenes
# En que directorio me encuentro
getwd()

# Primera opcion
### PNG con una resolucion de 300 px
png("Figures/dot_plot_iris_data.png", width=10 *300, height=8*300, res= 300)
ggplot(data=iris, aes(x = Petal.Length, y = Petal.Width, colour = Species)) + 
  geom_point(show.legend = FALSE) + 
  facet_grid(Species~.) +
  theme_linedraw()
dev.off()

### PDF (Imagen vectorizada)
pdf("Figures/dot_plot_iris_data.pdf", width=10, height=8)
ggplot(data=iris, aes(x = Petal.Length, y = Petal.Width, colour = Species)) + 
  geom_point(show.legend = FALSE) + 
  facet_grid(Species~.) +
  theme_linedraw()
dev.off()

# Segunda opcion con una funcion propia de ggplot2
ggsave("Figures/dot_plot_iris_data.jpg", device= "jpg")

#########################################################
####               Ejercicio: Bar plots              ####
####               Diapositivas: 32-35               ####
#########################################################
# data
# library(gcookbook)
### crear datos "cabbage_exp"
# cabbage_exp --> Es el recopilado de un experimento de un cultivo de "Col o repollo (cabbage)". Fueron 2 condiciones C39 y C52; y se cortaron las coles a los dias 16, 20 y 21; se pesaron 10 coles de la condicion y se obtuvo la desviacion estandar y el error estandar de la media del peso.

cabbage_exp <- data.frame(Cultivar=c(rep("c39", 3), rep("c52", 3)), Date=rep(c("d16", "d20", "d21"),2), Weight=c(3.18, 2.80, 2.74, 2.26, 3.11, 1.47), sd= c(0.9566144, 0.2788867, 0.9834181, 0.4452215, 0.7908505, 0.2110819), n=rep(10,6), se=c(0.30250803, 0.08819171, 0.31098410, 0.14079141, 0.25008887, 0.06674995))
# Explorar datos
cabbage_exp

# Grafico de Bar plots basico
ggplot(data= cabbage_exp, aes(x=Date, y= Weight)) + geom_bar(stat="identity")

# Cambio de color de las barras
ggplot(data= cabbage_exp, aes(x=Date, y= Weight)) + geom_bar(stat="identity", fill="dodgerblue")

# Cambio de tema
ggplot(data= cabbage_exp, aes(x=Date, y= Weight)) + geom_bar(stat="identity", fill="dodgerblue") + theme_bw()

### Grafico con barras apiladas coloreado por condicion
ggplot(data= cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + 
	geom_bar(stat="identity", position="dodge")

### Usa otra paleta de colores
ggplot(data= cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + 
	geom_bar(stat="identity", position="dodge") +
	scale_fill_brewer(palette="Set1")

### Añadir texto
ggplot(data= cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + 
	geom_bar(stat="identity") +
	scale_fill_brewer(palette="Set1") +
	geom_text(aes(label=Weight), vjust=1.5)

## Posicion "dodge"
ggplot(data= cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + 
	geom_bar(stat="identity", position="dodge") +
	scale_fill_brewer(palette="Set1") +
	geom_text(aes(label=Weight), vjust=-0.4, position=position_dodge(0.9), size=3, colour="green4")

### Añadir barras de error
ggplot(data= cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + 
	geom_bar(stat="identity", position="dodge") +
	scale_fill_brewer(palette="Set1") +
  geom_errorbar(aes(ymin=Weight-se, ymax=Weight+se), width=0.2, position=position_dodge(0.9)) +
	theme_bw()

#########################################################
####           Ejercicio: Scatter plots              ####
####              Diapositivas: 36-38                ####
#########################################################

#### Scatter plots basicos
ggplot(data= iris, aes(x= Petal.Length, y= Petal.Width)) +
	geom_point()
	
# Color por condicion
ggplot(data= iris, aes(x= Petal.Length, y= Petal.Width, colour=Species)) +
	geom_point()

# Forma por condicion
ggplot(data= iris, aes(x= Petal.Length, y= Petal.Width, shape=Species)) +
	geom_point()

# Forma y color por condicion
ggplot(data= iris, aes(x= Petal.Length, y= Petal.Width, shape=Species, colour=Species)) +
	geom_point() 

# Cambiar los valores de forma
ggplot(data= iris, aes(x= Petal.Length, y= Petal.Width, shape=Species, colour=Species)) +
	geom_point() +
	scale_shape_manual(values=c(1,2,3))

# Cambiar colores manuales
ggplot(data= iris, aes(x= Petal.Length, y= Petal.Width, shape=Species, colour=Species)) +
	geom_point() +
	scale_shape_manual(values=c(1,2,3)) +
	scale_colour_manual(values=c("deepskyblue", "seagreen2", "salmon")) +
	theme_bw()

# Cambiar la posicion del recuadro de la leyenda y las etiquetas de los ejes
ggplot(data= iris, aes(x= Petal.Length, y= Petal.Width, shape=Species, colour=Species)) +
  geom_point() +
  scale_shape_manual(values=c(1,2,3)) +
  scale_colour_manual(values=c("deepskyblue", "seagreen2", "salmon")) +
  labs(title= "Taller ggplot RMB", y= "Petal Width (cm)", x= "Petal Length (cm)", fill= "") +
  theme_bw() +
  theme(legend.position="bottom")
  

#########################################################
####    Graficos Interactivos de ggplot:             ####
####                   esquisse                      ####
####              Diapositivas: 39-61                ####
#########################################################

# Instalar libreria
#install.packages("esquisse")

#Cargar libreria
library(esquisse)

#Cargar datos
esquisser(iris)

### Ejemplo: Histogramas
ggplot(iris) +
  aes(x = Sepal.Length) +
  geom_histogram(bins = 30L, fill = "#0c4c8a") +
  theme_minimal()

ggplot(iris) +
  aes(x = Sepal.Length, fill = Species) +
  geom_histogram(bins = 30L) +
  scale_fill_hue() +
  theme_minimal()

### Ejemplo: Boxplots
ggplot(iris) +
  aes(x = "", y = Sepal.Length, fill = Species) +
  geom_boxplot() +
  scale_fill_hue() +
  theme_minimal()

### Ejemplo: Densidad
ggplot(iris) +
  aes(x = Sepal.Length, fill = Species) +
  geom_density(adjust = 1L) +
  scale_fill_hue() +
  theme_minimal()

ggplot(iris) +
  aes(x = Sepal.Length, fill = Species) +
  geom_density(adjust = 1L) +
  scale_fill_viridis_d(option = "viridis") +
  labs(x = "Densidad", title = "Gráfico de Densidad ", subtitle = "Taller ggplot RMB") +
  theme_minimal()

ggplot(iris) +
  aes(x = Sepal.Length, fill = Species) +
  geom_density(adjust = 1L) +
  scale_fill_viridis_d(option = "viridis") +
  labs(x = "Densidad", title = "Gráfico de Densidad ", subtitle = "Taller ggplot RMB") +
  theme_minimal()
