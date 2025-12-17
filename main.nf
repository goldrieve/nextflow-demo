nextflow.enable.dsl = 2

params.reads = 'tests/data/SRR1398382_1.fastq.gz'
params.outdir = 'results'
params.genome = 'tests/data/phix_genome.fasta'
params.samplesheet = 'tests/data/samples.csv'
params.cores = 1

include { TRIM } from './modules/trim'

workflow {
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
}