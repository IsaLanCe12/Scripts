#!/bin/bash

#Pedir el nombre del archivo por teclado

echo "Nombre del archivo que quieres eliminar: "
read name


#archivo_a_eliminar= $name

if [ -e $name ] 
then
	mv  /home/isaias/Scripts/$name /home/isaias/Scripts/Eliminados
	echo "El archivo $name ha sido eliminado"
else
	echo "El archivo $name no existe"
fi
