# Copyright Projet LAGADIC, 2004
#   http://www.irisa.fr/lagadic
#
#   File: Makefile
#   Author: Nicolas Mansard
#
#   Compilation des sources .tex en .dvi, .ps ...
#
#   Version Control
#     $Id: Makefile,v 1.3 2006/09/08 08:31:30 nmansard Exp $

RM := rm -f
MV := mv
CP := cp -f
AR := ar
TEX2PDF :=  pdflatex -interaction=nonstopmode
BIBTEX := bibtex
#BIBER := biber
BIBER := bibtex
GZIP := gzip -c
XDVI := xdvi -watchfile 0.5 -s 9
TGZ := tar -czvf 

# ---------------------------------------------
# --- REPERTOIRES -----------------------------
# ---------------------------------------------

PROJECT_DIR		= .
ROOT_DIR		= .
IMG_DIR      		= $(ROOT_DIR)
BIB_DIR   		=. 

# ---------------------------------------------
# --- OBJETS ----------------------------------
# ---------------------------------------------

OBJS	=	main
OBJS_SEC = 	introduction \
		odometry \
		experiments \
		conclusion


BIB	=	bib.bib

OBJS_TEX	=	$(OBJS:%=%.tex)
OBJS_DVI	=	$(OBJS:%=%.dvi)
OBJS_PS 	=	$(OBJS:%=%.ps)
OBJS_PS_GZ	=	$(OBJS:%=%.ps.gz)
OBJS_PDF	=	$(OBJS:%=%.pdf)

IMPRIMANTE	=	aragon # mCjaune0 #

TGZ_FILE        =       ../icra10.tgz

# ---------------------------------------------
# --- REGLES ----------------------------------
# ---------------------------------------------

# --->
# ---> Regle generale
# --->

.PHONY = all 
all: main.pdf

dvi: $(OBJS_DVI)

ps: $(OBJS_PS)

psgz: $(OBJS_PS_GZ)

pdf: $(OBJS_PDF)

print: $(OBJS_PS) 
	lpr -P $(IMPRIMANTE) $^
	@touch print

view: pdf
	evince $(OBJS_PDF) &

edit:
	emacs $(OBJS_TEX) $(OBJS2:%=%.tex) &
# --->
# ---> Regles generiques
# --->

bib: 
	$(TEX2PDF) $(OBJS)
	$(BIBER) $(OBJS)
	$(TEX2PDF) $(OBJS)

%.pdf: %.tex $(BIB) $(OBJS_SEC:%=%.tex)
	$(TEX2PDF) $<


# --->
# --->
# ---> Regles de nettoyage
# --->

.PHONY = clean
clean: 
	$(RM) *.aux *.blg *.dvi *.log *.bbl
	$(RM) *~ 
	$(RM) core 
	$(RM) print *.run.xml *.cb *.cb2 *.bcf *.out 
	$(RM) -r auto

.PHONY = clean_all
clean_all: clean 
	$(RM) *.ps *.pdf

.PHONY = tgz
tgz: $(TGZ_FILE)

$(TGZ_FILE): clean_all
	@echo "Creation de $@"
	$(TGZ) $(TGZ_FILE) .
