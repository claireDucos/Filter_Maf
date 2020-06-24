#!/bin/bash

awk '{print $1*100, $2,$3,$4}' $1 | awk '{print $1/450, $2,$3,$4}'> count_pourcent.csv
awk ' $1<5{print $1,$2,$3,$4}' count_pourcent.csv  > variant_count_filter.csv
awk 'NR==FNR{pos[$3]; all[$4]; chrom[$2]; next} $5 in chrom && $6 in pos && $12 in all' variant_count_filter.csv $2 > maftmp.csv
# On fait une recher de la liste des variants presents chez moins de 400 dans le fichier maf

echo 'Hugo_symbol Entrez_Gene_Id Center NCBI_Build Chromosome Start_Position End_Position Strand Variant_Classification Variant_Type Reference_Allele Tumor_Seq_Allele1 Tumor_Seq_Allele2 dbSNP_RS dbSNP_Val_Status Tumor_Sample_Barcode Matched_Norm_Seq_Allele1 Match_Norm_Seq_Allele2 Tumor_Validation_Allele1 Tumor_Validation_Allele2 Match_Norm_Validation_Allele Match_Norm_Validation_Allele2 Verification_Status Validation_Status Mutation_Status Sequencing_Phase Sequence_Source Validation_Method Score BAM_File Sequencer HGVSc  HGVSp Exon_number Gene Feature Feature_type cDNA_position CDS_position protein_position SIFT PolyPhen PubMed AN AC AF DP set' | sed 's/ /\t/g' | cat - maftmp.csv > $3

rm maftmp.csv