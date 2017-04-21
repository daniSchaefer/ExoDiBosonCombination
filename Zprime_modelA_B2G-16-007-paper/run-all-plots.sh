rm -rf plots
mkdir plots

echo "****************************** SIGNIFICANCE ****************************"

python plot_significance_B2G16007.py JJLVJZPRIME13TeV 
python plot_significance_B2G16007.py ALLZPRIME13TeV 
python plot_significance_B2G16007.py ALLWVZPRIME8TeV 
python plot_significance_B2G16007.py ALLWVZPRIME138TeV 
python plot_significance_B2G16007.py ALLHVZPRIME8TeV 
python plot_significance_B2G16007.py ALLHVZPRIME138TeV 
python plot_significance_B2G16007.py ALLZPRIME8TeV 
python plot_significance_B2G16007.py ALLZPRIME138TeV 

echo "****************************** LIMITS ****************************"

python plot_limits_B2G16007.py JJLVJZPRIME13TeV 
python plot_limits_B2G16007.py ALLZPRIME13TeV
python plot_limits_B2G16007.py ALLWVZPRIME8TeV 
python plot_limits_B2G16007.py ALLHVZPRIME8TeV 
python plot_limits_B2G16007.py ALLZPRIME8TeV 

echo "****************************** SIGNAL STRENGHT ****************************"

python plot_signal_strenght_B2G16007.py ALLWVZPRIME138TeV 
python plot_signal_strenght_B2G16007.py ALLHVZPRIME138TeV 
python plot_signal_strenght_B2G16007.py ALLZPRIME138TeV 
python compare_combinations.py ALLZPRIME
