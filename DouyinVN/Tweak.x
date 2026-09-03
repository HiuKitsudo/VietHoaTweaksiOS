#import <UIKit/UIKit.h>

@interface UITabBarButton : UIView
@end

@interface TTTAttributedLabel : UILabel
- (void)setText:(id)arg1;
@end

@interface YYLabel : UIView
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSAttributedString *attributedText;
@end

@interface LynxTextView : UIView
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSAttributedString *attributedText;
@end

static NSString *DichDouyin(NSString *text) {
    if (!text || text.length == 0) return nil;
    
    NSDictionary *dict = @{
        @"抖音": @"Douyin",
        @"首页": @"Trang chủ",
        @"朋友": @"Bạn bè",
        @"消息": @"Hộp thư",
        @"我": @"Hồ sơ",
        @"发布": @"Đăng",
        @"推荐": @"Đề xuất",
        @"关注": @"Theo dõi",
        @"商城": @"Cửa hàng",
        @"直播": @"Live",
        @"经验": @"Kinh nghiệm",
        @"同城": @"Gần đây",
        @"精选": @"Tuyển chọn",
        @"热点": @"Hot",
        @"搜索": @"Tìm kiếm",
        @"分享": @"Chia sẻ",
        @"评论": @"Bình luận",
        @"点赞": @"Thích",
        @"发送": @"Gửi",
        @"取消": @"Hủy",
        @"确认": @"Xác nhận",
        @"完成": @"Xong",
        @"返回": @"Quay lại",
        @"更多": @"Thêm",
        @"我知道了": @"Đã hiểu",
        @"去发布": @"Đăng ngay",
        @"查看": @"Xem",
        @"保存": @"Lưu",
        @"重试": @"Thử lại",
        @"文字": @"Văn bản",
        @"相机": @"Máy ảnh",
        @"电影模式": @"Chế độ Điện ảnh",
        @"其他": @"Khác",
        @"立即体验": @"Trải nghiệm ngay",
        @"发现更多": @"Khám phá thêm",
        @"编辑资料": @"Sửa hồ sơ",
        @"添加朋友": @"Thêm bạn",
        @"获赞": @"Lượt thích",
        @"粉丝": @"Follower",
        @"作品": @"Video",
        @"喜欢": @"Đã thích",
        @"私密": @"Riêng tư",
        @"收藏": @"Đã lưu",
        @"我的收藏夹": @"Bộ sưu tập của tôi",
        @"创建收藏夹管理你的内容" : @"Tạo bộ sưu tập để quản lý nội dung của bạn",
        @"更换封面" : @"Đổi ảnh bìa",
        @"更换头像": @"Đổi ảnh đại diện",
        @"名字": @"Tên",
        @"简介": @"Tiểu sử",
        @"关于" : @"Giới thiệu",
        @"介绍喜好、个性或@你的亲友": @"Giới thiệu sở thích, cá tính hoặc @bạn bè",
        @"性别": @"Giới tính",
        @"不展示": @"Không hiển thị",
        @"男": @"Nam",
        @"女": @"Nữ",
        @"生日": @"Sinh nhật",
        @"生日当天会收到抖音的祝福": @"Nhận lời chúc từ Douyin vào ngày sinh nhật",
        @"所在地": @"Địa điểm",
        @"填写地区，发现同乡": @"Điền khu vực để tìm đồng hương",
        @"抖音号": @"Douyin ID",
        @"添加性别等标签": @"Thêm giới tính và thẻ khác",
        @"互关": @"Bạn bè",
        @"访客": @"Khách",
        @"相册": @"Ảnh",
        @"修改名字": @"Đổi tên",
        @"我的名字": @"Tên của tôi",
        @"修改抖音号": @"Đổi ID Douyin",
        @"我的抖音号": @"ID Douyin của tôi",
        @"资料完成度": @"Hoàn thiện hồ sơ",
        @"常用功能": @"Thường dùng",
        @"更多功能": @"Xem thêm",
        @"观看历史": @"Lịch sử xem",
        @"离线缓存": @"Video đã tải",
        @"稍后再看": @"Xem sau",
        @"我的二维码": @"Mã QR của tôi",
        @"抖音码": @"Mã Douyin",
        @"未成年人模式": @"Chế độ trẻ em",
        @"直播广场": @"Quảng trường Live",
        @"扫一扫": @"Quét mã",
        @"识万物": @"Nhận diện vật thể",
        @"识别中请保持手机稳定": @"Vui lòng giữ yên điện thoại khi đang nhận diện",
        @"答疑": @"Giải đáp",
        @"对准二维码自动识别": @"Căn mã QR để tự động quét",
        @"定时关闭": @"Hẹn giờ tắt",
        @"设置": @"Cài đặt",
        @"使用管理助手": @"Trợ lý quản lý",
        @"抖音创作者中心": @"Trung tâm Nhà sáng tạo",
        @"工具服务": @"Công cụ & Dịch vụ",
        @"我的客服": @"CSKH của tôi",
        @"我的预约": @"Lịch hẹn",
        @"直播缓存": @"Bộ đệm trực tiếp",
        @"我的缓存": @"Bộ nhớ đệm",
        @"清理缓存": @"Xóa bộ nhớ đệm",
        @"创作与经营": @"Sáng tạo & Kinh doanh",
        @"安全中心": @"Trung tâm An toàn",
        @"上热门": @"Lên xu hướng",
        @"成为主播" : @"Trở thành Streamer",
        @"生活娱乐": @"Giải trí & Đời sống",
        @"社区共建": @"Xây dựng cộng đồng",
        @"钱包服务": @"Dịch vụ Ví",
        @"免打扰": @"Không làm phiền",
        @"装修日记vlog": @"Vlog Nhật ký Sửa nhà",
        @"账号": @"Tài khoản",
        @"账号与安全": @"Tài khoản & Bảo mật",
        @"登录管理": @"Quản lý đăng nhập",
        @"认证与备案": @"Xác thực và Hồ sơ",
        @"授权信息": @"Thông tin cấp quyền",
        @"授杈管理" : @"Quản lý ủy quyền",
        @"搜索应用名称" : @"Tìm tên ứng dụng",
        @"内容为空" : @"Không có nội dung",
        @"无法登录其他账号，找回登录": @"Không thể đăng nhập TK khác, khôi phục tài khoản",
        @"隐私设置": @"Quyền riêng tư",
        @"支付设置": @"Cài đặt thanh toán",
        @"通用": @"Chung",
        @"通用设置": @"Cài đặt chung",
        @"通知设置": @"Thông báo",
        @"通知消息管理": @"Quản lý thông báo",
        @"接收": @"Nhận",
        @"部分接收": @"Nhận một phần",
        @"接收通知消息": @"Nhận thông báo",
        @"允许接收以下通知消息": @"Cho phép nhận các thông báo sau",
        @"通知方式": @"Cách thức thông báo",
        @"消息管理": @"Quản lý tin nhắn",
        @"聊天与通话设置": @"Cài đặt trò chuyện & cuộc gọi",
        @"播放设置": @"Cài đặt phát",
        @"背景设置": @"Cài đặt hình nền",
        @"长辈模式": @"Chế độ người lớn tuổi",
        @"字体大小": @"Cỡ chữ",
        @"极速性能模式": @"Chế độ hiệu năng cao",
        @"系统权限": @"Quyền hệ thống",
        @"关于抖音": @"Giới thiệu Douyin",
        @"了解与管理广告推送": @"Quản lý quảng cáo",
        @"反馈与帮助": @"Phản hồi & Trợ giúp",
        @"抖音规则中心": @"Trung tâm quy tắc",
        @"资质证照": @"Giấy phép & Chứng nhận",
        @"用户协议": @"Thỏa thuận người dùng",
        @"隐私政策": @"Chính sách quyền riêng tư",
        @"应用权限": @"Quyền ứng dụng",
        @"个人信息收集清单": @"Danh sách thu thập thông tin",
        @"第三方信息共享清单": @"Danh sách chia sẻ bên thứ 3",
        @"个人信息管理": @"Quản lý thông tin cá nhân",
        @"开源软件声明": @"Tuyên bố mã nguồn mở",
        @"切换账号": @"Chuyển tài khoản",
        @"添加或注册新账号": @"Thêm hoặc đăng ký tài khoản mới",
        @"退出登录": @"Đăng xuất",
        @"账号绑定": @"Liên kết tài khoản",
        @"手机号绑定": @"Liên kết SĐT",
        @"实名认证": @"Xác thực danh tính",
        @"未认证": @"Chưa xác thực",
        @"抖音密码": @"Mật khẩu Douyin",
        @"未设置": @"Chưa thiết lập",
        @"第三方账号绑定": @"Liên kết tài khoản bên thứ 3",
        @"登录设备管理": @"Quản lý thiết bị đăng nhập",
        @"保存登录信息": @"Lưu thông tin đăng nhập",
        @"申请官方认证": @"Đăng ký xác thực chính chủ",
        @"个人、企业机构的账号认证": @"Xác thực Cá nhân/Doanh nghiệp",
        @"暂无通过抖音授权的应用或小程序" : @"Chưa có ứng dụng hoặc tiện ích nào được cấp quyền qua Douyin",
        @"授权管理": @"Quản lý ủy quyền",
        @"我的合作码": @"Mã hợp tác của tôi",
        @"找回与注销": @"Tìm lại & Hủy",
        @"注销账号": @"Hủy tài khoản",
        @"抖音安全中心": @"Trung tâm an toàn Douyin",
        @"查看账号状态，使用安全工具": @"Kiểm tra trạng thái & Công cụ an toàn",
        @"未开启": @"Chưa bật",
        @"亲子护航": @"Giám sát phụ huynh",
        @"绑定并管理孩子设备": @"Liên kết & quản lý thiết bị của con",
        @"未成年人退款": @"Hoàn tiền cho trẻ vị thành niên",
        @"视频已下载": @"Video đã tải",
        @"下载更多推荐": @"Tải thêm đề xuất",
        @"下载更多推荐，离线正常刷抖音": @"Tải thêm đề xuất để xem offline",
        @"暂无我缓存的内容": @"Chưa có nội dung đã tải",
        @"已使用": @"Đã dùng",
        @"可用空间": @"Còn trống",
        @"活动中心": @"Trung tâm hoạt động",
        @"开播通知": @"Thông báo Live",
        @"暂无有预约的主播": @"Chưa có lịch hẹn Live nào",
        @"查看历史预约": @"Xem lịch sử hẹn",
        @"找到我的方式": @"Cách tìm thấy tôi",
        @"可以被没有关注我的人搜索到": @"Người lạ có thể tìm kiếm tôi",
        @"通过分享的链接找到我": @"Tìm tôi qua liên kết chia sẻ",
        @"在他人关注和粉丝列表公开出现": @"Hiển thị trong danh sách Follow/Fan của người khác",
        @"把我推荐给可能认识的人": @"Gợi ý tôi cho người có thể quen",
        @"黑名单": @"Danh sách đen",
        @"私密账号": @"Tài khoản riêng tư",
        @"一键隐私防护": @"Bảo vệ riêng tư 1 chạm",
        @"关注和朋友权限": @"Quyền Bạn bè & Theo dõi",
        @"仅展示与你互相关注的人" : @"Chỉ hiển thị người theo dõi lẫn nhau",
        @"最早关注" : @"Theo dõi lâu nhất",
        @"互相关注" : @"Theo dõi lẫn nhau",
        @"关注和粉丝列表": @"Danh sách Follow & Fan",
        @"公开可见": @"Công khai",
        @"推荐可能认识的人给我": @"Gợi ý người quen cho tôi",
        @"谁能加我为朋友": @"Ai có thể thêm bạn",
        @"所有人": @"Mọi người",
        @"作品和日常权限": @"Quyền Video & Nhật ký",
        @"不看他(她)": @"Không xem người này",
        @"不让他(她)看": @"Chặn người này xem",
        @"互动权限": @"Quyền tương tác",
        @"在线状态": @"Trạng thái hoạt động",
        @"主页访客记录": @"Lịch sử xem hồ sơ",
        @"作品浏览记录": @"Lịch sử xem video",
        @"被 @": @"Lượt nhắc (@)",
        @"同城展示": @"Hiển thị cùng thành phố",
        @"电商": @"Thương mại điện tử",
        @"开启": @"Bật",
        @"关闭": @"Tắt",
        @"互关的人可见": @"Bạn bè mới thấy",
        @"粉丝可见": @"Người theo dõi mới thấy",
        @"谁可以看到你的推荐（包含历史推荐内容）": @"Ai có thể xem đề xuất của bạn (bao gồm cả lịch sử)",
        @"开启 3 天": @"Bật trong 3 ngày",
        @"开启 7 天": @"Bật trong 7 ngày",
        @"开启 30 天": @"Bật trong 30 ngày",
        @"扫描抖音码加朋友": @"Quét mã Douyin để thêm bạn",
        @"面对面加朋友": @"Thêm bạn trực tiếp",
        @"添加身边的朋友": @"Thêm bạn bè xung quanh",
        @"添加微信朋友": @"Thêm bạn bè WeChat",
        @"分享我的口令到微信添加朋友": @"Chia sẻ mã qua WeChat để thêm bạn",
        @"朋友申请": @"Yêu cầu kết bạn",
        @"限时日常,": @"Khoảnh khắc giới hạn,",
        @"让记录更轻松": @"Giúp việc ghi lại dễ dàng hơn",
        @"限时展示": @"Hiển thị giới hạn",
        @"24小时/3天/7天，可见时长随心选": @"24 giờ/3 ngày/7 ngày, tùy chọn thời gian hiển thị",
        @"a聚合浏览": @"Xem tổng hợp",
        @"内容自动聚合，一滑全看完": @"Nội dung tự động gộp lại, lướt một cái xem hết",
        @"多态点赞": @"Thả cảm xúc đa dạng",
        @"不同表情随心点，精准传达心情": @"Thả biểu cảm tùy thích, truyền tải đúng tâm trạng",
        @"浏览记录": @"Lịch sử xem",
        @"看过即留痕，仅作者可见": @"Lưu lại người đã xem, chỉ tác giả mới thấy",
        @"登录发现更多精彩": @"Đăng nhập để khám phá",
        @"登录后，体验完整功能": @"Đăng nhập để trải nghiệm đầy đủ",
        @"登录看朋友内容": @"Đăng nhập để xem nội dung của bạn bè",
        @"登录后即可拍摄视频": @"Đăng nhập để quay video",
        @"登录后即可点赞喜欢的内容": @"Sau khi đăng nhập, bạn có thể thích nội dung bạn thích.",
        @"登录后即可查看消息": @"Đăng nhập để xem tin nhắn",
        @"你还没有登录": @"Bạn chưa đăng nhập",
        @"登录账号，查看你关注的精彩内容": @"Đăng nhập để xem nội dung thú vị từ người bạn theo dõi",
        @"请输入手机号": @"Nhập số điện thoại",
        @"密码登录": @"Đăng nhập mật khẩu",
        @"验证并登录": @"Xác nhận & Đăng nhập",
        @"或": @"Hoặc",
        @"Apple 登录": @"Đăng nhập Apple",
        @"Google 登录": @"Đăng nhập Google",
        @"邮箱登录": @"Đăng nhập Email",
        @"其他登录方式": @"Phương thức khác",
        @"找回账号": @"Tìm lại tài khoản",
        @"帮助": @"Trợ giúp",
        @"验证码登录": @"Đăng nhập mã xác thực",
        @"微博登录": @"Đăng nhập Weibo",
        @"微信登录": @"Đăng nhập WeChat",
        @"QQ 登录": @"Đăng nhập QQ",
        @"今日头条登录": @"Đăng nhập Toutiao",
        @"手机号密码登录": @"Đăng nhập bằng Mật khẩu",
        @"请输入密码": @"Nhập mật khẩu",
        @"忘记密码": @"Quên mật khẩu",
        @"登录": @"Đăng nhập",
        @"验证码": @"Mã xác thực",
        @"登录安全验证": @"Xác minh bảo mật",
        @"为了你的账号安全，请绑定一个手机号": @"Để bảo vệ tài khoản, vui lòng liên kết số điện thoại",
        @"去绑定手机号": @"Liên kết số điện thoại",
        @"请输入验证码": @"Nhập mã xác thực",
        @"提交": @"Xác nhận",
        @"收不到验证码?": @"Không nhận được mã?",
        @"复制链接": @"Sao chép liên kết",
        @"全屏观看" : @"Toàn màn hình",
        @"重新发送": @"Gửi lại",
        @"不感兴趣": @"Không quan tâm",
        @"举报": @"Báo cáo",
        @"保存本地": @"Lưu video",
        @"合拍": @"Duet (Quay cùng)",
        @"转发": @"Đăng lại",
        @"清屏": @"Chế độ trong suốt",
        @"倍速": @"Tốc độ",
        @"分享给": @"Chia sẻ đến",
        @"私信": @"Nhắn tin",
        @"转发到日常": @"Đăng Nhật ký",
        @"帮上热门": @"Quảng bá",
        @"微信": @"WeChat",
        @"朋友圈": @"Moments",
        @"QQ空间": @"Qzone",
        @"分享链接": @"Chia sẻ liên kết",
        @"播放反馈": @"Phản hồi phát",
        @"分享评论给": @"Chia sẻ bình luận đến",
        @"该信息暂不支持编辑" : @"Thông tin này tạm thời không hỗ trợ chỉnh sửa",
        @"转发评论到日常": @"Chia sẻ bình luận lên Khoảnh khắc",
        @"复制该评论": @"Sao chép bình luận",
        @"发作品回复": @"Trả lời bằng video",
        @"关于新的“朋友”功能": @"Về tính năng \"Bạn bè\" mới",
        @"成为朋友需要你的确认\n 你发的内容 朋友会先看到\n 试试从互关中选择你想添加的朋友": @"Cần xác nhận để thành bạn bè\nBạn bè sẽ thấy nội dung của bạn trước\nThử chọn bạn từ danh sách Follow chéo",
        @"新关注我的移至互动消息": @"Follow mới đã chuyển sang Tin nhắn tương tác",
        @"点击查看": @"Nhấn để xem",
        @"发日常": @"Đăng Khoảnh khắc",
        @"通知消息": @"Thông báo",
        @"系统通知：账号登录提醒": @"TB Hệ thống: Nhắc nhở đăng nhập",
        @"系统通知：抖音用户协议及隐私政策修订": @"TB Hệ thống: Sửa đổi điều khoản & quyền riêng tư",
        @"有新消息": @"Có tin nhắn mới",
        @"平台通知消息": @"Thông báo nền tảng",
        @"系统通知": @"Thông báo hệ thống",
        @"新通知将用圆点展示，不再显示未读数字": @"Thông báo mới hiện dấu chấm, không hiện số lượng",
        @"最近没有同城的内容": @"Gần đây không có nội dung cùng thành phố",
        @"搜索用户名字/抖音号": @"Tìm tên người dùng / ID Douyin",
        @"通讯录": @"Danh bạ",
        @"微信朋友": @"Bạn bè WeChat",
        @"面对面": @"Trực tiếp", 
        @"发现通讯录朋友": @"Tìm bạn bè trong Danh bạ",
        @"你身边的朋友在用抖音，快去看看吧": @"Bạn bè quanh đây đang dùng Douyin, xem ngay",
        @"更多添加朋友的方式" : @"Các cách thêm bạn khác",
        @"缓存更多推荐视频": @"Tải trước video đề xuất",
        @"缓存更多推荐视频，离线正常刷抖音": @"Tải trước video để lướt Douyin bình thường khi offline",
        @"网络错误": @"Lỗi kết nối",
        @"请检查网络连接后重试": @"Vui lòng kiểm tra kết nối mạng và thử lại",
        @"App已用空间": @"App đã dùng",
        @"设备已用空间": @"Máy đã dùng",
        @"设备可用空间": @"Còn trống",
        @"抖音已用空间": @"Douyin đã dùng",
        @"选择国家和地区": @"Chọn Quốc gia/Vùng",
        @"越南 ": @"Việt Nam",
        @"我关注的人": @"Người tôi theo dõi",
        @"互相关注的人": @"Bạn bè",
        @"作品视图": @"Chế độ xem video",
        @"动态封面": @"Ảnh bìa động",
        @"提前上传作品，减少等待时间": @"Tải trước video, giảm thời gian chờ",
        @"保存自己内容带水印": @"Lưu video của mình có logo",
        @"往日回忆": @"Kỷ niệm xưa",
        @"抖一抖打开面对面分享视频": @"Lắc để chia sẻ video trực tiếp",
        @"截图后功能面板": @"Bảng chức năng sau khi chụp màn hình",
        @"首页单击操作设置": @"Cài đặt chạm 1 lần ở trang chủ",
        @"护眼模式": @"Chế độ bảo vệ mắt",
        @"黑名单管理": @"Quản lý danh sách chặn",
        @"个人页展示未成年人模式快捷入口": @"Hiện lối tắt Chế độ trẻ em ở trang cá nhân",
        @"关闭后，你查看他人主页时不会留下记录；同时，你也无法查看谁访问了你的主页。": @"Khi tắt, bạn xem hồ sơ người khác sẽ không để lại lịch sử, đồng thời cũng không thể xem ai đã ghé thăm hồ sơ của mình.",
        @"展示主页访客": @"Hiển thị khách xem hồ sơ",
        @"作品标题支持文字搜索": @"Tiêu đề video hỗ trợ tìm kiếm văn bản",
        @"暂停时展示画圈搜索入口": @"Hiện tìm kiếm khoanh tròn khi tạm dừng",
        @"作品暂停时出识别标签": @"Hiện thẻ nhận diện khi tạm dừng",
        @"发布的图片评论支持他人保存": @"Cho phép người khác lưu ảnh bình luận",
        @"搜索中间页默认导航": @"Điều hướng mặc định trang tìm kiếm",
        @"搜索结果页单双列设置": @"Cài đặt hiển thị 1/2 cột kết quả tìm kiếm",
        @"评论区翻译功能": @"Dịch khu vực bình luận",
        @"Siri语音指令": @"Lệnh giọng nói Siri",
        @"不看他（她）的内容": @"Không xem nội dung của người này",
        @"暂无\"不看他（她）的内容\"用户，可以在他人主页右上角\n更多中设置": @"Chưa có người dùng bị ẩn, bạn có thể cài đặt tại menu Thêm ở góc phải trang cá nhân của họ",
        @"使用移动网络改善播放体验": @"Dùng 4G/5G cải thiện trải nghiệm phát",
        @"打开抖音时刷新视频": @"Làm mới video khi mở Douyin",
        @"可能会在首位展示直播、广告等内容": @"Có thể hiện Live/Quảng cáo ở vị trí đầu",
        @"快捷设置 · 接收谁的通知": @"Cài đặt nhanh · Nhận thông báo từ ai",
        @"全部": @"Tất cả",
        @"来自关注": @"Từ người đang Follow",
        @"来自朋友": @"Từ bạn bè",
        @"都不接收": @"Không nhận",
        @"选择地区" : @"Chọn khu vực",
        @"暂不设置" : @"Tạm thời không thiết lập",
        @"互动通知": @"Thông báo tương tác",
        @"上线通知": @"Thông báo trực tuyến",
        @"消息通知": @"Thông báo tin nhắn",
        @"私信通知": @"Tin nhắn riêng",
        @"热点通知": @"Thông báo Hot",
        @"商品与团购": @"Hàng hóa & Mua theo nhóm",
        @"物流与订单通知": @"TB Vận chuyển & Đơn hàng",
        @"内容更新提醒": @"Nhắc cập nhật nội dung",
        @"作品更新通知": @"Thông báo video mới",
        @"直播开播通知": @"Thông báo bắt đầu Live",
        @"推荐内容": @"Nội dung đề xuất",
        @"推荐我可能感兴趣的内容": @"Đề xuất nội dung tôi có thể thích",
        @"推荐可能感兴趣的商品与优惠": @"Đề xuất hàng hóa & ưu đãi",
        @"推荐可能感兴趣的团购与优惠": @"Đề xuất mua nhóm & ưu đãi",
        @"推荐可能感兴趣的人": @"Đề xuất người có thể quen",
        @"活动消息": @"Tin tức sự kiện",
        @"活动通知": @"Thông báo sự kiện",
        @"其他消息": @"Thông báo khác",
        @"拍作品通知": @"Thông báo quay video",
        @"已登录的其他账号通知": @"Thông báo từ tài khoản khác",
        @"财务通知": @"Thông báo tài chính",
        @"账号安全通知": @"Thông báo bảo mật tài khoản",
        @"其他通知": @"Thông báo khác",
        @"抖音应用内提醒": @"Nhắc nhở trong ứng dụng",
        @"顶部横幅通知": @"Thông báo biểu ngữ trên cùng",
        @"朋友页红点": @"Chấm đỏ tab Bạn bè",
        @"关注页红点": @"Chấm đỏ tab Đang Follow",
        @"实时活动通知": @"Thông báo hoạt động thời gian thực",
        @"版本更新": @"Cập nhật phiên bản",
        @"访问抖音官网": @"Truy cập trang chủ Douyin",
        @"抖音官方邮箱": @"Email chính thức Douyin",
        @"点击复制": @"Nhấn để sao chép",
        @"算法推荐专项举报": @"Báo cáo chuyên đề thuật toán",
        @"网络内容从业人员违法违规行为举报": @"Báo cáo vi phạm nội dung mạng",
        @"抖音官方服务热线": @"Hotline CSKH Douyin",
        @"拨打网络电话": @"Gọi điện thoại mạng",
        @"抖音安全与举报专线": @"Hotline An toàn & Báo cáo",
        @"消息页展示日常": @"Hiện Nhật ký ở trang tin nhắn",
        @"私信和通话通知": @"Thông báo tin nhắn & cuộc gọi",
        @"仅自己可见": @"Chỉ mình tôi",
        @"部分": @"Tùy chỉnh",
        @"聊天功能": @"Chức năng trò chuyện",
        @"聊天时推荐表情和功能": @"Gợi ý sticker & chức năng khi chat",
        @"键盘的回车按钮用发送代替换行": @"Phím Enter dùng để Gửi",
        @"拍摄或编辑发出的内容保存至相册": @"Lưu nội dung gửi vào album",
        @"使用移动网络改善通话质量": @"Dùng 4G/5G cải thiện cuộc gọi",
        @"播放视频时推荐分享给朋友": @"Gợi ý chia sẻ cho bạn bè khi xem",
        @"最近删除的聊天记录": @"Lịch sử chat đã xóa gần đây",
        @"聊天数据修复": @"Sửa lỗi dữ liệu chat",
        @"当前无法接收朋友的消息提醒": @"Hiện không thể nhận thông báo từ bạn bè",
        @"打开提醒": @"Bật thông báo",
        @"喊话": @"Nhắn gửi",
        @"智能助手": @"Trợ lý thông minh",
        @"嗨，我是你的新朋友豆包！初次见面很开心": @"Chào, tôi là bạn mới Doubao! Rất vui được gặp bạn",
        @"version": @"Phiên bản",
        @"清屏播放": @"Chế độ xem rõ",
        @"添加至稍后再看": @"Thêm vào Xem sau",
        @"你还没有关注任何人": @"Bạn chưa theo dõi ai",
        @"搜索用户备注或名字": @"Tìm tên hoặc tên gợi nhớ",
        @"保存至相册": @"Lưu vào Thư viện",
        @"识别图片": @"Nhận diện hình ảnh",
        @"电脑/Pad打开": @"Mở trên Máy tính/Pad",
        @"获赞数包含作品、私密": @"Lượt thích bao gồm cả video công khai và riêng tư",
        @"主页访客": @"Khách xem hồ sơ",
        @"授权查看访客": @"Bật lịch sử xem hồ sơ",
        @"访客记录中仅展示同样已授权的用户": @"Danh sách chỉ hiện những người cũng bật tính năng này",
        @"开启后，你访问他人主页也将留下记录": @"Khi bật, bạn xem hồ sơ người khác cũng sẽ để lại lịch sử",
        @"你可以随时在访客设置中关闭授权": @"Bạn có thể tắt bất cứ lúc nào trong cài đặt",
        @"你还没有收到互动消息" : @"Bạn chưa có thông báo tương tác nào",
        @"全部消息" : @"Tất cả thông báo",
        @"赞与收藏" : @"Lượt thích và Đã lưu",
        @"收到的评论" : @"Bình luận nhận được",
        @"发出的评论" : @"Bình luận đã gửi",
        @"收到的弹幕" : @"Danmu nhận được",
        @"分享你此刻的想法" : @"Chia sẻ suy nghĩ của bạn lúc này",
        @"发出的弹幕" : @"Danmu đã gửi",
        @"开始在抖音记录生活" : @"Bắt đầu ghi lại cuộc sống trên Douyin",
        @"发作品，留下记忆" : @"Đăng bài, lưu giữ kỷ niệm",
        @"暂无内容": @"Chưa có nội dung",
        @"搜索你赞过的视频": @"Tìm trong các video bạn đã thích",
        @"选择搜索范围": @"Chọn phạm vi tìm kiếm",
        @"暂时没有更多了": @"Tạm thời không còn nội dung",
        @"新关注我的": @"Người theo dõi mới",
        @"立即制作形象" : @"Tạo nhân vật ngay",
        @"制作我的 AI 形象" : @"Tạo nhân vật AI của tôi",
        @"一键生成多种热门写真" : @"Tạo nhiều bộ ảnh hot chỉ với 1 chạm",
        @"输入描述，自定义专属写真" : @"Nhập mô tả, tùy chỉnh bộ ảnh riêng bạn",
        @"AI写真馆" : @"Tiệm ảnh AI",
        @"制作我的百变写真" : @"Tạo bộ ảnh đa phong cách của tôi",
        @"保存头像" : @"Lưu ảnh đại diện",
        @"你的个人主页作品将会按设置调整展示方式" : @"Bài đăng trên trang cá nhân sẽ hiển thị theo cài đặt này",
        @"三列仅展示出封面信息，利于快速查看" : @"Chế độ 3 cột chỉ hiện ảnh bìa, giúp xem nhanh",
        @"截图后展示功能面板" : @"Hiện bảng chức năng sau khi chụp màn hình",
        @"截图海报展示用户头像" : @"Hiển thị ảnh đại diện trên poster",
        @"「首页」单击操作设置" : @"Cài đặt thao tác chạm 'Trang chủ'",
        @"刷新内容" : @"Làm mới nội dung",
        @"选择视图" : @"Chọn kiểu xem",
        @"点击顶部「推荐」可刷新" : @"Chạm 'Đề xuất' trên cùng để làm mới",
        @"切换单双列" : @"Chuyển đổi 1/2 cột",
        @"色温调节" : @"Điều chỉnh nhiệt độ màu",
        @"开启护眼模式" : @"Bật chế độ bảo vệ mắt",
        @"过滤视频的蓝光，缓解观看短视频及直播时的用眼疲劳。" : @"Lọc ánh sáng xanh từ video, giảm mỏi mắt khi xem video ngắn và LIVE.",
        @"用户访问记录" : @"Lịch sử ghé thăm",
        @"开启后，你可以看到30天内自己曾经访问过的人以及经常访问的人。" : @"Khi bật, bạn có thể xem người mình đã ghé thăm trong 30 ngày qua và người thường xuyên ghé thăm.",
        @"视频及影视综浏览记录" : @"Lịch sử xem Video & Phim",
        @"开启后，你可以查看自己浏览过的视频、电影、电视剧、综艺节目。" : @"Khi bật, bạn có thể xem lại video, phim, phim bộ và chương trình giải trí đã xem.",
        @"直播观看记录" : @"Lịch sử xem LIVE",
        @"开启后，你可以查看自己看过的直播。" : @"Khi bật, bạn có thể xem lại các phiên LIVE đã xem.",
        @"本功能个性化预估用户对作品标题中有搜索需求的文字，对该文字进行提示且支持直接跳转搜索。" : @"Tính năng này dự đoán từ khóa tìm kiếm trong tiêu đề, đánh dấu và hỗ trợ chạm để tìm kiếm ngay.",
        @"关闭后，除了你关注的人和你的粉丝外，陌生人在抖音内无法搜到你的账号、视频直播等。你收到的互动可能变少。" : @"Nếu tắt, ngoài người bạn đang Follow và Follower, người lạ trên Douyin sẽ không thể tìm thấy tài khoản, video hay LIVE của bạn. Tương tác có thể sẽ giảm.",
        @"关闭后，不能通过分享链接创建与你的聊天，你们之间也不再互相推荐。" : @"Nếu tắt, sẽ không thể bắt đầu trò chuyện với bạn qua liên kết chia sẻ, và cũng không còn đề xuất kết bạn giữa hai bên.",
        @"关闭后，你的账号将不显示在他人的关注和粉丝列表中。" : @"Nếu tắt, tài khoản của bạn sẽ không hiển thị trong danh sách Đang Follow và Follower của người khác.",
        @"「暂停」展示画圈搜索入口" : @"Hiển thị lối tắt tìm kiếm khi Tạm dừng",
        @"原作品音乐不可用，为你展示其他相关音乐" : @"Nhạc gốc không khả dụng, hiển thị nhạc liên quan cho bạn",
        @"相关音乐" : @"Nhạc liên quan",
        @"收藏原声" : @"Thêm nhạc vào Yêu thích",
        @"北京环球影城穿搭" : @"Phối đồ đi Universal Studios Bắc Kinh",
        @"拍同款" : @"Quay cùng kiểu",
        @"已绑定手机号" : @"Số điện thoại đã liên kết",
        @"更换绑定手机号" : @"Đổi số điện thoại liên kết",
        @"确定更改" : @"Xác nhận thay đổi",
        @"自动连播": @"Tự động phát tiếp",
        @"最大拍摄时长（秒）" : @"Thời lượng quay tối đa (giây)",
        @"拍摄比例" : @"Tỷ lệ khung hình",
        @"使用音量键拍摄" : @"Dùng nút âm lượng để chụp",
        @"一键成片" : @"Tạo video 1 chạm",
        @"搜索歌名/歌手/歌词/情绪" : @"Tìm bài hát, ca sĩ, lời hoặc tâm trạng",
        @"从手机相册选择照片" : @"Chọn ảnh từ thư viện",
        @"选择推荐或自己公开的视频" : @"Chọn video đề xuất hoặc video công khai của bạn",
        @"越南语学习零基础入门" : @"Học tiếng Việt cho người mới bắt đầu",
        @"收藏的作品会展示在这里" : @"Video đã lưu sẽ hiển thị tại đây",
        @"由于被隐藏或删除，2个作品不可见 点击清理" : @"2 video không hiển thị do bị ẩn hoặc đã xóa. Nhấn để dọn dẹp",
        @"及时获得消息通知" : @"Nhận thông báo ngay",
        @"开启全部内容通知，为你推荐更多趣评" : @"Bật tất cả thông báo để xem thêm bình luận thú vị",
        @"期待你的评论" : @"Đang chờ bình luận của bạn",
        @"爱评论的人，运气不会差" : @"Chăm bình luận, may mắn sẽ đến",
        @"有爱评论，说点儿好听的" : @"Viết bình luận, chia sẻ cảm nghĩ của bạn",
        @"发条评论，说说你的感受" : @"Viết bình luận, chia sẻ cảm nhận của bạn",
        @"有什么想法，展开说说" : @"Bạn đang nghĩ gì? Chia sẻ chi tiết nhé",
        @"Follower" : @"Người theo dõi",
        @"前往抖音精选App，看更多有用有趣内容" : @"Mở app Douyin Selection để xem thêm nội dung thú vị",
        @"暂未添加稍后再看视频" : @"Chưa có video trong danh sách Xem sau",
        @"可长按视频添加" : @"Nhấn giữ video để thêm",
        @"仅支持缓存已结束的直播和首播视频" : @"Chỉ hỗ trợ tải LIVE và video công chiếu đã kết thúc",
        @"聊天记录" : @"Lịch sử trò chuyện",
        @"App必要文件" : @"Tệp thiết yếu của ứng dụng",
        @"使用抖音过程中产生的临时数据，清理后不影响正常使用。" : @"Dữ liệu tạm sinh ra khi dùng app, xóa đi không ảnh hưởng gì.",
        @"离线模式下载的视频，可以在没有网络时观看，删除后需要重新下载。" : @"Video đã tải để xem khi không có mạng, xóa đi phải tải lại.",
        @"保存在设备上的未发布的草稿作品，删除后不可恢复。" : @"Bản nháp chưa đăng lưu trên máy, xóa đi không thể khôi phục.",
        @"可以删除聊天记录中的视频、图片和文件，或删除所选聊天的全部消息。" : @"Có thể xóa ảnh, video, tệp trong tin nhắn hoặc xóa toàn bộ cuộc trò chuyện.",
        @"维持抖音正常使用的必要文件，如登录数据，大小因App的使用情况有差异。" : @"Tệp cần thiết để app hoạt động (như đăng nhập), dung lượng tùy thuộc mức độ sử dụng.",
        @"实时活动提供即时的信息更新，这些信息显示在灵动岛、锁定屏幕、待机状态的 iPhone 等位置" : @"Hoạt động trực tiếp cung cấp thông tin cập nhật tức thời trên Dynamic Island, Màn hình khóa và Chế độ Chờ của iPhone",
        @"数据库无需修复" : @"Cơ sở dữ liệu không cần sửa lỗi",
        @"当前聊天数据库文件正常，无需进行修复" : @"Tệp cơ sở dữ liệu trò chuyện hiện tại vẫn bình thường, không cần sửa lỗi",
        @"物流状态" : @"Trạng thái vận chuyển",
        @"私信消息通知" : @"Thông báo tin nhắn riêng",
        @"私信通知显示消息详情" : @"Hiển thị nội dung tin nhắn trong thông báo",
        @"通话通知" : @"Thông báo cuộc gọi",
        @"后台音频设置" : @"Cài đặt phát âm thanh nền",
        @"看视频、直播间退出抖音或锁屏时" : @"Khi xem video, LIVE, thoát Douyin hoặc khóa màn hình",
        @"后台小窗设置" : @"Cài đặt Hình trong hình",
        @"看视频、直播间、一起看退出抖音时" : @"Khi xem video, LIVE, Xem chung và thoát Douyin",
        @"开启抖音时默认静音" : @"Mặc định tắt tiếng khi mở Douyin",
        @"自动旋转进全屏" : @"Tự động xoay sang toàn màn hình",
        @"设备间未播完的内容自动同步" : @"Tự động đồng bộ nội dung chưa xem hết giữa các thiết bị",
        @"直播间" : @"Phòng LIVE",
        @"看直播时退出时继续小窗播放" : @"Phát Hình trong hình khi thoát LIVE",
        @"部分直播退出时继续小窗播放" : @"Phát Hình trong hình với một số LIVE",
        @"一起看" : @"Xem chung",
        @"一起看退出时继续小窗播放" : @"Phát Hình trong hình khi thoát Xem chung",
        @"此开关仅在以下情况退出直播间时，自动开启小窗播放，包含：" : @"Tùy chọn này chỉ tự động bật Hình trong hình khi thoát LIVE trong các trường hợp sau:",
        @"通话铃声" : @"Nhạc chuông cuộc gọi",
        @"抖音热榜" : @"Bảng xếp hạng Douyin",
        @"对评论区生效" : @"Áp dụng cho bình luận",
        @"文字更大，设计更简明" : @"Chữ to hơn, giao diện đơn giản hơn",
        @"看得更清晰" : @"Dễ nhìn hơn",
        @"开启长辈模式" : @"Bật Chế độ người lớn tuổi",
        @"开启防走失模式" : @"Bật Chế độ chống đi lạc",
        @"跟随系统调整" : @"Theo hệ thống",
        @"看直播时退出时继续播放音频" : @"Tiếp tục phát âm thanh khi thoát LIVE",
        @"当前已是最新版本" : @"Đây là phiên bản mới nhất",
        @"在低电量或高热状态下自动进入省电优先模式" : @"Tự động ưu tiên tiết kiệm pin khi pin yếu hoặc máy nóng",
        @"开启后减少手机耗电，缓解发热。" : @"Bật để giảm hao pin và giảm nóng máy.",
        @"通讯录权限" : @"Quyền truy cập Danh bạ",
        @"接收“保单通知”消息" : @"Nhận thông báo \"Hợp đồng bảo hiểm\"",
        @"搜索中间页展示猜你想看" : @"Hiển thị \"Gợi ý cho bạn\" trong trang tìm kiếm",
        @"下次有新访客时将通知你" : @"Sẽ thông báo cho bạn khi có khách mới ghé thăm",
        @"及时获取动态消息" : @"Cập nhật tin tức kịp thời",
        @"开启通知，不错过朋友消息" : @"Bật thông báo để không bỏ lỡ tin nhắn từ bạn bè",
        @"请输入新登录密码" : @"Nhập mật khẩu đăng nhập mới",
        @"定位授权未开启" : @"Chưa bật quyền truy cập vị trí",
        @"开启定位后才能看到附近的视频和吃喝玩乐哦~" : @"Bật vị trí để khám phá video và các địa điểm ăn chơi gần bạn nhé~",
        @"密码需要8-20位，至少包含字母、数字、符号的任意两种" : @"Mật khẩu từ 8-20 ký tự, gồm ít nhất 2 loại: chữ cái, số hoặc ký tự đặc biệt",
        @"通过短信验证可以使用新密码" : @"Xác thực qua tin nhắn để sử dụng mật khẩu mới",
        @"获取短信验证码" : @"Lấy mã xác thực",
        @"关闭后，将无法自动识别你复制的口令以展示相应内容" : @"Nếu tắt, sẽ không thể tự động nhận diện mã đã sao chép để hiển thị nội dung tương ứng.",
        @"第三方内容同步平台" : @"Nền tảng đồng bộ nội dung bên thứ 3",
        @"今日头条 / 西瓜视频 / 懂车帝" : @"Toutiao / Xigua Video / Dongchedi",
        @"-同步抖音头像和昵称信息" : @"- Đồng bộ ảnh đại diện và biệt danh Douyin",
        @"公开后将展示在主页，有机会被推荐给其他人" : @"Sau khi công khai sẽ hiển thị trên trang cá nhân, có cơ hội được đề xuất cho người khác",
        @"最多16个字，只允许包含字母、数字、下划线和点，180天内仅能修改1次" : @"Tối đa 16 ký tự, chỉ được chứa chữ cái, số, dấu gạch dưới và dấu chấm; chỉ được đổi 1 lần trong 180 ngày",
        @"点击标签可@你关心的人，并将TA展示到主页" : @"Nhấn vào nhãn để @người bạn quan tâm và hiển thị họ trên trang chủ",
        @"仅展示 30 天内已授权的访客，访客记录仅你可见" : @"Chỉ hiển thị khách truy cập đã cho phép trong 30 ngày qua, lịch sử này chỉ mình bạn thấy",
        @"成为朋友需要你的确认，你可以在「我-互关」下找到互关的人。" : @"Cần bạn xác nhận để trở thành bạn bè, bạn có thể tìm người theo dõi lẫn nhau tại mục \"Tôi - Bạn bè\".",
        @"互相关注的人已迁移到「我-互关」下" : @"Người theo dõi lẫn nhau đã được chuyển sang mục 'Tôi - Bạn bè'",
        @"暂无朋友" : @"Chưa có bạn bè",
        @"去添加朋友" : @"Đi thêm bạn bè",
        @"点击添加介绍，让大家认识你…" : @"Nhấn để thêm tiểu sử, giúp mọi người biết đến bạn…",
        @"已缓存的推荐视频" : @"Video đề xuất đã tải sẵn",
        @"不耗流量看视频，离线正常刷抖音" : @"Xem video không tốn data, lướt Douyin bình thường khi ngoại tuyến",
        @"暂无更多内容" : @"Không còn nội dung",
        @"创建新账号，结交新朋友" : @"Tạo tài khoản mới, kết thêm bạn mới",
        @"设置头像和昵称，两步轻松创建账号" : @"Đặt ảnh đại diện và biệt danh, tạo tài khoản dễ dàng chỉ với 2 bước",
        @"仅开启朋友通知" : @"Chỉ bật thông báo từ bạn bè",
        @"聊天记录空间管理" : @"Quản lý dung lượng trò chuyện",
        @"设置后将影响通知接收范围" : @"Sau khi thiết lập sẽ ảnh hưởng đến phạm vi nhận thông báo",
        @"更改后，仅会收到来自「来自关注」的通知，其中也包含你的朋友；同时将影响部分通知详细设置。" : @"Sau khi thay đổi, bạn sẽ chỉ nhận được thông báo từ 'Người đang theo dõi', bao gồm cả bạn bè của bạn; đồng thời sẽ ảnh hưởng đến một số thiết lập thông báo chi tiết.",
        @"更改后，仅会收到来自「来自朋友」的通知，同时将影响部分通知详细设置。" : @"Sau khi thay đổi, bạn sẽ chỉ nhận được thông báo từ 'Bạn bè', đồng thời sẽ ảnh hưởng đến một số thiết lập thông báo chi tiết.",
        @"可能错过互关朋友的重要消息" : @"Có thể bỏ lỡ tin nhắn quan trọng từ bạn bè theo dõi lẫn nhau",
        @"可选择仅接收「来自朋友」的通知，保持及时联系" : @"Có thể chọn chỉ nhận thông báo từ 'Bạn bè' để duy trì liên lạc kịp thời",
        @"对Siri说 “打开抖音扫一扫”" : @"Nói với Siri “Mở Quét mã Douyin”",
        @"暂不支持向对方发送私信" : @"Tạm thời không hỗ trợ gửi tin nhắn cho người này",
        @"对Siri说 “打开抖音商城”" : @"Nói với Siri “Mở Cửa hàng Douyin”",
        @"对Siri说 “打开抖音钱包”" : @"Nói với Siri “Mở Ví Douyin”",
        @"对Siri说 “打开抖音隐私设置”" : @"Nói với Siri “Mở cài đặt quyền riêng tư Douyin”",
        @"打开抖音隐私设置" : @"Mở cài đặt quyền riêng tư Douyin",
        @"我的直播连线可被推荐给" : @"Livestream chung của tôi có thể được đề xuất cho",
        @"发现新版本" : @"Phát hiện phiên bản mới",
         @"我们优化了多项功能，快来下载新版本试试吧！" : @"Chúng tôi đã tối ưu hóa nhiều tính năng, hãy tải xuống phiên bản mới để trải nghiệm ngay!",
        @"暂无需要清理的关注关系" : @"Tạm thời không có quan hệ theo dõi nào cần dọn dẹp",
        @"关闭后，他人不能通过作品推荐、可能认识的人找到我。" : @"Sau khi tắt, người khác sẽ không thể tìm thấy tôi thông qua đề xuất tác phẩm hoặc mục người có thể quen.",
        @"暂无黑名单列表，可以在他人主页右上角更多中设置" : @"Tạm thời không có danh sách đen, có thể thiết lập trong mục Thêm ở góc trên bên phải trang cá nhân của người khác",
        @"仅你的粉丝可以看到你的作品和日常，关注请求需要经过你的批准。" : @"Chỉ người theo dõi mới có thể xem tác phẩm và nhật ký của bạn, yêu cầu theo dõi cần phải được bạn phê duyệt.",
        @"关闭后，不再接受通讯录的人、可能认识的人和共同朋友等推荐。" : @"Sau khi tắt, sẽ không còn nhận đề xuất từ danh bạ, người có thể quen và bạn chung, v.v.",
        @"暂无“不看他(她)的内容”用户，可以在他人主页右上角更多中设置" : @"Tạm thời không có người dùng nào trong danh sách “Không xem nội dung của họ”, có thể thiết lập trong mục Thêm ở góc trên bên phải trang cá nhân của người khác",
        @"暂无“不让他(她)看我的内容”用户，可以在他人主页右上角更多中设置" : @"Tạm thời không có người dùng nào trong danh sách “Không cho họ xem nội dung của tôi”, có thể thiết lập trong mục Thêm ở góc trên bên phải trang cá nhân của người khác",
        @"开启后，互相关注的人可以看到对方的在线状态，群聊中会展示在线人数。" : @"Sau khi bật, những người theo dõi lẫn nhau có thể thấy trạng thái trực tuyến của đối phương, số người trực tuyến sẽ được hiển thị trong nhóm chat.",
        @"关闭后，将看不到自己作品的浏览记录。你看他人作品也不会留下浏览记录。日常体裁的浏览记录不受本开关影响。" : @"Sau khi tắt, bạn sẽ không thấy lịch sử xem tác phẩm của mình. Việc bạn xem tác phẩm của người khác cũng sẽ không để lại dấu vết. Lịch sử xem của các nội dung nhật ký sẽ không bị ảnh hưởng bởi tùy chọn này.",
        @"关闭后，无法查看自己主页的访客记录。查看他人主页时也不会留下记录。" : @"Sau khi tắt, bạn không thể kiểm tra lịch sử khách truy cập trang cá nhân của mình. Khi xem trang cá nhân của người khác cũng sẽ không để lại bản ghi.",
        @"关闭后，该收藏列表会设为私密" : @"Sau khi tắt, danh sách yêu thích này sẽ được đặt thành riêng tư",
        @"互相关注的人可见" : @"Những người theo dõi lẫn nhau có thể xem",
        @"收藏夹管理" : @"Quản lý thư mục yêu thích",
        @"开启后，你的作品和直播会在同城页展示，可获得额外流量。" : @"Sau khi bật, tác phẩm và livestream của bạn sẽ hiển thị tại trang cùng thành phố, giúp nhận thêm lưu lượng truy cập.",
        @"开启后，你分享、加购、收藏、买过、评价的商品，可能在视频或直播、商城中被推荐给互相关注的朋友。相关商品会展示“朋友加购过”“朋友买过”等相关标签，但不会展示你的信息。隐私敏感商品不会被推荐。" : @"Sau khi bật, các sản phẩm mà bạn đã chia sẻ, thêm vào giỏ hàng, yêu thích, đã mua hoặc đánh giá có thể được đề xuất cho những người theo dõi lẫn nhau trong video, livestream hoặc trung tâm mua sắm. Các sản phẩm liên quan sẽ hiển thị các nhãn như “Bạn bè đã thêm vào giỏ hàng”, “Bạn bè đã mua”, v.v., nhưng sẽ không hiển thị thông tin của bạn. Các sản phẩm nhạy cảm về quyền riêng tư sẽ không được đề xuất.",
        @"展示「朋友买过」相关标签" : @"Hiển thị nhãn liên quan 「Bạn bè đã mua」",
        @"隐藏收件人真实手机号，保护隐私安全" : @"Ẩn số điện thoại thực của người nhận để bảo vệ an toàn quyền riêng tư",
        @"订单号码保护" : @"Bảo mật số điện thoại đơn hàng",
        @"我的直播连线可 được 推荐给" : @"Livestream chung của tôi có thể được đề xuất cho",
        @"看的直播推荐给朋友" : @"Đề xuất livestream đang xem cho bạn bè",
        @"玩家榜展示道具购买数据" : @"Hiển thị dữ liệu mua đạo cụ trên bảng xếp hạng người chơi",
        @"同城展示作品、直播" : @"Hiển thị tác phẩm, livestream tại cùng thành phố",
        @"主页喜欢列表" : @"Danh sách yêu thích trên trang cá nhân",
        @"被 @ " : @"Được @",
        @"谁可以 @ 我" : @"Ai có thể @ tôi",
        @"开启在线状态" : @"Bật trạng thái trực tuyến",
        @"不给谁看" : @"Không cho ai xem",
        @"密友可见" : @"Bạn thân có thể xem",
        @"部分可见" : @"Hiển thị với một số người",
        @"关闭在线状态" : @"Tắt trạng thái trực tuyến",
        @"不看他(她)的内容" : @"Không xem nội dung của họ",
        @"不让他(她)看我的内容" : @"Không cho họ xem nội dung của tôi",
        @"开启私密账号？" : @"Bật tài khoản riêng tư?",
        @"确定私密" : @"Xác nhận riêng tư",
        @"不接收通知" : @"Không nhận thông báo",
        @"仅接收朋友通知" : @"Chỉ nhận thông báo từ bạn bè",
        @"作品优先推荐，更新及时提示" : @"Ưu tiên đề xuất tác phẩm, thông báo cập nhật kịp thời",
        @"筛选类型" : @"Lọc theo loại",
        @"语音搜" : @"Tìm bằng giọng nói",
        @"批量缓存视频" : @"Tải nhiều video",
        @"不让她看" : @"Ẩn bài đăng với người này",
        @"求更新" : @"Nhắc ra video mới",
        @"特别关注" : @"Theo dõi đặc biệt",
        @"分享名片" : @"Chia sẻ trang cá nhân",
        @"综合排序" : @"Sắp xếp mặc định",
        @"批量管理" : @"Quản lý hàng loạt",
        @"q批ư量管理" : @"Quản lý hàng loạt",
        @"省电优先" : @"Ưu tiên tiết kiệm pin",
        @"优惠活动" : @"Ưu đãi & Sự kiện",
        @"提现服务" : @"Dịch vụ rút tiền",
        @"活动提醒" : @"Nhắc nhở sự kiện",
        @"额度通知" : @"Thông báo hạn mức",
        @"充值结果" : @"Kết quả nạp tiền",
        @"保单通知" : @"Thông báo bảo hiểm",
        @"清理完成" : @"Dọn dẹp hoàn tất",
        @"暂无朋友申请" : @"Chưa có lời mời kết bạn",
        @"暂无更多" : @"Không còn nội dung",
        @"手机通讯录" : @"Danh bạ điện thoại",
        @"快速添加微信朋友" : @"Thêm nhanh bạn bè WeChat",
        @"去“推荐”看看" : @"Xem mục \"Dành cho bạn\"",
        @"剪切板读取权限" : @"Quyền truy cập Bộ nhớ tạm",
        @"相册权限" : @"Quyền truy cập Ảnh",
        @"位置权限" : @"Quyền truy cập Vị trí",
        @"相机权限" : @"Quyền truy cập Camera",
        @"麦克风权限" : @"Quyền truy cập Micro",
        @"个性化内容推荐" : @"Đề xuất nội dung cá nhân hóa",
         @"第三方登录方式" : @"Đăng nhập qua bên thứ 3",
        @"没有新通知" : @"Không có thông báo mới",
        @"开黑小伙伴" : @"Đồng đội leo rank",
        @"喜欢的达人" : @"Creator yêu thích",
        @"新建收藏夹" : @"Tạo bộ sưu tập mới",
        @"输入收藏夹名称" : @"Nhập tên bộ sưu tập",
        @"设置为公开" : @"Đặt là Công khai",
        @"创建收藏夹" : @"Tạo Bộ sưu tập",
        @"你们已互相关注对方" : @"Hai bạn đã theo dõi nhau",
        @"添加已有账号" : @"Thêm tài khoản đã có",
        @"创建新账号" : @"Tạo tài khoản mới",
        @"打开抖音钱包" : @"Mở Ví Douyin",
        @"打开抖音商城" : @"Mở Cửa hàng Douyin",
        @"打开抖音扫一扫" : @"Mở Quét mã Douyin",
        @"移除粉丝" : @"Gỡ người theo dõi",
        @"抖音扫一扫，立即关注我" : @"Quét mã Douyin, theo dõi tôi ngay",
        @"我的朋友" : @"Bạn bè của tôi",
        @"谁可以私信我" : @"Ai có thể gửi tin nhắn riêng cho tôi",
        @"自定义屏蔽词" : @"Tùy chỉnh từ ngữ bị chặn",
        @"添加屏蔽词" : @"Thêm từ ngữ bị chặn",
        @"换样式" : @"Đổi kiểu dáng",
        @"更多操作" : @"Thao tác khác",
        @"打招呼" : @"Lời chào",
        @"加入分组" : @"Thêm vào nhóm",
        @"新建分组" : @"Tạo nhóm mới",
        @"有更新" : @"Có bản cập nhật",
        @"退出？" : @"Thoát?",
        @"升级" : @"Cập nhật",
        @"添加指令" : @"Thêm lệnh",
        @"功能" : @"Tính năng",
        @"文件" : @"Tệp tin",
        @"剪切" : @"Cắt",
        @"拷贝" : @"Chép",
        @"粘贴" : @"Dán",
        @"翻译" : @"Dịch",
        @"选择" : @"Chọn",
        @"全选" : @"Chọn tất cả",
        @"用户" : @"Người dùng",
        @"影视综" : @"Phim & Show",
        @"未看完" : @"Chưa xem hết",
        @"已看完" : @"Đã xem hết",
        @"永远的神" : @"Mãi đỉnh",
        @"搬砖兄弟" : @"Anh em cày cuốc",
        @"共创伙伴" : @"Đối tác Collab",
        @"修改简介" : @"Sửa tiểu sử",
        @"恋人" : @"Người yêu",
        @"闺蜜" : @"Bạn thân",
        @"兄弟" : @"Anh em tốt",
        @"家人" : @"Gia đình",
        @"饭搭子" : @"Cạ ăn uống",
        @"小宝贝" : @"Bé cưng",
        @"理想型" : @"Gu lý tưởng",
        @"游戏" : @"Game",
        @"明星" : @"Người nổi tiếng",
        @"聊天" : @"Trò chuyện",
        @"唱歌" : @"Ca hát",
        @"团播" : @"Live nhóm",
        @"颜值" : @"Nhan sắc",
        @"观看记录" : @"Lịch sử xem",
        @"以后再说" : @"Để sau",
        @"微博" : @"Weibo",
        @"未绑定" : @"Chưa liên kết",
        @"其他权限" : @"Các quyền khác",
        @"去设置" : @"Đi tới Cài đặt",
        @"智能开启" : @"Bật thông minh",
        @"卡券过期" : @"Voucher hết hạn",
        @"卡券到账" : @"Đã nhận Voucher",
        @"红包服务" : @"Dịch vụ Lì xì",
        @"为你推荐" : @"Dành cho bạn",
        @"列表为空" : @"Danh sách trống",
        @"浅色" : @"Sáng",
        @"经典" : @"Cổ điển",
        @"自动切换" : @"Tự động",
        @"标准" : @"Chuẩn",
        @"大号" : @"Lớn",
        @"超大号" : @"Siêu lớn",
        @"不接收" : @"Không nhận",
        @"部分开启" : @"Bật một phần",
        @"猜你想看" : @"Gợi ý cho bạn",
        @"确定" : @"Xác nhận",
        @"消息页" : @"Mục Tin nhắn",
        @"离线视频" : @"Video đã tải",
        @"管理" : @"Quản lý",
        @"清理" : @"Dọn dẹp",
        @"缓存" : @"Tải về",
        @"去开启" : @"Bật ngay",
        @"暂不开启" : @"Để sau",
        @"回复" : @"Trả lời",
        @"最近关注" : @"Mới theo dõi",
        @"我的关注" : @"Đang theo dõi",
        @"直播中" : @"Đang LIVE",
        @"已关注" : @"Đã theo dõi",
        @"发私信" : @"Nhắn tin",
        @"设置备注" : @"Đặt tên gợi nhớ",
        @"设置分组" : @"Phân nhóm",
        @"加朋友" : @"Kết bạn",
        @"取消关注" : @"Bỏ theo dõi",
        @"拉黑" : @"Chặn",
        @"0 粉丝" : @"0 người theo dõi",
        @"导入音频" : @"Nhập âm thanh",
        @"热门" : @"Thịnh hành",
        @"拍摄模式" : @"Chế độ quay",
        @"最近项目" : @"Dự án gần đây",
        @"图片" : @"Ảnh",
        @"下一步" : @"Tiếp",
        @"网格" : @"Lưới",
        @"照片" : @"Ảnh",
        @"选择音乐" : @"Chọn nhạc",
        @"分段拍" : @"Quay nhiều đoạn",
        @"照片开直播" : @"LIVE bằng ảnh",
        @"创作灵感" : @"Cảm hứng",
        @"翻转" : @"Lật",
        @"闪光灯" : @"Đèn flash",
        @"动图" : @"Ảnh động",
        @"灵感跟拍" : @"Quay theo\nmẫu",
        @"倒计时" : @"Hẹn giờ",
        @"美颜" : @"Làm đẹp",
        @"滤镜" : @"Bộ lọc",
        @"收起" : @"Thu gọn",
        @"再想想" : @"Để sau",
        @"私聊" : @"Tin nhắn riêng",
        @"群聊" : @"Trò chuyện nhóm",
        @"客服消息" : @"Tin nhắn CSKH",
        @"通话" : @"Cuộc gọi",
        @"三列" : @"3 cột",
        @"双列" : @"2 cột",
        @"查看抖音码" : @"Xem mã Douyin",
        @"视频": @"Video",
        @"互动消息": @"Tương tác",
        @"编辑主页": @"Sửa hồ sơ",
        @"开启访客": @"Bật ngay",
        @"保持关闭": @"Giữ tắt",
        @"缓存视频": @"Tải video",
        @"不开启": @"Tắt",
        @"播完当前": @"Hết video này",
        @"15 分钟": @"15 phút",
        @"30 分钟": @"30 phút",
        @"60 分钟": @"60 phút",
        @"自定义": @"Tùy chỉnh",
        @"提及": @"Nhắc đến (@)"
    };
    
    NSString *kq = dict[text];
    if (kq) return kq;

    if ([text containsString:@"已阅读并同意"]) {
        return @"Đã đọc và đồng ý với Thỏa thuận người dùng, Chính sách quyền riêng tư和 Thỏa thuận dịch vụ nhà mạng. Đồng thời đăng nhập và sử dụng Douyin.";
    }
    
    if ([text containsString:@"条评论"]) {
        return [text stringByReplacingOccurrencesOfString:@"条评论" withString:@" bình luận"];
    }

    if ([text containsString:@"账号已退出登录"]) {
        return [text stringByReplacingOccurrencesOfString:@"账号已退出登录\n\n账号登录信息失效，请重新登录" withString:@"Tài khoản đã đăng xuất\n\nPhiên đăng nhập hết hạn, vui lòng đăng nhập lại"];
    }

    if ([text containsString:@"短信已发送至"]) {
        return [text stringByReplacingOccurrencesOfString:@"短信已发送至" withString:@"Mã xác thực đã gửi đến "];
    }
    
    if ([text containsString:@"秒后重新发送"]) {
        return [text stringByReplacingOccurrencesOfString:@"秒后重新发送" withString:@" giây để gửi lại"];
    }
    
    if ([text containsString:@"占设备"] && [text containsString:@"存储空间"]) {
        NSString *s1 = [text stringByReplacingOccurrencesOfString:@"占设备" withString:@"Chiếm "];
        return [s1 stringByReplacingOccurrencesOfString:@"存储空间" withString:@" bộ nhớ"];
    }
    
    if ([text containsString:@"资料完成度"]) {
        return [text stringByReplacingOccurrencesOfString:@"资料完成度" withString:@"Hoàn thiện hồ sơ"];
    }
    
    if ([text containsString:@"绑定的信息可用于"]) {
        return @"Thông tin liên kết dùng để đăng nhập hoặc xác minh danh tính, giúp bảo vệ tài khoản";
    }
    
    if ([text containsString:@"未成年人问题反馈"]) {
        return @"Phản hồi vấn đề trẻ vị thành niên 400-140-2108 máy lẻ 3";
    }
    
    if ([text containsString:@"开启后，仅允许互相关注的人私信你"]) {
        return @"Khi bật, chỉ Bạn bè mới được nhắn tin/bình luận, chỉ người Follow mới tìm thấy bạn.";
    }

     if ([text containsString:@"钱包服务："] && [text containsString:@"元现金待提现"]) {
        NSString *s1 = [text stringByReplacingOccurrencesOfString:@"钱包服务：" withString:@"Dịch vụ ví: "];
        return [s1 stringByReplacingOccurrencesOfString:@"元现金待提现" withString:@" NDT tiền mặt dáng chờ rút"];
    }
    
    if ([text containsString:@"展开"] && [text containsString:@"条回复"]) {
        NSString *s1 = [text stringByReplacingOccurrencesOfString:@"展开" withString:@"Xem "];
        return [s1 stringByReplacingOccurrencesOfString:@"条回复" withString:@" trả lời"];
    }

     if ([text hasPrefix:@"我的互关"]) {
        NSString *s1 = [text stringByReplacingOccurrencesOfString:@"我的互关" withString:@"Bạn bè "];
        return [s1 stringByReplacingOccurrencesOfString:@"人)" withString:@" người)"];
    }

     if ([text hasPrefix:@"我的关注"]) {
        NSString *s1 = [text stringByReplacingOccurrencesOfString:@"我的关注" withString:@"Đang theo dõi "];
        return [s1 stringByReplacingOccurrencesOfString:@"人)" withString:@" người)"];
    }

     if ([text hasPrefix:@"我的粉丝"]) {
        NSString *s1 = [text stringByReplacingOccurrencesOfString:@"我的粉丝" withString:@"Người theo dõi "];
        return [s1 stringByReplacingOccurrencesOfString:@"人)" withString:@" người)"];
    }

     if ([text hasPrefix:@"将清理抖音缓存数据，可释放"]) {
        NSString *s1 = [text stringByReplacingOccurrencesOfString:@"将清理抖音缓存数据，可释放" withString:@"Xoá bộ nhớ đệm Douyin, giải phóng "];
        return [s1 stringByReplacingOccurrencesOfString:@"存储空间" withString:@" dung lượng lưu trữ"];
    }

     if ([text hasPrefix:@"已使用"]) {
        NSString *s1 = [text stringByReplacingOccurrencesOfString:@"已使用" withString:@"Đã sử dụng "];
        return [s1 stringByReplacingOccurrencesOfString:@"可用空间" withString:@"Còn trống "];
    }

     if ([text hasPrefix:@"喜欢"]) {
        NSString *s1 = [text stringByReplacingOccurrencesOfString:@"喜欢" withString:@"Đã thích "];
        return [s1 stringByReplacingOccurrencesOfString:@"万" withString:@" k"];
    }

     if ([text hasPrefix:@"草稿 "]) {
        return [text stringByReplacingOccurrencesOfString:@"草稿 " withString:@"Bản nháp "];
    }

     if ([text hasPrefix:@"version "]) {
        return [text stringByReplacingOccurrencesOfString:@"version " withString:@"Phiên bản "];
    }

     if ([text hasPrefix:@"抖音 version "]) {
        return [text stringByReplacingOccurrencesOfString:@"抖音 version " withString:@"Douyin phiên bản "];
    }

     if ([text hasPrefix:@"作品 "]) {
        return [text stringByReplacingOccurrencesOfString:@"作品 " withString:@"Video "];
    }

     if ([text hasPrefix:@"新访客 "]) {
        return [text stringByReplacingOccurrencesOfString:@"新访客 " withString:@"Khách truy cập mới "];
    }

     if ([text hasPrefix:@"抖音号: "]) {
        return [text stringByReplacingOccurrencesOfString:@"抖音号: " withString:@"Douyin ID: "];
    }

    if ([text hasPrefix:@"抖音号："]) {
        return [text stringByReplacingOccurrencesOfString:@"抖音号: " withString:@"Douyin ID: "];
    }
    
    return nil;
}

