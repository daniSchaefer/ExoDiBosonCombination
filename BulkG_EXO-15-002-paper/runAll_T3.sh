#for M in $( cat masses.txt ); do ./prepareCombinedCardsAndWS_B2G16007.sh $M ; done

rm comb_job*
rm comb_*/output_* -r
rm -r comb_*/logs/
rm -rf harvestedTrees

#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M xww13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M xjj13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M xjj13zz; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M xjj13ww; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALL13; done

for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M xww13; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M xjj13; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M xjj13ww; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M xjj13zz; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALL13; done

./mergeHarvestedCombinationTrees.sh xww13
./mergeHarvestedCombinationTrees.sh xjj13
./mergeHarvestedCombinationTrees.sh xjj13ww
./mergeHarvestedCombinationTrees.sh xjj13zz
./mergeHarvestedCombinationTrees.sh ALL13

mkdir results
mv higgsCombine* results/.

#make plots
#./run-all-plots.sh
