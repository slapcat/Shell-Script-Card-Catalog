#!/bin/bash
# Title: Shell Script Card Catalog
setup() {
clear
if [ -f ~/.sscc ]; then

editor=nano
dir=/home/zad/scripts
menu

else
echo '
Welcome to the Shell Script Card Catalog!

Please take a second to setup your scripting preferences. These can be changed at any time after the setup is finished.

'
read -p "What text editor would you like to use? ["$EDITOR"] " ed
read -p "Where do you keep your scripts? ["$(pwd)"] " dir

if [ -z "$ed" ]; then
ed=$EDITOR
fi

if [ -z "$dir" ]; then
dir=$(pwd)
fi

echo "[Shell Script Card Catalog Configuration]
editor=$ed
dir=$dir
show_main_menu=yes" > ~/.sscc


if [ ! -f ~/bin/sscc ]; then
        if [ ! -d ~/bin/ ]; then
        mkdir ~/bin/
        fi
SOURCE="${BASH_SOURCE[0]}"
cp $SOURCE ~/bin/sscc
chmod +x ~/bin/sscc
clear
echo '
SETUP COMPLETE!

YOU MAY NOW RUN SSCC FROM ANYWHERE BY SIMPLY TYPING "sscc" IN A TERMINAL

PRESS ENTER TO CONTINUE'
read
menu
fi
fi
}

main() {
clear
cd $dir
mapfile -t scripts < <(ls -t *.sh)
length=${#scripts[@]}
i=0

for name in "${scripts[@]}"; do
echo "[$i] $name"
((i++))
done

echo -e "[$i] Back to Main Menu\n"

echo "Select a script to edit or enter the name for a new script [e.g. test.sh]."
read -p ">> " num

if [ "$num" = "$i" ]; then
menu
elif [ "$num" -lt "$i" ]; then
file=${scripts["$num"]}
$editor $file
main
else
$editor $num
main
fi

}

menu() {
clear
echo '

           XXXXX            XXXXX      XXXXXX      XXXXXX
         XXX   XXX        XXX   XXX   XX    XX    XX    XX
        X        XX      X        XX  X      X    X      X
         XX               XX          X           X
          XXXX             XXXX       X           X
             XXXX             XXXX    X           X
                XX               XX   X           X
      X          X     X          X   XX      X   XX      X
       XX        X      XX        X    X     XX    X     XX
        XXX     XX       XXX     XX    XX    X     XX    X
          XXXXXX           XXXXXX       XXXXX       XXXXX

                       SHELL SCRIPT CARD CATALOG
+----------------------------------+----------------------------------+
|        +-----------------+       |        +-----------------+       |
|        |       BIN       |       |        |     SCRIPTS     |       |
|        +-----------------+       |        +-----------------+       |
|                                  |                                  |
|            +---------+           |            +---------+           |
|                                  |                                  |
+---------------------------------------------------------------------+
|        +-----------------+       |        +-----------------+       |
|        |     CONFIG      |       |        |       EXIT      |       |
|        +-----------------+       |        +-----------------+       |
|                                  |                                  |
|            +---------+           |            +---------+           |
|                                  |                                  |
+----------------------------------+----------------------------------+

	[1] Script Catalog
	[2] Execute Script
	[3] Configuration
	[4] Exit
'
read -p ">> " cmd


case $cmd in
1)
main
;;
2)
clear
cd $dir
mapfile -t scripts < <(ls -t *.sh)
length=${#scripts[@]}
i=0

for name in "${scripts[@]}"; do
echo "[$i] $name"
((i++))
done

echo -e "[$i] Back to Main Menu\n"

read -p ">> " num



if [ "$num" = "$i" ]; then
menu
elif [ "$num" -lt "$i" ]; then
file=${scripts["$num"]}
xterm -hold ./$file
menu
else
menu
fi
;;
3)
$editor ~/.sscc
menu
;;
4)
exit 0
;;
*)
menu
;;
esac
}

setup
exit 0