%hook UILabel

- (void)setText:(NSString *)text {
    %orig(DichDouyin(text) ?: text);
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    if (!attributedText) { %orig; return; }
    NSString *dich = DichDouyin(attributedText.string);
    if (dich) {
        NSMutableAttributedString *newAttr = [attributedText mutableCopy];
        [newAttr.mutableString setString:dich];
        %orig(newAttr);
    } else {
        %orig(attributedText);
    }
}

%end

%hook UIButton

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    %orig(DichDouyin(title) ?: title, state);
}

- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state {
    if (!title) { %orig; return; }
    NSString *dich = DichDouyin(title.string);
    if (dich) {
        NSMutableAttributedString *newAttr = [title mutableCopy];
        [newAttr.mutableString setString:dich];
        %orig(newAttr, state);
    } else {
        %orig(title, state);
    }
}

%end

%hook UITextField

- (void)setPlaceholder:(NSString *)placeholder {
    %orig(DichDouyin(placeholder) ?: placeholder);
}

- (void)setAttributedPlaceholder:(NSAttributedString *)placeholder {
    if (!placeholder) { %orig; return; }
    NSString *dich = DichDouyin(placeholder.string);
    if (dich) {
        NSMutableAttributedString *newAttr = [placeholder mutableCopy];
        [newAttr.mutableString setString:dich];
        %orig(newAttr);
    } else {
        %orig(placeholder);
    }
}

