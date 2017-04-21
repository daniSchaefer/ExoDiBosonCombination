#for M in $( cat masses.txt ); do ./prepareCombinedCardsAndWS_B2G16007.sh $M ; done

rm comb_job*
rm comb_*/output_* -r
rm -r comb_*/logs/
rm -rf harvestedTrees

#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M xww13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M xjj13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M xww; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M xzz; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M xjj8; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALL; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALL13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALL8; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALL813; done

for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M xww13; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M xjj13; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M xww; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M xzz; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M xjj8; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALL13; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALL8; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALL813; done

./mergeHarvestedCombinationTrees.sh xww13
./mergeHarvestedCombinationTrees.sh xjj13
./mergeHarvestedCombinationTrees.sh xww
./mergeHarvestedCombinationTrees.sh xzz
./mergeHarvestedCombinationTrees.sh xjj8
./mergeHarvestedCombinationTrees.sh ALL8
./mergeHarvestedCombinationTrees.sh ALL13
./mergeHarvestedCombinationTrees.sh ALL813

#mkdir results
#mv higgsCombine* results/.

#make plots
#./run-all-plots.sh