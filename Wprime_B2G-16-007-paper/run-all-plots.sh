rm -rf plots
mkdir plots

echo "****************************** SIGNIFICANCE ****************************"

python plot_significance_B2G16007.py JJLVJWPRIME13TeV
python plot_significance_B2G16007.py ALLWPRIME13TeV
python plot_significance_B2G16007.py ALLWVWPRIME8TeV
python plot_significance_B2G16007.py ALLWVWPRIME138TeV
python plot_significance_B2G16007.py ALLHVWPRIME8TeV
python plot_significance_B2G16007.py ALLHVWPRIME138TeV
python plot_significance_B2G16007.py ALLWPRIME8TeV
python plot_significance_B2G16007.py ALLWPRIME138TeV

echo "****************************** LIMITS ****************************"

python plot_limits_B2G16007.py JJLVJWPRIME13TeV
python plot_limits_B2G16007.py ALLWPRIME13TeV
python plot_limits_B2G16007.py ALLWVWPRIME8TeV
python plot_limits_B2G16007.py ALLHVWPRIME8TeV
python plot_limits_B2G16007.py ALLWPRIME8TeV

echo "****************************** SIGNAL STRENGHT ****************************"

python plot_signal_strenght_B2G16007.py ALLWVWPRIME138TeV
python plot_signal_strenght_B2G16007.py ALLHVWPRIME138TeV
python plot_signal_strenght_B2G16007.py ALLWPRIME138TeV
python compare_combinations.py ALLWPRIME
