  #!/bin/bash          


SCAN_DIR=$(mktemp -d)

echo $SCAN_DIR


COUNTER=0

while [ 1 ]
do
	echo "Page scanned so far $COUNTER"
	echo "Change page and press enter y or press n complete"
           
	read OPTIONS

       if [ "$OPTIONS" = "n" ]; then
	break
       elif [ "$OPTIONS" = "y" ]; then
        hp-scan --dest=file --file="$SCAN_DIR/scan-$COUNTER.pdf"
     	let COUNTER=COUNTER+1 
       else
        clear
       fi

done

echo "Aggregating to single pdf $COUNTER page(s) to ~/output.pdf (please mv before re-running";
pdftk $SCAN_DIR/* output ~/output.pdf;



 


