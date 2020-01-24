#! /bin/bash

### printing to the console ###################################################

echo "You passed in $1."

### branching #################################################################

printf "\n-----------------\n"

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

printf "\n-----------------\n"

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

printf "\n-----------------\n"

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

printf "\n-----------------\n"

for filename in ./*; do
  echo "-> $filename"
done;

### Date and Time #############################################################

printf "\n-----------------\n"

# yyyy-mm-dd-hh-mm-ss-zone
echo "`date +%F-%I-%M-%S-%Z`"

# Friday, January 24th, 2020
postFix="th"
month=`date +%e`
if [[ $month == 1 || $month == 21 || $month == 31 ]]; then postFix="st"; fi
if [[ $month == 2 || $month == 22 ]]; then postFix="nd"; fi
if [[ $month == 3 || $month == 23 ]]; then postFix="rd"; fi
echo "`date '+%A, %B %e'`"$postFix"`date '+, %Y'`"
echo "`date '+%A, %B %e'`"$postFix"`date '+, %Y %l:%M %p'`"

# ISO Date
date -u '+%FT%T%Z'
date '+%FT%T%Z'
date '+%FT%T%z'

# 5:34 pm
date '+%l:%M %p'
date +%T

# Seconds since Unix epoch
date +%s

# Convert ISO to default
date -j -f '%Y-%m-%dT%H:%M:%S%z' 2020-01-24T14:20:12-0500

# Convert ISO to mm/dd/yy format
date -j -f '%Y-%m-%dT%H:%M:%S%z' 2020-01-24T14:20:12-0500 +%D

# Get Timezone from date
date -j -f '%Y-%m-%dT%H:%M:%S%z' 2020-01-24T14:20:12-0500 +%Z

### printf ####################################################################

# see https://alvinalexander.com/programming/printf-format-cheat-sheet

printf "\n-----------------\n"

printf '%8.2f  %08.2f %0x %0x \n' 10.3456 10.3456 255 "$(( 2**32 ))"

largest=`printf "%0x\n" "$(( 2**64-1 ))"`
largestChars=${#largest}
printf "2**64-1 in hex is %s and has %d characters\n" $largest $largestChars

### Arrays ####################################################################

printf "\n-----------------\n"

letter_combos=({A..Z}{A..Z})
echo ${letter_combos[@]}
