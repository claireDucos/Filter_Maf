#!/bin/bash

find "${PWD}/vcf" -type f -name "*.vcf" | while read VCF; do
	cut -f 1,2,5 "${VCF}" | grep  -vP "^#"
done | awk '{print $1,$2,$3,$4}' | awk '$4 ~ "," {n=split($4,a,",");for (i=1;i<=n;i++) {$4=a[i];print};next}1' | sort | uniq -c > $1

