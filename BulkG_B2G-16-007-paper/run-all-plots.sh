rm -rf plots
mkdir plots

echo "****************************** SIGNIFICANCE ****************************"

python plot_significance_B2G16007.py ALL13TeV 
python plot_significance_B2G16007.py ALL8TeV
python plot_significance_B2G16007.py ALL813TeV

echo "****************************** LIMITS ****************************"

python plot_limits_B2G16007.py ALL13TeV 
python plot_limits_B2G16007.py ALL8TeV  

echo "****************************** SIGNAL STRENGHT ****************************"

python plot_signal_strenght_B2G16007.py ALL813TeV 
python compare_combinations.py ALL
