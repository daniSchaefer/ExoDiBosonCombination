#for M in $( cat masses.txt ); do ./prepareCombinedCardsAndWS.sh $M ; done

rm comb_job.*
rm comb_*/output_* -r
rm -r comb_*/logs
rm -rf harvestedTrees/

# 13 TeV LVJ+JJ
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M JJLVJHVT13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLHVT13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M leptvh13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lvjwvh13; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M jjwvvh13; done

#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M JJLVJHVT13; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLHVT13; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M leptvh13; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lvjwvh13; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M jjwvvh13; done

#./mergeHarvestedCombinationTrees.sh JJLVJHVT13
#./mergeHarvestedCombinationTrees.sh ALLHVT13
#./mergeHarvestedCombinationTrees.sh leptvh13
#./mergeHarvestedCombinationTrees.sh lvjwvh13
#./mergeHarvestedCombinationTrees.sh jjwvvh13

# 8 TeV LLLV+LLJ+LVJ+JJ (WV) done!
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLWVHVT8; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lvjwv8; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M jjwvvh8; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lljwzh8; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lllv8; done

#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLWVHVT8; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lvjwv8; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M jjwvvh8; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lljwzh8; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lllv8; done

./mergeHarvestedCombinationTrees.sh ALLWVHVT8
./mergeHarvestedCombinationTrees.sh lvjwv8
./mergeHarvestedCombinationTrees.sh jjwvvh8
./mergeHarvestedCombinationTrees.sh lljwzh8
./mergeHarvestedCombinationTrees.sh lllv8

#8 + 13 TeV LLLV+LLJ+LVJ+JJ (WV)
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLWVHVT138; done

#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLWVHVT138; done

./mergeHarvestedCombinationTrees.sh ALLWVHVT138

#8 TeV VH only
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLHVHVT8; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ttjvh8; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M jjvh8; done
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M lvjwh8; done

#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLHVHVT8; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ttjvh8; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M jjvh8; done
#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M lvjwh8; done

#./mergeHarvestedCombinationTrees.sh ALLHVHVT8
#./mergeHarvestedCombinationTrees.sh ttjvh8
#./mergeHarvestedCombinationTrees.sh jjvh8
#./mergeHarvestedCombinationTrees.sh lvjwh8

#8+13 TeV VH only
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLHVHVT138; done

#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLHVHVT138; done

#./mergeHarvestedCombinationTrees.sh ALLHVHVT138

#8 TeV VH+WV
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLHVT8; done

#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLHVT8; done

./mergeHarvestedCombinationTrees.sh ALLHVT8

#8 + 13 TeV VH+WV
#for M in $( cat masses.txt ); do ./parallelizeCombine_T3.sh $M ALLHVT138; done

#for M in $( cat masses.txt ); do ./mergeCombinationTrees.sh $M ALLHVT138; done

./mergeHarvestedCombinationTrees.sh ALLHVT138

##mkdir results
#mv higgsCombine* results/.

#make plots
#./run-all-plots.sh
