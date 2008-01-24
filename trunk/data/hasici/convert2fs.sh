#!/bin/bash

#mkdir fs

#cd pml

#for dir1 in *; do
#	cd $dir1

#	for f1 in *.t.pls.gz; do
#../../parsing_czech/tred_old/btred -m "../../format-conversions/pdt_formats/pml2netgraph.btred" pml/*/*.t.gz
#	done

#	cd ..
#done


cd pml

for dir1 in *; do
	cd $dir1

	for f1 in *.t.gz; do
#btred -m "../../format-conversions/pdt_formats/pml2netgraph.btred" pml/*/*.t.gz
#btred -m "../../format-conversions/pdt_formats/pml2netgraph.btred" $f1
../../../../parsing_czech/tred_old/btred -m "../../format-conversions/pdt_formats/pml2netgraph.btred" $f1
	done

	cd ..
done

cd..
 


