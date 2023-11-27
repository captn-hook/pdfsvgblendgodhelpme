#this uses pdftocairo to convert a directory of pdfs to svgs
#if pdftocairo is not installed tell the user to sudo apt install pdftocairo
if ! [ -x "$(command -v pdftocairo)" ]; then
  echo 'Error: pdftocairo is not installed.' >&2
  echo 'Please install it with sudo apt-get install python-poppler python texlive-extra-utils texlive' >&2
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
    #convert pdf to svg pdftocairo -svg SomePDFfile.pdf
    pdftocairo -svg "$file" "$dirname/$filename.svg"
done
