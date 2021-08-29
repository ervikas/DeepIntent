#run handler-permission association
for app in `ls /home/vikas/Downloads/deepintent/test_apks/*.apk`
do
echo $app
java -jar ApkCallGraph.jar $app /home/vikas/Downloads/deepintent/test_apks/ /home/vikas/Downloads/deepintent/DeepIntent-master/IconWidgetAnalysis/Static_Analysis/img2widgets/img2widgets/ /home/vikas/Downloads/deepintent/DeepIntent-master/IconWidgetAnalysis/Static_Analysis/permission_output /home/vikas/Downloads/deepintent/DeepIntent-master/IconWidgetAnalysis/Static_Analysis/ic3/output/
done

#combine results and get 1-to-more mapping using 1tomore.txt
python3 combine.py permission_output/
python3 map1tomore.py #change the input and output file names and paths at line 4, 5, and 6.
