# grep is a regex parser

cat file | grep <REGEX PATTERN>
grep <REGEX PATTERN> file

# Common Options:
- c   : count number of occurrences
- m # : repeat match # times
- R   : recursively through directories
- o   : only print matching part of line
- n   : print the line number
- v   : invert match, print non-matching lines


# sed is a stream editor (i.e. find and replace)
cat file | sed <COMMAND> file
sed <COMMAND> file

# Common uses:
4d 					- delete line 4
2,4d 				- delete lines 2-4
2w foo				- write line 2 to file foo
/here/d 			- delete line matching here
/here/,/there/d 	- delete lines matching here to there
s/PATTERN/text/		- switch text matching PATTERN
/PATTERN/a\text		- append line with text after matching PATTERN
/PATTERN/c\text		- change line with text for matching PATTERN

# awk is a script language that turns text into records and fields
# that you can access as ad hoc database. can manipulate the records 
# or fields before they're displayed

cat file | awk <COMMAND>
awk <COMMAND> file

# Fields are separated by white space or by regex FS
# The fields are denoted $1, $2, ..., while $0 refers to the entire line.
# If FS is null, the input line is plit into one field per character.

# Records are separated by \n (new line), or by regex RS
# File: alpha.txt
alpha beta gamma
delta epsilon phi
other stuff here

awk '{print $1}' alpha.txt

# gives you:
alpha
delta
other

awk '{print $2}' alpha.txt

# gives you:
beta
epsilon
stuff

awk '{print $2, $1}' alpha.txt

# gives you:
beta alpha
epsilon delta
stuff other

awk '{print $1, $3}' alpha.txt

# gives you:
alpha gamma
delta phi
other here

awk '{print $0, $3}' alpha.txt

# gives you:
alpha beta gamma gamma
delta epsilon phi phi
other stuff here here

# awk internal environment variables
- NF	# number of fields in the current record
- NR 	# ordinal number of the current record
- FS 	# regular expression used to separate fields; also settable by option -Ffs (default whitespace)
- RS 	# input record separator (default newline)
- OFS 	# output field separator (default blank)
- ORS	# output record separator (default newline)

# File: alpha.txt
alpha beta gamma
delta epsilon phi
other stuff here

awk '{OFS=",";print $1, $3}' alpha.txt

# gives you
alpha,gamma
delta,phi
other,here

awk -Fa '{print $2}' alpha.txt

# gives you
lph
 epsilon phi

awk -Fa '{print $1}' alpha.txt

# gives you

delt
other stuff here

awk -Fe '{print $1}' alpha.txt

# gives you
alpha b
d
oth

awk -Fe '{print $2}' alpha.txt

# gives you
ta gamma
lta
r stuff h

# awk statements
# An action is a sequence of statements
# A statement can be one of the following:
- if (expression) statement [ else statement ]
- while (expression) statement
- for (expression ; expression ; expression) statement
- for (var in array) statement
- do statement while (expression)

# File: alpha.txt
alpha beta gamma
delta epsilon phi
other stuff here

awk '{if (NR > 1) print $2}' alpha.txt

# gives you
epsilon
stuff

awk '{if (NR > 2) print $2}' alpha.txt

# gives you
stuff

awk '{if (NR > 2) print $2}' alpha.txt

# gives you
other

awk '{if ($1 == "alpha") print}' alpha.txt

# gives you
alpha beta gamma

awk '{if ($1 == "delta") print}' alpha.txt

# gives you
delta epsilon phi

awk '{if (NR == 1) a=$1; else b=$1}END{print a, b}' alpha.txt

# gives you
alpha other

awk '{if ($1 == "[a-z]") ; sum+=1}END{print "Total: " sum}' alpha.txt

# gives you
Total: 3

# cool command showing a TON of stuff and not really very comprehensible
ps S -o pid,nlwp,%mem,rss,vsz,%cpu,cputime,args --forest -u $USER |\
awk '{pmem+=$3;rss+=$4;vsz+=$5; print $0}END{printf("MEM SUM: %4.1f%% %3.1fGB %3.1fGB \n", pmem,rss/1028/1028,vsz/1024/1024)}'

# run your scripts by calling "bash" on them as in: bash script.sh