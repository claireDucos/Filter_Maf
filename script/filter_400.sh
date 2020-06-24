#!/bin/bash

awk ' $1<400{print $1,$2,$3,$4}' $1  > variant_count_filter.csv
# Recherche la liste des variants qui sont retrouves chez moins de 400 individus

awk '$12~","{a=split($12,ens,","); b=split($10,type,",") ; c=split($46,ac,",") ; d=split($47,af,",");for (i=1;i<=a;i++) {$12=ens[i]; $10=type[i];$46=ac[i];$47=af[i]; print};next}1' $2 | sed 's/ /\t/g' > tmp.csv
# Traite les lignes avec sites multialleliques (donc par exemple si ALT = A, ACA alors on dédouble la ligne, une pour chaque site allelique)
# sed pour remplacer tous les espaces par une tabulation

awk 'NR==FNR{pos[$3]; all[$4]; chrom[$2]; next} $5 in chrom && $6 in pos && $12 in all' variant_count_filter.csv tmp.csv > col.csv
# On fait une recher de la liste des variants presents chez moins de 400 dans le fichier maf

echo 'Hugo_symbol Entrez_Gene_Id Center NCBI_Build Chromosome Start_Position End_Position Strand Variant_Classification Variant_Type Reference_Allele Tumor_Seq_Allele1 Tumor_Seq_Allele2 dbSNP_RS dbSNP_Val_Status Tumor_Sample_Barcode Matched_Norm_Seq_Allele1 Match_Norm_Seq_Allele2 Tumor_Validation_Allele1 Tumor_Validation_Allele2 Match_Norm_Validation_Allele Match_Norm_Validation_Allele2 Verification_Status Validation_Status Mutation_Status Sequencing_Phase Sequence_Source Validation_Method Score BAM_File Sequencer HGVSc  HGVSp Exon_number Gene Feature Feature_type cDNA_position CDS_position protein_position SIFT PolyPhen PubMed AN AC AF DP set' | sed 's/ /\t/g' | cat - col.csv > $3

rm tmp.csv col.csv

