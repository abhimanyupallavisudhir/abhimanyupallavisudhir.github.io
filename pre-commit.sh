#!/bin/sh

# Copy relevant/cv.pdf to the root directory as relevant.pdf
cp -f cv/relevant/cv.pdf cv/relevant.pdf
cp -f cv/extended/cv.pdf cv/extended.pdf

# run pandoc conversions
pandoc -s --toc cv/relevant/cv.tex -o cv/relevant.html
# pandoc -s --toc --template="C:\Users\abhim\Google Drive\Gittable\Code\abhimanyupallavisudhir.github.io\cv\cv_template.html" cv/relevant/cv.tex -o cv/relevant.html 
pandoc -s cv/relevant/cv.tex -o cv/relevant.docx
pandoc -s cv/relevant.docx -o cv/relevant_docx.pdf

# keep a synced version of pre-commit for future use
cp ".git/hooks/pre-commit" pre-commit.sh

# Add relevant.pdf to the staging area so that it gets committed
git add cv/relevant.pdf
git add cv/extended.pdf
git add cv/relevant.html
git add cv/relevant.docx
git add cv/relevant_docx.pdf
git add pre-commit.sh

# Check if the copy succeeded
if [ $? -ne 0 ]; then
 echo "Failed a precommit operation (see git/hooks/pre-commit)"
 exit 1
else
 echo "Succeeded precommit operations"
fi