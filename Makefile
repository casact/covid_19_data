data/%.rda:data/%.R
	Rscript -e "source('$<')"

%.html:%.ipynb
	jupyter nbconvert --to HTML --execute $<

DATA_FILES = $(wildcard data/*.R)
DATA_RDA = $(DATA_FILES:R=rda)

NOTEBOOKS = $(wildcard eda/*.ipynb) $(wildcard model/*.ipynb)
NOTEBOOKS_OUT = $(NOTEBOOKS:ipynb=html)

all:$(DATA_RDA) $(NOTEBOOKS_OUT)

clean:
	rm -f $(DATA_RDA)
	rm -f $(NOTEBOOKS_OUT)