%end

%hook YYLabel

- (void)setText:(NSString *)text {
    %orig(DichDouyin(text) ?: text);
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    if (!attributedText) { %orig; return; }
    NSString *dich = DichDouyin(attributedText.string);
    if (dich) {
        NSMutableAttributedString *newAttr = [attributedText mutableCopy];
        [newAttr.mutableString setString:dich];
        %orig(newAttr);
    } else {
        %orig(attributedText);
    }
}

%end

%hook LynxTextView

- (void)setText:(NSString *)text {
    %orig(DichDouyin(text) ?: text);
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    if (!attributedText) { %orig; return; }
    NSString *dich = DichDouyin(attributedText.string);
    if (dich) {
        NSMutableAttributedString *newAttr = [attributedText mutableCopy];
        [newAttr.mutableString setString:dich];
        %orig(newAttr);
    } else {
        %orig(attributedText);
    }
}

%end

%hook TTTAttributedLabel

- (void)setText:(id)text {
    if ([text isKindOfClass:[NSString class]]) {
        %orig(DichDouyin(text) ?: text);
    } else if ([text isKindOfClass:[NSAttributedString class]]) {
        NSAttributedString *attr = (NSAttributedString *)text;
        NSString *dich = DichDouyin(attr.string);
        if (dich) {
            NSMutableAttributedString *newAttr = [attr mutableCopy];
            [newAttr.mutableString setString:dich];
            %orig(newAttr);
        } else {
            %orig(text);
        }
    } else {
        %orig(text);
    }
}

%end

%hook UITabBarButton

- (void)layoutSubviews {
    %orig;
    for (UIView *sub in self.subviews) {
        if ([sub isKindOfClass:[UILabel class]]) {
            UILabel *lbl = (UILabel *)sub;
            NSString *dich = DichDouyin(lbl.text);
            if (dich) lbl.text = dich;
        }
    }
}

%end
