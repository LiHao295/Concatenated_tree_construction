#1 align by muscle 
file=`ls path | grep .fasta$`
for i in $file; do muscle -in $i -out $i.fas; done
#2 remove ambiguously aligned C and N termini manually 

#3 remove columns composed of more than 95% gaps.
file=`ls path | grep .fasta2$`
for i in $file; do trimal -in $i -out $i.95 -gt 0.05; done
#4 concatenated the sequence
perl catfasta2phyml.pl -c -f *.fas.95 > concatenated_seqs.fas_95
#5 remove the taxs if their available sequence data represented less than 50%.
python count_gaps.py concatenated_seqs.fas_95 count.txt
perl extract_seqs.pl id.txt concatenated_seqs.fas_95 > concatenated_seqs.fas_95_50
#6 convert fas to phy 
python anl2phy.py concatenated_seqs.fas_95_50 concatenated_seqs.fas_95_50.phy
#7 phylogenetic tree construction
raxmlHPC-HYBRID_8.2.10_comet -N autoMRE -n result1 -s infile.txt 
-p 12345 -m PROTGAMMALGF -k -f a -x 12345 
