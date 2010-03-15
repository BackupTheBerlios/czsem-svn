while read line; do
	echo '<HIDDEN-AUTOINSTANCE><PARAM NAME="xmlFileUrl" VALUE="resources/schema/accident/'$line'.xml" /></HIDDEN-AUTOINSTANCE>'
done < list.txt