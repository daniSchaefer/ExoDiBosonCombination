#for M in $( cat masses.txt ); do ./prepareCombinedCardsAndWS.sh $M ; done

rm comb_job.*
rm comb_*/output_* -r
rm -r comb_*/logs
rm -rf harvestedTrees/

# 13 TeV LVJ+JJ
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M JJLVJZPRIME13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lvjww13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M jjww13; done

for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M JJLVJZPRIME13; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lvjww13; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M jjww13; done

./mergeHarvestedCombinationTrees.sh JJLVJZPRIME13
./mergeHarvestedCombinationTrees.sh lvjww13
./mergeHarvestedCombinationTrees.sh jjww13

mkdir results
mv higgsCombine* results/.

#make plots
#./run-all-plots.sh
