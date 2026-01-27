process LOG {
    publishDir "${params.outdir}/logs", mode:'copy'
    
    input:
        val dir

    output:
        path ("log.txt")

    script:
        """
        log.py $dir log.txt
        """
}