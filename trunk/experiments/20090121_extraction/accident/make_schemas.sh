mkdir accident
outf=accident/$line.xml

while read line; do
  echo '<?xml version="1.0"?>' > $outf
  echo '<schema xmlns="http://www.w3.org/2000/10/XMLSchema">' >> $outf
  echo '	<element name="'$line'" />' >> $outf
  echo '</schema>' >> $outf

  echo $line
done < list.txt