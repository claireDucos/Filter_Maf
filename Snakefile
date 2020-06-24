import glob
include: "rules/filter.smk"

rule all:
    input:
        vcf_filtre = "results/maf.csv"
    message:
        "Finishig filter pipeline"