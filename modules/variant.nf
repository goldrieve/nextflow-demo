process VARIANT {
    publishDir "${params.outdir}/VCF", mode:'copy'
    
    input:
        tuple val(meta), path(bam)
        path (ref)
        val (quality)
        val (base_qual)
        val (ploidy)

    output:
        tuple val(meta), path("${meta.prefix}.vcf.gz"), emit: vcf

    script:
        """
        samtools index ${bam}
        bcftools mpileup -q ${quality} -Q ${base_qual} -a INFO/AD -Ou -f ${ref} ${bam} | \
            bcftools call --ploidy ${ploidy} -mf GQ - -Ou |
            bcftools norm -f ${ref} - -Oz -o ${meta.prefix}.vcf.gz
        bcftools index ${meta.prefix}.vcf.gz
        """
}