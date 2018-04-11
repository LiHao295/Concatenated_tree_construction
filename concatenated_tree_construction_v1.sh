##########################################
#####      Summarized by Li Hao      #####
#####           20160615             #####
#####      lihao@stu.xmu.edu.cn      #####
##########################################


### Warning: You should install the softwares in your PC or workstation before using.

###1 Align：MAFFT
file=`ls pwd | grep .fasta$`
for i in $file; do mafft --auto $i > $i.fas; done

###2 Selection of conserved regions, and concatenate genes :Gblocks
Gblocks path.txt -t=p -b5=h -a=y -c=y -w=y

###3 Converting .fas to .phy

python aln2phy.py

###4 Tree construction：RAxML
raxmlHPC-PTHREADS -T 50 --silent -x 12345 -p 12345 -#100 -m PROTGAMMAAUTO --auto-prot=aic -s in.phy -f a -o outgroup -n out.nwk
