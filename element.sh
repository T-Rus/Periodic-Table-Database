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
    # get number
    NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
    OUTPUT_INFO $NUMBER
  # if input is symbol
  elif [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
  then
    # get number
    NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
    OUTPUT_INFO $NUMBER
  # if input is name or invalid input
  else
    # get number
    NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
    OUTPUT_INFO $NUMBER
  fi
}

OUTPUT_INFO() {
  if [[ ! $NUMBER ]]
  then
    echo I could not find that element in the database.
  else
  # Find all information from atomic number as argument
  ELEMENT=$($PSQL "SELECT name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.atomic_number = $NUMBER")
  echo "$ELEMENT" | sed 's/|/ /g' | while read NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
  do
    # Print output with info
    echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
  fi
}

GET_ELEMENT $1