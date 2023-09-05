#!/bin/bash

echo "Dame el nombre  del nuevo Script: "
read  new_name

touch $new_name.sh


cat <<EOF > "$new_name.sh"

#!/bin/bash

#Saludo desde el nuevo Script

echo "Hola mundo, soy $new_name"

#Despedida del Script
echo "Prueba exitosa, nos vemos" 


EOF

#Asignar permisos de ejcucion

chmod u+x "$new_name.sh"


echo "Fin del scritp padre"


