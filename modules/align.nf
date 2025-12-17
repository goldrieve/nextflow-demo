process ALIGN {
    publishDir "${params.outdir}/aligned", mode:'copy'
    
    input:
        tuple val(meta), path(reads)
        path params.ref

    output:
        tuple val(meta), path("${meta.prefix}_sorted.bam"), emit: bam

    script:
        """
        bwa mem ${params.ref} ${reads[0]} ${reads[1]} |
        samtools view -bS - | \
        samtools sort - -o ${meta.prefix}_sorted.bam
        """
}