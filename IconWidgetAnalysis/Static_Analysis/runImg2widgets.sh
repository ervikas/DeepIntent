#! /bin/sh
cd /home/vikas/Downloads/deepintent/DeepIntent-master/IconWidgetAnalysis/Static_Analysis
#get apk names list
python3 getAPKNames.py /home/vikas/Downloads/deepintent/test_apks/ #argv[1]: Your apk folder directory
#run gator
#argv[1] Your apk folder directory
#argv[2] Your Android sdk directory
#argv[3] Your apktool.jar's directory, it is included in gator-IconIntent folder
python3 gator-IconIntent/gator.py /home/vikas/Downloads/deepintent/test_apks/ /home/vikas/Android/Sdk/ /home/vikas/Downloads/deepintent/DeepIntent-master/IconWidgetAnalysis/Static_Analysis/gator-IconIntent/

#mv gator-IconIntent/output/ /home/vikas/Downloads/deepintent/DeepIntent-master/IconWidgetAnalysis/Static_Analysis
mkdir img2widgets
mkdir permission_output
mkdir dot_output

#run icon-widget-handler association
java -jar wid.jar /home/vikas/Downloads/deepintent/test_apks  #argv[1]: Your apk folder directory
#java -jar ImageToWidgetAnalyzer.jar output/ output/ output/ selectedAPK.txt
java -jar ImageToWidgetAnalyzer.jar output/ output/ img2widgets/ selectedAPK.txt

#run ic3
sh ic3/runic3.sh /home/vikas/Downloads/deepintent/test_apks #argv[1]: Your apk folder directory

#run handler-permission association
for app in `ls /home/vikas/Downloads/deepintent/test_apks/*.apk`
do
echo $app
java -jar ApkCallGraph.jar $app /home/vikas/Downloads/deepintent/test_apks/ /home/vikas/Downloads/deepintent/DeepIntent-master/IconWidgetAnalysis/Static_Analysis/img2widgets/img2widgets/ /home/vikas/Downloads/deepintent/DeepIntent-master/IconWidgetAnalysis/Static_Analysis/permission_output /home/vikas/Downloads/deepintent/DeepIntent-master/IconWidgetAnalysis/Static_Analysis/ic3/output/
done

#combine results and get 1-to-more mapping using 1tomore.txt
python3 combine.py permission_output/
python3 map1tomore.py #change the input and output file names and paths at line 4, 5, and 6.
