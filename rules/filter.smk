rule count_variant:
    output:
        "results/unique_variant_count.csv"
    message:
        "Create file unique_count_var"
    threads:
        1
    resources:
        mem_mb = (
            lambda wildcards, attempt: min(attempt * 2048 + 2048, 8192)
        ),
        time_min = (
            lambda wildcards, attempt: min(attempt * 60, 120)
        )
    log:
        "logs/count_unique.log"
    shell:
        "sh script/count_variants.sh {output}"



rule filtre_un_400:
    input:
        maf=temp("maf/final_maf.csv"),
        count="results/unique_variant_count.csv"
    output:
        temp("results/maf400.csv")
    message:
        "Filter variant retreve in less than 400 subjects"
    threads:
        1
    resources:
        mem_mb = (
            lambda wildcards, attempt: min(attempt * 2048 + 2048, 8192)
        ),
        time_min = (
            lambda wildcards, attempt: min(attempt * 60, 120)
        )
    log:
        "logs/filtre400.log"

    shell:
          "sh script/filter_400.sh {input.count} {input.maf} {output}"


rule filtre_2_maf:
    input:
        maf="results/maf400.csv",
        count="results/unique_variant_count.csv"
    output:
        temp("results/mafMAF.csv")
    message:
        "Filter variant : Minor allele Frequency"
    threads:
        1
    resources:
        mem_mb = (
            lambda wildcards, attempt: min(attempt * 2048 + 2048, 8192)
        ),
        time_min = (
            lambda wildcards, attempt: min(attempt * 60, 120)
        )
    log:
        "logs/filtre_MAF.log"

    shell:
          "sh script/maf.sh {input.count} {input.maf} {output}"

rule filtre_3_Vaf:
    input:
        maf="results/mafMAF.csv"
    output:
        "results/maf.csv"
    message:
        "Filter variant : Minor allele Frequency"
    threads:
        1
    resources:
        mem_mb = (
            lambda wildcards, attempt: min(attempt * 2048 + 2048, 8192)
        ),
        time_min = (
            lambda wildcards, attempt: min(attempt * 60, 120)
        )
    log:
        "logs/filtre_MAF.log"

    shell:
          "awk ' $47>0.1{{print}}' {input}  > {output}"



