#!/bin/bash -ue
trimmomatic PE -threads 1 SRR1390645_sub_1.fastq.gz SRR1390645_sub_2.fastq.gz phix_trimmed_1.fq.gz phixunpaired_1.fq.gz phix_trimmed_2.fq.gz phix_unpaired_2.fq.gz SLIDINGWINDOW:4:5 LEADING:5 TRAILING:5 MINLEN:25
