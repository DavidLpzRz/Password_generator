#!/bin/bash

archivo="contraseñas.txt"

while true; do
    echo "=====Generador de contraseñas======="
    echo "1. Generar una contraseña aleatoria"
    echo "2. Salir"

    read -p "Elige una opción: " opcion

    case $opcion in
        1)
            #Pedir al usuario la longitud de la contraseña
            read -p "Ingrese la longitud de la contraseña de (8-32): " longitud
            if [[ ! $longitud =~ ^[0-9]+$ ]] || [[ $longitud -lt 8 ]] || [[ $longitud -gt 32 ]]; then
                echo "Error: introduzca un valor entre 8 y 32"
                continue
            fi

            read -rp "Quieres mayusculas?? (s/n): " mayusculas
            read -rp "Quieres numeros?? (s/n): " numeros
            read -rp "Quieres caracteres especiales?? (s/n): " especiales

            if [[ $mayusculas != "s" && $numeros != "s" && $especiales != "s" ]]; then
                echo "Error: selecciona al menos una opción"
                continue
            fi

            #Generar los caracteres que va a tener mi motor de contraseñas

            caracteres+="abcdefghijklmnñopqrstuvwxyz"
            
            if [[ $mayusculas == "s" ]]; then
                caracteres+="ABCDEFGHIJKLMNÑOPQRSTUVWXYZ"
            fi

            if [[ $numeros == "s" ]]; then
                caracteres+="0123456789"
            fi

            if [[ $especiales == "s" ]]; then
                caracteres+="!@#$%&()_+-=[]{}|;:,./<>?"
            fi

            #Generar el motor de contraseñas
            password=""

            for (( i=0 ; i<$longitud ; i++ )); do
                rand=$(( $RANDOM % ${#caracteres} ))
                password+="${caracteres:$rand:1}"
            done

            echo ""
            echo "🔒 Contraseña generada: $password"
            echo ""

            echo "$password" >> $archivo
            ;;
        2)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción no válida, introduce 1 o 2"
            ;;
    esac
done