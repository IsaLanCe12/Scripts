#!/bin/bash

echo "archivo que quieres recuperar: "
read backup

if [ -e /home/isaias/Scripts/Eliminados/$backup ]
then
	mv /home/isaias/Scripts/Eliminados/$backup /home/isaias/Scripts
	echo "Archivo recuperado"
else
	echo "El archivo no se pudo recuperar, ya que no existe"
fi 


