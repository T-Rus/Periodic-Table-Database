#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

GET_ELEMENT() {
  # if no input
  if [[ ! $1 ]]
  then
    echo Please provide an element as an argument.
  # if input is atomic number
  elif [[ $1 =~ ^[0-9]+$ ]]
  then
    echo Atomic number detected
  # if input is symbol
  elif [[ $1 =~ ^[A-Z]{1,2}$ ]]
  then
    echo Symbol detected
  # if input is name
  else
    echo echo Name detected
  # if input is not valid
  fi
}


GET_ELEMENT $1