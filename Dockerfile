FROM ubuntu:24.04

# METADATA #

LABEL base.image=ubuntu:24.04
LABEL software="nextflow-demo"
LABEL about.summary="A demo nextflow pipeline"
LABEL about.documentation="https://github.com/goldrieve/nextflow-demo"
LABEL about.tags="WGS, Genomics"

# DEPENDENCIES #

RUN apt-get -y update && apt-get install --yes --no-install-recommends \
	wget
