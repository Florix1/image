#!/usr/bin/env bash

DIR="sample-images-master"
FILES=$(ls $DIR)

#first
vipsthumbnail 1.jpg -c -s 720
vipsthumbnail tn_1.jpg -s 150 -o v1_1.jpg[Q=100,optimize_coding]
vipsthumbnail 1.jpg -s 150x150! -o v2_1.jpg[Q=100,optimize_coding]


#second
vipsthumbnail 2.svg -c -s 1672 -o tn_2.webp
vipsthumbnail tn_2.webp -s 150 -o v1_2.webp[Q=100]
vipsthumbnail 2.svg -s 150x! -o v2_2.webp


#third
gifsicle --resize 150x150 -i 3.gif > v1_3.gif
#sole purpose of consistency format
gifsicle --resize 150x150 -i 3.gif > v2_3.gif


#fourth
vipsthumbnail 4.png -s 150x -o v1_4.webp[Q=100]
#sole purpose of consistency format
vipsthumbnail 4.png -s 150x -o v2_4.webp[Q=100]


#fifth
vipsthumbnail 5.png -c -s 1276 -o tn_5.png
vipsthumbnail tn_5.png -s 150 -o v1_5.png
vipsthumbnail 5.png -s 150x! -o v2_5.png


rm -f tn_*

echo "All sizes are in KB!"
sum=0
for file in $FILES; do
	nr=$(echo $file | tr -dc '0-9')
	old_size=$(ls -l --block-size=KB $DIR | grep $file | awk '{print $5}' \
													   | tr -dc '0-9')
	max_new_size=$(($old_size * 3 / 10))
	echo "Verificare $file de dimensiune initiala $old_size"
	
	#compute new file values
	case $nr in
     1)
		new_size=$(ls -l --block-size=KB | grep "v1_1.jpg" | awk '{print $5}'\
           												   | tr -dc '0-9')
		;;
		
     2)
		new_size=$(ls -l --block-size=KB | grep "v1_2.webp" | awk '{print $5}'\
														    | tr -dc '0-9')
		;;
		
     3)
		new_size=$(ls -l --block-size=KB | grep "v1_3.gif" | awk '{print $5}'\
														   | tr -dc '0-9')
		;;
		
     4)
		new_size=$(ls -l --block-size=KB | grep "v1_4.webp" | awk '{print $5}'\
														   | tr -dc '0-9')
		;;

	 5)
		new_size=$(ls -l --block-size=KB | grep "v1_5.png" | awk '{print $5}'\
														   | tr -dc '0-9')
		;;

	 *)
		new_size=-1
		echo "This should never be reached!"
		;;
	esac
	
	#compare
	x=0
	echo "Maximum size $max_new_size, actual size $new_size"
	if [ $new_size -le $max_new_size ]
	then
		x=1
	else
		x=0
	fi
	suma=$(($suma+$x))
	echo "$nr)...............................................[$x/1]"
done
echo "Total............................................[$suma/5]"


