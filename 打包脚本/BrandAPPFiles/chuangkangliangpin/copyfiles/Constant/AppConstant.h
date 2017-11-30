/*!
 @header      AppConstant.h
 @abstract    阿商信息技术有限公司
 @author      玄健
 @version     15/10/14
 */

#pragma mark -
#pragma mark 首页

#define XCODE_COLORS_ESCAPE @"\033["

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

#define NSLog_Blue(fmt, ...)   NSLog((XCODE_COLORS_ESCAPE @"fg20,221,255;" fmt XCODE_COLORS_RESET),##__VA_ARGS__);
#define NSLog_Red(fmt, ...)   NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0;" fmt XCODE_COLORS_RESET),##__VA_ARGS__);
# define DLog(fmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0;" @"[文件名:%s]/n" "[函数名:%s]/n" "[行号:%d]/n" fmt XCODE_COLORS_RESET), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);


//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.width-350)?NO:YES)
#define Multiple SCREEN_WIDTH/375
#define Multiple_Hight SCREEN_HEIGHT/667.0f

/***********************Begin:默认的视图参数设置***************************/
#define TabBar_HEIGHT 49.0f ///(TabBar的高度)
#define Titel_HEIGHT 64.0f ///(导航栏高度)
#define DEFAULT_BUTTON_HEIGHT 45.0f ///(默认大按钮的高度)
#define DEFAULT_LINE_HEIGHT 0.5f ///(默认分割线的高度)
#define DEFAULT_SECTION_HEIGHT 10.0f ///(默认TableView的section的高度)
#define MARGIN_TOP 10.0f //
#define MARGIN_BOTHSIDES 11.0f //
/***********************End:默认的视图参数设置****************************/

#define FREE_ACCOUNT_SKEY @"00796a2e531674257dbd2e7b585b2d85"

#define AMapKEY @"a2673e6b18e87de7ce22bfe81e674834"

#define UMengKEY @"5902f0f307fe657e220012e0"

#define WeChatAppId @"wx10655e9d1a80c9c8"//红包用

#define WeChatSecret @"f46a870d4098214da2943ed46b0aa688"//红包用

#define WXAppId @"wx8bf08aa6986cd959"

#define WXSecret @"19a4e94ca809f7ce57c150940f510619"

#define SinaKEY @"1301154534"

#define SinaSecret @"d8268f8f32256bed067c26d2574a90c6"

#define QQAppId @"1106054149"

#define QQKEY @"vQUBzilBE6WBUfXb"

#define JSPatchKEY @"6c716d2f02b18283"

#define LOCAL_DATABASE @"LOCAL_DATABASE"

#define GOODS_DATABASE @"GOODS_DATABASE"

#define CITY_FILENAME @"city"

/***********************Begin:品牌定制公司ID***************************/
#define Company_Id 113982
/***********************End:品牌定制公司ID****************************/

/***********************Begin:常用方法***************************/
//validate string
#define VALIDATE_STRING(str) (IsNilOrNull(str) ? @"" : str)
/***********************End:常用方法****************************/

/***********************Begin:常用字体***************************/
#define FONT_TITLE 15 //标题
#define FONT_SUBTITLE 14 //副标题
#define FONT_DESCRIBE 13 //描述
#define FONT_UNIT 12 //起定量单位
#define FONT_ASSIST 11 //辅助
/***********************Begin:常用字体***************************/

