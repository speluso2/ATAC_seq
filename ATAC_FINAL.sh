#!/bin/sh
#$ -N ATAC
#$ -cwd
#$ -l h_rt=48:00:00
#$ -l h_vmem=30G


. /etc/profile.d/modules.sh

module load igmm/apps/python/2.7.10
module load igmm/apps/bowtie/2.2.6
module load igmm/libs/ncurses/6.0
module load igmm/apps/samtools/1.3
module load java/jdk/1.8.0
module load igmm/apps/BEDTools/2.23.0
module load igmm/apps/picard/1.139


cutadapt -a CTGTCTCTTATACACATCTCCGAGCCCACGAGACGGACTCCTATCTCGT  -A CTGTCTCTTATACACATCTGACGCTGCCGACGAGTGTAGATCTCGGTGGT -o trimmed_ESCplusRA48hrP23_forward.fastq -p trimmed_ESCplusRA48hrP23_reverse.fastq  201230_X591_FCHF2YLCCX2_L3_ESCplusRA48hrP23_1.fq 201230_X591_FCHF2YLCCX2_L3_ESCplusRA48hrP23_2.fq

bowtie2 -p 8 -x mm9/genome -1 trimmed_ESCplusRA48hrP23_forward.fastq -2 trimmed_ESCplusRA48hrP23_reverse.fastq -S ESCplusRA48hrP23_paired_align.sam


awk '$3!="chrM" && $3!="*" {print}' ESCplusRA48hrP23_paired_align.sam > ESCplusRA48hrP23_subMitoUnc.sam

samtools view -bS ESCplusRA48hrP23_subMitoUnc.sam > ESCplusRA48hrP23_subMitoUnc.bam

samtools sort ESCplusRA48hrP23_subMitoUnc.bam -o ESCplusRA48hrP23_subMitoUnc_sorted.bam

samtools rmdup ESCplusRA48hrP23_subMitoUnc_sorted.bam ESCplusRA48hrP23_sorted_filtered.bam

bedtools bamtobed -i ESCplusRA48hrP23_sorted_filtered.bam > ESCplusRA48hrP23_sorted_filtered.bed

awk 'BEGIN {OFS = "\t"} ; {if ($6 == "+") print $1, $2 + 4, $3 + 4, $4, $5, $6; else print $1, $2 - 5, $3 - 5, $4, $5, $6}' ESCplusRA48hrP23_sorted_filtered.bed > ESCplusRA48hrP23_sorted_filtered_shift.bed

bedtools bedtobam -i ESCplusRA48hrP23_sorted_filtered_shift.bed -g /exports/eddie/scratch/speluso2/from_hill-lab/to_scratch/mm9_bed.txt > ESCplusRA48hrP23_sorted_filtered_shift.bam

samtools sort ESCplusRA48hrP23_sorted_filtered_shift.bam > ESCplusRA48hrP23_sorted_filtered_shift_sorted.bam

samtools index ESCplusRA48hrP23_sorted_filtered_shift_sorted.bam ESCplusRA48hrP23_sorted_filtered_shift_sorted.bam.bai

bedtools genomecov -ibam ESCplusRA48hrP23_sorted_filtered_shift_sorted.bam -bg -split -g mm9 > rESCplusRA48hrP23_final.bedGraph

LC_COLLATE=C sort -k1,1 -k2,2n rESCplusRA48hrP23_final.bedGraph > rESCplusRA48hrP23_final_sorthed.bedGraph

bedGraphToBigWig rESCplusRA48hrP23_final_sorthed.bedGraph mm9.chr.sizes rESCplusRA48hrP23.bw

