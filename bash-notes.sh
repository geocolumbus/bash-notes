#! /bin/bash

### printing to the console ###################################################

echo "You passed in $1."

### expansions ################################################################

# in precedence order....

# brace

echo a{b,c,e}e  # abe ace aee
mkdir ./{one,two,three}
rm -r ./{one,two,three}

# tilde

echo ~      # /Users/georgecampbell
echo $HOME  # /Users/georgecampbell
echo ~+     # /usr/bin
pwd         # /usr/bin

# shell parameter

string=0123456789
echo ${string:7}    # 789
echo ${string:7:2}  # 78

set -- george
echo ${1:3:2}  # rg

set -- one two three four
echo ${@:0}    # /bin/zsh
echo ${@:1:2}  # one two

# command substitution

echo The files are:"\n"$(ls)  # The files...
echo The path is:"\n"`pwd`    # The path...

# arithmetic expansion

echo $((9*8+3))  # 75

# process substitution

comm -3 <(sort a | uniq) <(sort b | uniq)

# word splitting
# filename expansion
# quote removal

### branching #################################################################
#
# See http://mywiki.wooledge.org/BashFAQ/031 for diff between [ ] and [[ ]]
#
printf "\n-----------------\n"

# POSIX single bracket
# Expands words so must double quote, like"$1"
# string comparison   \>, \<, =, !=
# integer comparison  -gt, -lt, -ge, -le, -eq, -ne
# conditional         -a, -o
# pattern matching    n/a
# regex matching      n/a
if [ "$1" == "george" ]; then
  echo "Name is \"george\""
else
  echo "It was not George."
fi

# BASH double brackets
# Does not expand words, so do not need to double quote, like $1
# string comparison   >, <, == (or =), !=
# integer comparison  -gt, -lt, -ge, -le, -eq, -ne
# conditional         &&, ||
# pattern matching    == (or =)
# regex matching      =~
# files              -e (exists), -nt, -ot (newer older than), -ef (same), ! (not same)
if [[ $1 == "george" ]]; then # BASH double brackets
  echo "george -> the bash way"
else
  echo "not george -> the bash way"
fi

if [[ $1 == "alex" ]]; then echo "And it was Alex too."; else echo "It was not Alex."; fi

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
printf "2**7-1 in decimal is %d\n" $(( 2**7-1 ))
printf "2**15-1 in decimal is %d\n" $(( 2**15-1 ))
printf "2**31-1 in decimal is %d\n" $(( 2**31-1 ))
printf "2**63-1 in decimal is %d\n" $(( 2**63-1 ))
printf "2**63 in decimal is %d\n" $(( 2**63 ))


### Arrays ####################################################################

printf "\n-----------------\n"

array=(one two three four [5]=five)

echo "Array size: ${#array[*]}"

echo "Array items:"
for item in ${array[*]}
do
    printf "   %s\n" $item
done

echo "Array indexes:"
for index in ${!array[*]}
do
    printf "   %d\n" $index
done

echo "Array items and indexes:"
for index in ${!array[*]}
do
    printf "%4d: %s\n" $index ${array[$index]}
done

echo "---"

array=("first item" "second item" "third" "item")

echo "Number of items in original array: ${#array[*]}"
for ix in ${!array[*]}
do
    printf "   %s\n" "${array[$ix]}"
done
echo

arr=(${array[*]})
echo "After unquoted expansion: ${#arr[*]}"
for ix in ${!arr[*]}
do
    printf "   %s\n" "${arr[$ix]}"
done
echo

arr=("${array[*]}")
echo "After * quoted expansion: ${#arr[*]}"
for ix in ${!arr[*]}
do
    printf "   %s\n" "${arr[$ix]}"
done
echo

arr=("${array[@]}")
echo "After @ quoted expansion: ${#arr[*]}"
for ix in ${!arr[*]}
do
    printf "   %s\n" "${arr[$ix]}"
done

