rm -rf plots
mkdir plots

echo "****************************** SIGNIFICANCE ****************************"

python plot_significance_B2G16007.py JJLVJHVT13TeV 
python plot_significance_B2G16007.py ALLHVT13TeV 
python plot_significance_B2G16007.py ALLWVHVT8TeV 
python plot_significance_B2G16007.py ALLWVHVT138TeV 
python plot_significance_B2G16007.py ALLHVHVT8TeV 
python plot_significance_B2G16007.py ALLHVHVT138TeV
python plot_significance_B2G16007.py ALLHVT8TeV 
python plot_significance_B2G16007.py ALLHVT138TeV 

echo "****************************** LIMITS ****************************"

python plot_limits_B2G16007.py JJLVJHVT13TeV 
python plot_limits_B2G16007.py ALLHVT13TeV 
python plot_limits_B2G16007.py ALLWVHVT8TeV 
python plot_limits_B2G16007.py ALLHVHVT8TeV 
python plot_limits_B2G16007.py ALLHVT8TeV 

echo "****************************** SIGNAL STRENGHT ****************************"

python plot_signal_strenght_B2G16007.py ALLWVHVT138TeV 
python plot_signal_strenght_B2G16007.py ALLHVHVT138TeV
python plot_signal_strenght_B2G16007.py ALLHVT138TeV 
python compare_combinations.py ALLHVT
