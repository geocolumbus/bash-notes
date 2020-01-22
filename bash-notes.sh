#! /bin/bash

### printing to the console ###################################################

echo "You passed in $1."

### branching #################################################################

if [ "$1" == "george" ]; then
  echo "And it was George too."
else
  echo "It was not George."
fi

if [ $1 == "alex" ]; then echo "And it was Alex too."; else echo "It was not Alex."; fi

case "$1" in
george)
  echo -n "1. "
  echo "really tall"
  ;;
alex)
  echo -n "2. "
  echo "tall"
  ;;
*)
  echo "unknown height"
  ;;
esac

### Looping ###################################################################

for i in {0..2}; do echo "Number: $i"; done

for name in george kelly alex; do
  echo "Name: $name"
done

BOOKS=('In Search of Lost Time' 'Don Quixote' 'Ulysses' 'The Great Gatsby')
for book in "${BOOKS[@]}"; do
  echo "Book: $book"
done

for ((i = 100; i < 108; i++)); do
  if [[ $i == 101 ]]; then continue; fi
  echo "i = $i"
  if [[ $i == 103 ]]; then break; fi
done

j=3
sum=0
while [[ $j -gt 0 ]]; do
  ((sum += j))
  ((j--))
done
echo "Sum = $sum"

### Functions #################################################################

function_say() {
  arr=("$@")
  text=""
  for word in "${arr[@]}"; do
    text=$text$word" "
  done
  echo "He said $text."
}

function other_say() {
  arr=("$@")
  echo "He also said ${arr[0]}."
}

# read -r -a textArray -p "Say what? "
textArray=('This','is','a','sentence')
function_say "${textArray[@]}"
other_say "${textArray[@]}"

### Files ####################################################################

for filename in ./*; do
  echo "-> $filename"
done;

### Date and Time #############################################################
#
# man strftime shows the date formats.
echo "The month is `date +%B`."


