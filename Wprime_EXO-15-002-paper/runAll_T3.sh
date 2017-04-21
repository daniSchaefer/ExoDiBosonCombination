#for M in $( cat masses.txt ); do ./prepareCombinedCardsAndWS.sh $M ; done

#rm comb_job.*
#rm comb_*/output_* -r
#rm -r comb_*/logs
#rm -rf harvestedTrees/

# 13 TeV LVJ+JJ
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M JJLVJWPRIME13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lvjwz13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M jjwz13; done

for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M JJLVJWPRIME13; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lvjwz13; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M jjwz13; done

./mergeHarvestedCombinationTrees.sh JJLVJWPRIME13
./mergeHarvestedCombinationTrees.sh lvjwz13
./mergeHarvestedCombinationTrees.sh jjwz13

mkdir results
mv higgsCombine* results/.

#make plots
#./run-all-plots.sh
