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

OUTPUT_INFO() {
  if [[ ! $1 ]]
  then
    echo I could not find that element in the database.
  else
  # Find all information from atomic number as argument
  ELEMENT=$($PSQL "SELECT name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements LEFT JOIN properties ON elements.atomic_number = properties.atomic_number WHERE elements.atomic_number = $1")
  echo "$ELEMENT" | sed 's/|/ /g' | while read NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
  do
    # Print output with info
    echo "The element with atomic number $1 is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
  fi
}

OUTPUT_INFO $1

GET_ELEMENT $1