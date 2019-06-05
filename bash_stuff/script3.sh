#!/bin/bash

j=0
# {} defines a range
for i in {01..05} ; do
		j=$((j+1)) # increment j
		alpha[$j]=$i # use j to index alpha array
		echo ${alpha[*]} # print all elements of alpha array
done