#使用方法
#create by Chen.ZiKui 2017.11.20

#脚本文件路径
shell_path="/Users/DHB/Desktop/打包脚本"

#工程绝对路径
project_path=${shell_path}/定制APP工程

#跳转脚本目录创建文件夹
cd ${shell_path}
if [ ! -d ./IPADir ];
then
mkdir -p IPADir;
fi

echo "Place enter the number you want to export ? [ 1:app-store 2:ad-hoc] "
##
read number
while([[ $number != 1 ]] && [[ $number != 2 ]])
do
echo "Error! Should enter 1 or 2"
echo "Place enter the number you want to export ? [ 1:app-store 2:ad-hoc] "
read number
done

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

    #打包模式 Debug/Release
    development_mode=Debug
    if [ $number == 1 ];
    then
    development_mode=Release
    else
    development_mode=Debug
    fi

    #build文件夹路径
    build_path=${shell_path}/build

    #创建时间
    buildTime=$(date +%Y%m%d%H%M)

    #app打包后文件夹名字  工程名+时间
    app_ipa_name=${scheme_name}_${buildTime}

    #导出.ipa文件所在路径
    exportIpaPath=${shell_path}/IPADir/${development_mode}/${app_ipa_name}

    #跳转到工程目录
    cd ${project_path}

    #copy更换文件
    cp ${shell_path}/PackageConfig/${file_name}/copyfiles/AppIcon.appiconset/* ${project_path}/${project_name}/Assets.xcassets/AppIcon.appiconset
    cp ${shell_path}/PackageConfig/${file_name}/copyfiles/LaunchImage.launchimage/* ${project_path}/${project_name}/Assets.xcassets/LaunchImage.launchimage
    cp ${shell_path}/PackageConfig/${file_name}/copyfiles/en.lproj/* ${project_path}/${project_name}/en.lproj
    cp ${shell_path}/PackageConfig/${file_name}/copyfiles/zh-Hans.lproj/* ${project_path}/${project_name}/zh-Hans.lproj
    cp ${shell_path}/PackageConfig/${file_name}/copyfiles/Constant/* ${project_path}/${project_name}/公共/Constant
    cp ${shell_path}/PackageConfig/${file_name}/copyfiles/logo/* ${project_path}/${project_name}/资源图片
    cp ${shell_path}/PackageConfig/${file_name}/copyfiles/infoplist/Info.plist ${project_path}/${project_name}/Info.plist

    # 设置项目内的Build Version，增1
    Project_Plist=${project_path}/${project_name}/Info.plist
    Project_Build_Version=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" ${Project_Plist})
    Fixed_Project_Build_Version=$(expr $Project_Build_Version + 1)
    # 将文件的plist 的build版本号加一，并设置到plist文件中
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $Fixed_Project_Build_Version" ${Project_Plist}
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $Fixed_Project_Build_Version" ${shell_path}/BrandAPPFiles/${file_name}/copyfiles/infoplist/Info.plist

    #设置当前版本号
    Fixed_Project_BundleShortVersionString=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" ${Project_Plist})
    BundleShortVersionString1=${Fixed_Project_BundleShortVersionString%%.*}
    BundleShortVersionString2=${Fixed_Project_BundleShortVersionString:2:1}
    BundleShortVersionString3=${Fixed_Project_BundleShortVersionString##*.}
    max_num="9"
    if [ "$BundleShortVersionString3" = "$max_num" ];
    then
    BundleShortVersionString3="0"
    if [ "$BundleShortVersionString2" = "$max_num" ];
    then
    BundleShortVersionString2="0"
    BundleShortVersionString1=$(expr $BundleShortVersionString1 + 1)
    else
    BundleShortVersionString2=$(expr $BundleShortVersionString2 + 1)
    fi
    else
    BundleShortVersionString3=$(expr $BundleShortVersionString3 + 1)
    fi

    Fixed_Project_BundleShortVersionString_new=${BundleShortVersionString1}"."${BundleShortVersionString2}"."${BundleShortVersionString3}
    echo ${Fixed_Project_BundleShortVersionString_new}
    /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $Fixed_Project_BundleShortVersionString_new" ${Project_Plist}
    /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $Fixed_Project_BundleShortVersionString_new" ${shell_path}/BrandAPPFiles/${file_name}/copyfiles/infoplist/Info.plist



#    /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $Fixed_Project_BundleShortVersionString" ${Project_Plist}
#    /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $Fixed_Project_BundleShortVersionString" ${shell_path}/BrandAPPFiles/${file_name}/copyfiles/infoplist/Info.plist
#    设置当前CFBundleIdentifier
    Fixed_Project_BundleIdentifier=`/usr/libexec/PlistBuddy -c "print CFBundleIdentifier" ${shell_path}/PackageConfig/${file_name}/packageInfo.plist`
    /usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier $Fixed_Project_BundleIdentifier" ${Project_Plist}
    #设置当前appname
    /usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName $Fixed_Project_CFBundleDisplayName" ${Project_Plist}
    #设置URL Types
#url_types=`/usr/libexec/PlistBuddy -c "print one" ${shell_path}/PackageConfig/${file_name}/packageInfo.plist`
#/usr/libexec/PlistBuddy -c "Delete :CFBundleURLTypes:0" ${Project_Plist}
#/usr/libexec/PlistBuddy -c "Add :CFBundleURLTypes:0 $url_types" ${Project_Plist}
    #设置定位描述信息
    Fixed_Project_NSLocationWhenInUseUsageDescription="您的当前位置将用于定位最新的收货地址和最新城市选择"
    /usr/libexec/PlistBuddy -c "Set :NSLocationWhenInUseUsageDescription $Fixed_Project_NSLocationWhenInUseUsageDescription" ${Project_Plist}
    /usr/libexec/PlistBuddy -c "Set :NSLocationWhenInUseUsageDescription $Fixed_Project_NSLocationWhenInUseUsageDescription" ${shell_path}/BrandAPPFiles/${file_name}/copyfiles/infoplist/Info.plist

    if [ $number == 1 ];
        then
    #plist文件所在路径
        exportOptionsPlistPath=${shell_path}/PackageConfig/${scheme_name}/exportAppstore.plist
    ## 证书名字

        else
    #plist文件所在路径
        exportOptionsPlistPath=${shell_path}/PackageConfig/${scheme_name}/exportTest.plist

    fi

    echo '///-----------'
    echo '/// 正在清理工程'
    echo '///-----------'
    xcodebuild \
    clean -configuration ${development_mode} -quiet  || exit

    echo '///--------'
    echo '/// 清理完成'
    echo '///--------'
    echo ''

    echo '///-----------'
    echo '/// 正在编译工程:'${development_mode}
    echo '///-----------'
    xcodebuild \
    archive -workspace ${project_path}/${project_name}.xcworkspace \
    -scheme ${scheme_name} \
    -configuration ${development_mode} \
    -archivePath ${build_path}/${app_ipa_name}.xcarchive -quiet  || exit

    echo '///--------'
    echo '/// 编译完成'
    echo '///--------'
    echo ''

    echo '///----------'
    echo '/// 开始ipa打包'
    echo '///----------'
    xcodebuild -exportArchive -archivePath ${build_path}/${app_ipa_name}.xcarchive \
    -configuration ${development_mode} \
    -exportPath ${exportIpaPath} \
    -exportOptionsPlist ${exportOptionsPlistPath} \
    -allowProvisioningUpdates \
    -quiet || exit

    if [ -e $exportIpaPath/$scheme_name.ipa ];
        then
        echo '///----------'
        echo '/// ipa包已导出'
        echo '///----------'
#        open $exportIpaPath
        else
        echo '///-------------'
        echo '/// ipa包导出失败 '
        echo '///-------------'
    fi
    echo '///------------'
    echo '/// 打包ipa完成  '
    echo '///-----------='
    echo ''

    if [ $number == 1 ];
        then

        echo '///-------------'
        echo '/// 开始发布ipa包 '
        echo '///-------------'
        #验证并上传到App Store
        # 将-u 后面的XXX替换成自己的AppleID的账号，-p后面的XXX替换成自己的密码
        altoolPath="/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool"
        #判断字符串 跟换账号
        if [ "$scheme_name" == "GuangZhouZuoLin" ];then
        echo "左邻账号"
        "$altoolPath" --validate-app -f ${exportIpaPath}/${scheme_name}.ipa -u 2556167603@qq.com -p Aa11223344 -t ios --output-format xml
        "$altoolPath" --upload-app -f ${exportIpaPath}/${scheme_name}.ipa -u 2556167603@qq.com -p Aa11223344 -t ios --output-format xml
        elif [ "$scheme_name" == "richengshangcheng" ];then
        echo "日成机电账号"
        "$altoolPath" --validate-app -f ${exportIpaPath}/${scheme_name}.ipa -u richeng2004@163.com -p Rc15913155353 -t ios --output-format xml
        "$altoolPath" --upload-app -f ${exportIpaPath}/${scheme_name}.ipa -u richeng2004@163.com -p Rc15913155353 -t ios --output-format xml
        else
        echo "订货宝账号"
        "$altoolPath" --validate-app -f ${exportIpaPath}/${scheme_name}.ipa -u support@rsung.com -p Fly3484139 -t ios --output-format xml
        "$altoolPath" --upload-app -f ${exportIpaPath}/${scheme_name}.ipa -u support@rsung.com -p Fly3484139 -t ios --output-format xml
        fi



#    else
#
#        echo "Place enter the number you want to export ? [ 1:fir 2:蒲公英] "
#        ##
#        read platform
#            while([[ $platform != 1 ]] && [[ $platform != 2 ]])
#            do
#                echo "Error! Should enter 1 or 2"
#                echo "Place enter the number you want to export ? [ 1:fir 2:蒲公英] "
#                read platform
#            done
#
#                if [ $platform == 1 ];
#                    then
#                    #上传到Fir
#                    # 将XXX替换成自己的Fir平台的token
#                    fir login -T xxx
#                    fir publish $exportIpaPath/$scheme_name.ipa
#                else
#                    echo "开始上传到蒲公英"
#                    #上传到蒲公英
#                    #蒲公英aipKey
#                    MY_PGY_API_K=xxxxxxxxxxxx
#                    #蒲公英uKey
#                    MY_PGY_UK=xxxxxxxxxxxxx
#
#                    curl -F "file=@${exportIpaPath}/${scheme_name}.ipa" -F "uKey=${MY_PGY_UK}" -F "_api_key=${MY_PGY_API_K}" https://qiniu-storage.pgyer.com/apiv1/app/upload
#                fi

    fi
    echo "\n\n"
fi
done
echo "已运行完毕>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
exit 0


