#this uses pdf2svg to convert a directory of pdfs to svgs
#if pdf2svg is not installed tell the user to sudo apt install pdf2svg
if ! [ -x "$(command -v pdf2svg)" ]; then
  echo 'Error: pdf2svg is not installed.' >&2
  echo 'Please install it with sudo apt install pdf2svg' >&2
  exit 1
fi

#check if directory is given and valid
if [ $# -eq 0 ]
  then
    echo "No directory supplied"
    exit 1
fi

if ! [ -d "$1" ]
  then
    echo "Argument is not a directory"
    exit 1
fi

#if no second arg, use default output dir adjacent to input dir
dirname=${1%/*}_svg

#convert all pdfs in directory to svgs in a new dir_svg directory
mkdir $dirname
for file in $1/*.pdf
do
    #split from last occurence of /
    filename=${file##*/}
    #remove .pdf
    filename=${filename%.pdf}
    #convert pdf to svg
    pdf2svg "$file" "$dirname/$filename.svg"
done
