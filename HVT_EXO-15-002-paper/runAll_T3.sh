#for M in $( cat masses.txt ); do ./prepareCombinedCardsAndWS.sh $M ; done

rm comb_job.*
rm comb_*/output_* -r
rm -r comb_*/logs
rm -rf harvestedTrees/

# 13 TeV LVJ+JJ
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M JJLVJHVT13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lvjwv13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M jjwv13; done

for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M JJLVJHVT13; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lvjwv13; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M jjwv13; done

./mergeHarvestedCombinationTrees.sh JJLVJHVT13
./mergeHarvestedCombinationTrees.sh lvjwv13
./mergeHarvestedCombinationTrees.sh jjwv13

#mkdir results
mv higgsCombine* results/.

#make plots
#./run-all-plots.sh
