data/%.rda:data/%.R
	Rscript -e "source('$<')"

DATA_FILES = $(wildcard data/*.R)
DATA_RDA = $(DATA_FILES:R=rda)

all:$(DATA_RDA)

clean:
	rm -f $(DATA_RDA)
