#使用方法
#create by Chen.ZiKui 2017.11.20

#脚本文件路径
shell_path="/Users/DHB/Desktop/打包脚本"

#工程绝对路径
project_path="/Users/DHB/Desktop/定制版本"

for file2 in `ls -a ${shell_path}/PackageConfig`
do
if [ x"$file2" != x"." -a x"$file2" != x".." -a x"$file2" != x".DS_Store" ]; then

    #工程名 将XXX替换成自己的工程名
    project_name=DHB

    #工程名 将XXX替换成自己的工程名
    file_name="$file2"

    #scheme名 将XXX替换成自己的sheme名
    scheme_name=`/usr/libexec/PlistBuddy -c "print ipa_name" ${shell_path}/PackageConfig/${file_name}/packageInfo.plist`
    #获取当前app的应用名
    Fixed_Project_CFBundleDisplayName=`/usr/libexec/PlistBuddy -c "print app_name" ${shell_path}/PackageConfig/${file_name}/packageInfo.plist`

    #日志名称
    log=$shell_path/logs/${Fixed_Project_CFBundleDisplayName}.log   #操作日志存放路径
    exec 2>$log #如果执行过程中有错误信息均输出到日志文件中

    #跳转到工程目录
    cd ${project_path}

    #copy更换文件
    cp ${project_path}/${project_name}/Assets.xcassets/AppIcon.appiconset/* ${shell_path}/PackageConfig/${file_name}/copyfiles/AppIcon.appiconset
    cp ${project_path}/${project_name}/Assets.xcassets/LaunchImage.launchimage/* ${shell_path}/PackageConfig/${file_name}/copyfiles/LaunchImage.launchimage
    cp ${project_path}/${project_name}/en.lproj/InfoPlist.strings ${shell_path}/PackageConfig/${file_name}/copyfiles/en.lproj/InfoPlist.strings
    cp ${project_path}/${project_name}/zh-Hans.lproj/InfoPlist.strings ${shell_path}/PackageConfig/${file_name}/copyfiles/zh-Hans.lproj/InfoPlist.strings
    cp ${project_path}/${project_name}/公共/Constant/AppConstant.h ${shell_path}/PackageConfig/${file_name}/copyfiles/Constant
    cp ${project_path}/${project_name}/资源图片/logo@2x.png ${shell_path}/PackageConfig/${file_name}/copyfiles/logo/logo@2x.png
    cp ${project_path}/${project_name}/资源图片/logo@3x.png ${shell_path}/PackageConfig/${file_name}/copyfiles/logo/logo@3x.png
    cp  ${project_path}/${project_name}/Info.plist ${shell_path}/PackageConfig/${file_name}/copyfiles/infoplist

fi
done
echo "已运行完毕>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
exit 0


