for M in $( cat masses.txt ); do ./prepareCombinedCardsAndWS.sh $M ; done

rm comb_job.*
rm comb_*/output_* -r
rm -r comb_*/logs
rm -rf harvestedTrees/

# 13 TeV LVJ+JJ
for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M JJLVJZPRIME13; done
for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLZPRIME13; done
for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lljnnjzh13; done
for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lvjww13; done
for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M jjwwzh13; done

for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M JJLVJZPRIME13; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLZPRIME13; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lljnnjzh13; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lvjww13; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M jjwwzh13; done

./mergeHarvestedCombinationTrees.sh JJLVJZPRIME13
./mergeHarvestedCombinationTrees.sh ALLZPRIME13
./mergeHarvestedCombinationTrees.sh lljnnjzh13
./mergeHarvestedCombinationTrees.sh lvjww13
./mergeHarvestedCombinationTrees.sh jjwwzh13

# 8 TeV LLLV+LLJ+LVJ+JJ (WV) done!
for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLWVZPRIME8; done
for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lvjww8; done
for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M jjwwzh8; done
for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lljzh8; done

for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLWVZPRIME8; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lvjww8; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M jjwwzh8; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lljzh8; done

./mergeHarvestedCombinationTrees.sh ALLWVZPRIME8
./mergeHarvestedCombinationTrees.sh lvjww8
./mergeHarvestedCombinationTrees.sh jjwwzh8
./mergeHarvestedCombinationTrees.sh lljzh8

#8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLWVZPRIME138; done

for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLWVZPRIME138; done

./mergeHarvestedCombinationTrees.sh ALLWVZPRIME138

#8 TeV VH only
for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLHVZPRIME8; done
for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ttjzh8; done
for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M jjzh8; done

for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLHVZPRIME8; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ttjzh8; done
for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M jjzh8; done

./mergeHarvestedCombinationTrees.sh ALLHVZPRIME8
./mergeHarvestedCombinationTrees.sh ttjzh8
./mergeHarvestedCombinationTrees.sh jjzh8

#8+13 TeV VH only
for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLHVZPRIME138; done

for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLHVZPRIME138; done

./mergeHarvestedCombinationTrees.sh ALLHVZPRIME138

#8 TeV VH+WV
for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLZPRIME8; done

for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLZPRIME8; done

./mergeHarvestedCombinationTrees.sh ALLZPRIME8

#8 + 13 TeV VH+WV
for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLZPRIME138; done

for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLZPRIME138; done

./mergeHarvestedCombinationTrees.sh ALLZPRIME138

mkdir results
mv higgsCombine* results/.

#make plots
./run-all-plots.sh
