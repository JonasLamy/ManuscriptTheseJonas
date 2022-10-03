#!/bin/bash

programName=$0

function usage {
    echo "usage: $programName [Chap1 Chap2 ...] or [All]"
    echo "--- individual chapter compilation ---"
    echo "Chap1 : Introduction"
    echo "Chap2 : Contexte"
    echo "Chap3 : Etat de l'art"
    echo "Chap4 : Benchmark"
    echo "Chap5 : Analyse du rehaussement"
    echo "Chap6 : Diffusion et reproductibilité"
    echo "--- All chapters compilation ---"
    echo "All equal to : ./makeThesis Chap1 Chap2 Chap3 Chap4 Chap5 Chap6"

    exit 0
}

[ -z $1 ] && { usage; }


s=""

sC1='\\input{Chapters/Chapter1-Introduction}\n'
sC2='\\input{Chapters/Chapter2-Contexte}\n'
sC3='\\input{Chapters/Chapter3-Etat_de_l_art}\n'
sC4='\\input{Chapters/Chapter4-Benchmark}\n'
sC5='\\input{Chapters/Chapter5-Analyse-du-rehaussement}\n'
sC6='\\input{Chapters/Chapter6-Reproductibilite_diffusion}\n'

sAll+="$sC1$sC2$sC3$sC4$sC5$sC6"


for i in $@
do
    echo $i

    if [[ $i == "Chap1" ]]; then
	s+=$sC1
    fi
    
    if [[ $i == "Chap2" ]]; then
	s+=$sC2
    fi
    
    if [[ $i == "Chap3" ]]; then
	s+=$sC3
    fi

    if [[ $i == "Chap4" ]]; then
	s+=$sC4
    fi

    if [[ $i == "Chap5" ]]; then
	s+=$sC5
    fi
    
    if [[ $i == "Chap6" ]]; then
	s+=$sC6
    fi

    if [[ $i == "All" ]]; then
	s+=$sAll
	break
    fi
done
echo "--------"
echo $s
cat my-thesis_template.tex | awk -v srch="#Magic" -v repl="$s" '{sub(srch,repl,$0);print $0}' > TheseJonas.tex

pdflatex TheseJonas.tex
biber TheseJonas
pdflatex TheseJonas.tex

#rm *.lot
#rm *.lol
#rm *.out
#rm *.aux
#rm *.lof
#rm *.toc
#rm *.bbl
