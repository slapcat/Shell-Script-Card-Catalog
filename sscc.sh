#!/bin/bash
# Title: Shell Script Card Catalog
setup() {
#if [ -f "~/.sscc" ]; then
#read contents
#else
#setup
#fi

editor=nano
dir=/home/zad/scripts
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
cd $dir
mapfile -t scripts < <(ls -t *.sh)
length=${#scripts[@]}
i=0

for name in "${scripts[@]}"; do
echo "[$i] $name"
((i++))
done

read -p ">> " num
file=${scripts["$num"]}
xterm -hold ./$file
menu
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
menu
exit 0
