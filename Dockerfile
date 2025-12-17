FROM ubuntu:24.04

# METADATA #

LABEL base.image=ubuntu:24.04
LABEL software="nextflow-demo"
LABEL about.summary="A demo nextflow pipeline"
LABEL about.documentation="https://github.com/goldrieve/nextflow-demo"
LABEL about.tags="WGS, Genomics"

# DEPENDENCIES #

RUN apt-get -y update && apt-get install --yes --no-install-recommends \
	wget \
	curl \
	git \
	unzip \
	default-jre \
	samtools \
	bwa

RUN wget https://github.com/usadellab/Trimmomatic/releases/download/v0.40/Trimmomatic-0.40.zip --no-check-certificate && \
	unzip Trimmomatic-0.40.zip && rm Trimmomatic-0.40.zip && \
	ln -s $PWD/trimmomatic-0.40.jar /usr/local/bin/trimmomatic.jar