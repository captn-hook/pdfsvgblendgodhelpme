#small tool to remove first x characters from all files in a directory
#arg 1: number of characters to remove
#arg 2: directory to work in

#check if arguments are given
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 1
fi

#check if first argument is a number
if ! [[ $1 =~ ^[0-9]+$ ]]
  then
    echo "First argument is not a number"
    exit 1
fi

#check if second argument is a directory
if ! [ -d "$2" ]
  then
    echo "Second argument is not a directory"
    exit 1
fi

for file in $2/*
do
    #split from last occurence of /
    filename=${file##*/}
    #remove first x characters
    newfilename=${filename:$1}
    #rename file
    mv "$file" "$2/$newfilename"
done