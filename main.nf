nextflow.enable.dsl = 2

params.outdir = "results"
params.ref = "$projectDir/tests/data/phix_genome.fasta"
params.samplesheet = "$projectDir/tests/data/samples.csv"
params.cores = 1
params.quality = 0
params.base_quality = 10
params.ploidy = 1

include { TRIM } from './modules/trim'
include { ALIGN } from './modules/align'
include { VARIANT } from './modules/variant'

workflow demo {
    main:

    ch_samplesheet = Channel.fromPath(params.samplesheet)

    ch_reads = ch_samplesheet
        .splitCsv(header: true)
        .map { row -> 
            def meta = [
                id: row.sample,
                prefix: row.sample
            ]
            def reads = [
                file(row.r1, checkIfExists: true),
                file(row.r2, checkIfExists: true)
            ]
            [ meta, reads ]
        }

    TRIM (
        ch_reads,
        params.cores
        )

    ALIGN (
        TRIM.out,
        params.ref
        )

    VARIANT (
        ALIGN.out,
        params.ref,
        params.quality,
        params.base_quality,
        params.ploidy
        )

    emit:
        VARIANT.out
}