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

# Get the file size of the output using the du and cut commands:
filesize=$(du -k ~/output.pdf | cut -f1)

echo "Would you like the pdf to be compressed (file size is $filesize)? (y for yes)"
read OPTIONS

if [ "$OPTIONS" = "y" ]; then
  #attempt compressions by converting to large ps file and then back to pdf
  pdf2ps ~/output.pdf ~/output.ps
  ps2pdf ~/output.ps ~/output.pdf
  rm ~/output.ps

  filesize=$(du -k ~/output.pdf | cut -f1)
  echo "Compressed file size is now $filesize)"

fi


 


