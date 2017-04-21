#for M in $( cat masses.txt ); do ./prepareCombinedCardsAndWS.sh $M ; done

rm comb_job.*
rm comb_*/output_* -r
rm -r comb_*/logs
rm -rf harvestedTrees/

# 13 TeV LVJ+JJ
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M JJLVJWPRIME13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLWPRIME13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lvjwh13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lvjwzh13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M jjwzwh13; done

for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M JJLVJWPRIME13; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLWPRIME13; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lvjwh13; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lvjwzh13; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M jjwzwh13; done

./mergeHarvestedCombinationTrees.sh JJLVJWPRIME13
./mergeHarvestedCombinationTrees.sh ALLWPRIME13
#./mergeHarvestedCombinationTrees.sh lvjwh13
./mergeHarvestedCombinationTrees.sh lvjwzh13
#./mergeHarvestedCombinationTrees.sh jjwzwh13

# 8 TeV LLLV+LLJ+LVJ+JJ (WV)
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLWVWPRIME8; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lvjwz8; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M jjwzwh8; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lljwz8; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lllv8; done

#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLWVWPRIME8; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lvjwz8; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M jjwzwh8; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lljwz8; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lllv8; done

#./mergeHarvestedCombinationTrees.sh ALLWVWPRIME8
#./mergeHarvestedCombinationTrees.sh lvjwz8
#./mergeHarvestedCombinationTrees.sh jjwzwh8
#./mergeHarvestedCombinationTrees.sh lljwz8
#./mergeHarvestedCombinationTrees.sh lllv8

#8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLWVWPRIME138; done

for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLWVWPRIME138; done

./mergeHarvestedCombinationTrees.sh ALLWVWPRIME138

#8 TeV VH only
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLHVWPRIME8; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ttjwh8; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M jjwh8; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lvjwh8; done

#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLHVWPRIME8; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ttjwh8; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M jjwh8; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lvjwh8; done

#./mergeHarvestedCombinationTrees.sh ALLHVWPRIME8
#./mergeHarvestedCombinationTrees.sh ttjwh8
#./mergeHarvestedCombinationTrees.sh jjwh8
#./mergeHarvestedCombinationTrees.sh lvjwh8

#8+13 TeV VH only
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLHVWPRIME138; done

#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLHVWPRIME138; done

#./mergeHarvestedCombinationTrees.sh ALLHVWPRIME138

#8 TeV VH+WV
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLWPRIME8; done

#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLWPRIME8; done

#./mergeHarvestedCombinationTrees.sh ALLWPRIME8

#8 + 13 TeV VH+WV
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLWPRIME138; done

for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLWPRIME138; done

./mergeHarvestedCombinationTrees.sh ALLWPRIME138

#mkdir results
mv higgsCombine* results/.

#make plots
./run-all-plots.sh
