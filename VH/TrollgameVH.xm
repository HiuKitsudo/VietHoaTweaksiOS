#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *translate(NSString *text) {
    if (!text || ![text isKindOfClass:[NSString class]] || text.length == 0) return text;
    
    static NSDictionary *viTranslations = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        viTranslations = @{
            @"系统清理" : @"Dọn Dẹp Hệ Thống",
            @"释放设备存储空间" : @"Giải phóng dung lượng",
            @"已用" : @"Đã dùng",
            @"巨魔环境" : @"Môi trường TrollStore",
            @"清理选项" : @"Tùy Chọn Dọn Dẹp",
            @"Safari缓存/历史/Cookies" : @"Cache/Lịch sử/Cookie Safari",
            @"用户应用程序缓存" : @"Bộ đệm ứng dụng",
            @"OTA软件更新" : @"Bản cập nhật OTA",
            @"电池使用数据" : @"Dữ liệu sử dụng pin",
            @"系统日志文件" : @"Tệp nhật ký hệ thống",
            @"系统缓存文件" : @"Tệp bộ đệm hệ thống",
            @"系统临时文件" : @"Tệp tạm hệ thống",
            @"立即清理" : @"Dọn Dẹp Ngay",
            @"应用管理" : @"Quản Lý Ứng Dụng",
            @"管理已安装的应用" : @"Quản lý ứng dụng đã cài đặt",
            @"搜索应用" : @"Tìm kiếm ứng dụng",
            @"全部" : @"Tất cả",
            @"用户" : @"Người dùng",
            @"巨魔" : @"TrollStore",
            @"系统" : @"Hệ thống",
            @"清理" : @"Dọn dẹp",
            @"应用" : @"Ứng dụng",
            @"工具" : @"Công cụ",
            @"设置" : @"Cài đặt",
            @"逆向工具" : @"Công Cụ Dịch Ngược",
            @"动态注入" : @"Tiêm Code Động",
            @"一键破解" : @"Crack 1 Chạm",
            @"Hook 管理" : @"Quản Lý Hook",
            @"数据管理" : @"Quản Lý Dữ Liệu",
            @"清理数据" : @"Xóa Dữ Liệu",
            @"刷新标识符" : @"Làm Mới Định Danh",
            @"清理钥匙串" : @"Xóa Keychain",
            @"基础操作" : @"Thao Tác Cơ Bản",
            @"复制 ID" : @"Sao Chép ID",
            @"一键脱壳" : @"Giải mã 1 Chạm",
            @"启动应用" : @"Mở Ứng Dụng",
            @"工具箱" : @"Hộp Công Cụ",
            @"逆向工程辅助工具" : @"Công cụ hỗ trợ dịch ngược",
            @"AI 智能助手" : @"Trợ Lý AI",
            @"全局悬浮对话，随时随地提问" : @"Khung chat nổi toàn cục, hỏi đáp mọi lúc mọi nơi",
            @"汇编转换" : @"Chuyển Đổi Assembly",
            @"ARM64 汇编/机器码双向转换" : @"Chuyển đổi 2 chiều Assembly/Mã máy ARM64",
            @"偏移计算器" : @"Máy Tính Offset",
            @"Base + Offset + ASLR Slide 地址计算" : @"Tính toán địa chỉ Base + Offset + ASLR Slide",
            @"网站真实IP查询" : @"Tra Cứu IP Thực Website",
            @"一键揭翻CDN找到网站真实IP" : @"Xuyên qua CDN tìm IP thực của trang web",
            @"内核无痕内存调试" : @"Debug Bộ Nhớ Kernel Ẩn",
            @"内存搜索/修改/硬件断点/汇编查看" : @"Tìm/Sửa bộ nhớ/Breakpoint phần cứng/Xem Assembly",
            @"点击登录" : @"Nhấn Để Đăng Nhập",
            @"登录 Apibug.com 解锁更多功能" : @"Đăng nhập Apibug.com mở khóa thêm tính năng",
            @"AI 配置" : @"Cấu Hình AI",
            @"未配置，点击设置" : @"Chưa cấu hình, nhấn để cài đặt",
            @"官方团队" : @"Nhóm Phát Triển",
            @"Telegram 频道" : @"Kênh Telegram",
            @"Telegram 群组" : @"Nhóm Telegram",
            @"官方 QQ 群" : @"Nhóm QQ Chính Thức",
            @"项目贡献者" : @"Người Đóng Góp (Dịch bởi Kitsudo)",
            @"核心开发者" : @"Lập trình viên cốt lõi",
            @"安全研究员" : @"Chuyên gia bảo mật",
            @"已复制 Bundle ID" : @"Đã sao chép Bundle ID",
            @"将同时更换 Bundle 和 Data 容器的 UUID\n应用数据保留，标识符全部刷新" : @"Thay đổi đồng thời UUID của Bundle và Data\nGiữ nguyên dữ liệu, làm mới toàn bộ định danh",
            @"将同时更换 Bundle 和 Data 容器的 UUID" : @"Thay đổi đồng thời UUID của Bundle và Data",
            @"应用数据保留，标识符全部刷新" : @"Giữ nguyên dữ liệu, làm mới toàn bộ định danh",
            @"包括登录凭据、Token 等，此操作不可恢复" : @"Bao gồm thông tin đăng nhập, Token v.v., thao tác không thể khôi phục",
            @"此操作不可恢复" : @"Thao tác không thể khôi phục",
            @"取消" : @"Hủy",
            @"确认刷新" : @"Xác nhận làm mới",
            @"确认清理" : @"Xác nhận dọn dẹp",
            @"正向计算" : @"Tính Tiến",
            @"反向计算" : @"Tính Ngược",
            @"Base + Offset + Slide = 实际地址" : @"Base + Offset + Slide = Địa chỉ thực tế",
            @"ASLR Slide (可选)" : @"ASLR Slide (Tùy chọn)",
            @"计算" : @"Tính toán",
            @"汇编 -> Hex" : @"Assembly -> Hex",
            @"Hex -> 汇编" : @"Hex -> Assembly",
            @"输入" : @"Đầu vào",
            @"输出" : @"Đầu ra",
            @"结果将显示在这里" : @"Kết quả sẽ hiển thị ở đây",
            @"转换" : @"Chuyển đổi",
            @"内存调试" : @"Debug Bộ Nhớ",
            @"功能开发中..." : @"Tính năng đang phát triển...",
            @"用户名" : @"Tên đăng nhập",
            @"密码" : @"Mật khẩu",
            @"登录" : @"Đăng nhập",
            @"还没有账号？立即注册" : @"Chưa có tài khoản? Đăng ký ngay",
            @"还没有账号？" : @"Chưa có tài khoản? ",
            @"立即注册" : @"Đăng ký ngay",
            @"选择引擎" : @"Chọn Engine",
            @"火山引擎" : @"Volcengine",
            @"前往注册" : @"Đi tới Đăng ký",
            @"豆包 Seed / GLM 系列" : @"Dòng Doubao Seed / GLM",
            @"API 密钥" : @"Khóa API",
            @"选择模型" : @"Chọn Model",
            @"旗舰推理，深度思考" : @"Suy luận Flagship, Suy nghĩ sâu",
            @"代码专精，逆向利器" : @"Chuyên Code, Công cụ dịch ngược",
            @"高性价比推理" : @"Suy luận hiệu năng cao",
            @"智谱旗舰，综合能力强" : @"Zhipu Flagship, Năng lực mạnh",
            @"测试连接" : @"Kiểm tra kết nối",
            @"脱壳完成" : @"Giải mã Hoàn Tất",
            @"关闭" : @"Đóng",
            @"分享 IPA" : @"Chia Sẻ IPA",
            @"正在脱壳..." : @"Đang giải mã...",
            @"请勿退出应用" : @"Vui lòng không thoát ứng dụng",
            @"清理完成" : @"Dọn dẹp hoàn tất",
            @"没有可清理的文件" : @"Không có tệp nào để dọn dẹp",
            @"没有可清理的数据" : @"Không có dữ liệu để dọn dẹp",
            @"确定" : @"Xác nhận",
            @"标识符已更换" : @"Đã thay đổi định danh",
            @"未找到相关钥匙串数据（可能已清理或无权限访问）" : @"Không tìm thấy dữ liệu Keychain (có thể đã xóa hoặc không có quyền)",
            @"正在扫描文件..." : @"Đang quét tệp...",
            @"读取应用列表..." : @"Đang tải danh sách ứng dụng...",
            @"正在更换标识符..." : @"Đang thay đổi định danh...",
            @"正在终止进程..." : @"Đang kết thúc tiến trình...",
            @"搜索类名 / 方法名 / 属性名" : @"Tìm Tên class / Hàm / Thuộc tính",
            @"方法" : @"Phương thức",
            @"模块" : @"Module",
            @"已复制到剪贴板" : @"Đã sao chép vào Clipboard",
            @"AI 分析" : @"Phân Tích AI",
            @"分析参数" : @"Tham Số Phân Tích",
            @"每批发送类数量" : @"Số class gửi mỗi đợt",
            @"数值越大上下文越丰富，但可能超出模型限制" : @"Số càng lớn ngữ cảnh càng sâu, có thể vượt giới hạn model",
            @"选择分析方向" : @"Chọn Hướng Phân Tích",
            @"破解 VIP / 会员" : @"Crack VIP / Membership",
            @"去除广告" : @"Xóa Quảng Cáo",
            @"绕过越狱检测" : @"Bypass Phát Hiện Jailbreak",
            @"破解网络验证" : @"Crack Xác Thực Mạng",
            @"全面分析" : @"Phân Tích Toàn Diện",
            @"自定义提问（可选）" : @"Câu Hỏi Tùy Chỉnh (Tùy chọn)",
            @"填写后将替代上方模板，直接发送给 AI" : @"Nội dung điền sẽ thay thế mẫu trên và gửi trực tiếp cho AI",
            @"开始 AI 分析" : @"Bắt Đầu Phân Tích AI",
            @"运行中・点击关闭" : @"Đang chạy・Nhấn để đóng",
            @"新对话" : @"Cuộc Trò Chuyện Mới",
            @"点击输入消息..." : @"Nhấn để nhập tin nhắn...",
            @"深度求索 V3.2 / R1" : @"DeepSeek V3.2 / R1",
            @"最新通用模型，性价比极高" : @"Model đa dụng mới nhất, hiệu năng cao",
            @"深度推理，复杂逻辑分析" : @"Suy luận sâu, phân tích logic phức tạp",
            @"Gemini 3 / 2.5 系列" : @"Dòng Gemini 3 / 2.5",
            @"最新旗舰预览版，全能推理" : @"Bản Preview Flagship mới nhất, suy luận toàn năng",
            @"最新快速模型预览版，性价比极高" : @"Bản Preview Model nhanh mới nhất, hiệu năng cực cao",
            @"旗舰预览版，深度推理" : @"Bản Preview Flagship, suy luận sâu",
            @"快速推理，100万token上下文" : @"Suy luận nhanh, ngữ cảnh 1 triệu token",
            @"上代旗舰，深度思考" : @"Flagship thế hệ trước, suy nghĩ sâu sắc",
            @"分析历史" : @"Lịch Sử Phân Tích",
            @"暂无分析记录" : @"Chưa có bản ghi phân tích",
            @"完成一次 AI 分析并应用后会自动保存" : @"Tự động lưu sau khi hoàn thành và áp dụng 1 phân tích AI"
        };
    });

    NSString *translated = viTranslations[text];
    if (translated) return translated;

    NSMutableString *dynamicText = [text mutableCopy];
    BOOL isChanged = NO;
    
    if ([dynamicText containsString:@"在钥匙串中的所有数据"]) {
        [dynamicText replaceOccurrencesOfString:@"将删除 " withString:@"Sẽ xóa toàn bộ dữ liệu của " options:0 range:NSMakeRange(0, dynamicText.length)];
        [dynamicText replaceOccurrencesOfString:@" 在钥匙串中的所有数据" withString:@" trong Keychain" options:0 range:NSMakeRange(0, dynamicText.length)];
        isChanged = YES;
    }
    else if ([dynamicText containsString:@"沙盒内全部数据？"]) {
        [dynamicText replaceOccurrencesOfString:@"是否清理 " withString:@"Xóa toàn bộ dữ liệu Sandbox của " options:0 range:NSMakeRange(0, dynamicText.length)];
        [dynamicText replaceOccurrencesOfString:@" 沙盒内全部数据？" withString:@"?" options:0 range:NSMakeRange(0, dynamicText.length)];
        isChanged = YES;
    }
    else if ([dynamicText containsString:@"正在脱壳扩展"]) {
        [dynamicText replaceOccurrencesOfString:@"正在脱壳扩展 " withString:@"Đang giải mã extension " options:0 range:NSMakeRange(0, dynamicText.length)];
        isChanged = YES;
    }
    else if ([dynamicText containsString:@"正在打包 IPA..."]) {
        [dynamicText replaceOccurrencesOfString:@"正在打包 IPA..." withString:@"Đang đóng gói IPA..." options:0 range:NSMakeRange(0, dynamicText.length)];
        isChanged = YES;
    }
    else if ([dynamicText containsString:@"扫描完成，发现"]) {
        [dynamicText replaceOccurrencesOfString:@"扫描完成，发现 " withString:@"Quét hoàn tất, phát hiện " options:0 range:NSMakeRange(0, dynamicText.length)];
        [dynamicText replaceOccurrencesOfString:@" 个文件" withString:@" tệp" options:0 range:NSMakeRange(0, dynamicText.length)];
        isChanged = YES;
    }
    else if ([dynamicText containsString:@"已清理全部数据，释放"]) {
        [dynamicText replaceOccurrencesOfString:@"已清理全部数据，释放 " withString:@"Đã xóa toàn bộ dữ liệu, giải phóng " options:0 range:NSMakeRange(0, dynamicText.length)];
        isChanged = YES;
    }
    else if ([dynamicText containsString:@"新 Bundle UUID:"]) {
        [dynamicText replaceOccurrencesOfString:@"新 Bundle UUID:" withString:@"Bundle UUID mới:" options:0 range:NSMakeRange(0, dynamicText.length)];
        isChanged = YES;
    }
    else if ([dynamicText containsString:@"新 Data UUID:"]) {
        [dynamicText replaceOccurrencesOfString:@"新 Data UUID:" withString:@"Data UUID mới:" options:0 range:NSMakeRange(0, dynamicText.length)];
        isChanged = YES;
    }
    else if ([dynamicText containsString:@" 方法"]) {
        [dynamicText replaceOccurrencesOfString:@" 方法" withString:@" Phương thức" options:0 range:NSMakeRange(0, dynamicText.length)];
        isChanged = YES;
    }
    else if ([dynamicText containsString:@" 模块"]) {
        [dynamicText replaceOccurrencesOfString:@" 模块" withString:@" Module" options:0 range:NSMakeRange(0, dynamicText.length)];
        isChanged = YES;
    }

    if (isChanged) {
        return [dynamicText copy]; 
    }

    return text;
}

// 1. CHẶN KHI APP TẢI NGÔN NGỮ QUA NSBUNDLE
%hook NSBundle
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    NSString *orig = %orig;
    NSString *translated = translate(orig);
    
    if (![translated isEqualToString:orig]) return translated;
    
    NSString *translatedKey = translate(key);
    if (![translatedKey isEqualToString:key]) return translatedKey;
    
    return orig;
}
%end

// 2. CHẶN NGAY KHI KHỞI TẠO ATTRIBUTED STRING (Bước đệm trước CoreText)
%hook NSAttributedString
- (instancetype)initWithString:(NSString *)str {
    return %orig(translate(str));
}
- (instancetype)initWithString:(NSString *)str attributes:(NSDictionary<NSAttributedStringKey,id> *)attrs {
    return %orig(translate(str), attrs);
}
%end

%hook NSMutableAttributedString
- (instancetype)initWithString:(NSString *)str {
    return %orig(translate(str));
}
- (instancetype)initWithString:(NSString *)str attributes:(NSDictionary<NSAttributedStringKey,id> *)attrs {
    return %orig(translate(str), attrs);
}
%end

// 3. UI COMPONENTS TIÊU CHUẨN (Phòng hờ các view bình thường)
%hook UILabel
- (void)setText:(NSString *)text {
    %orig(translate(text));
}
- (void)setAttributedText:(NSAttributedString *)attributedText {
    if (!attributedText || ![attributedText isKindOfClass:[NSAttributedString class]]) {
        %orig(attributedText);
        return;
    }
    NSString *originalString = attributedText.string;
    NSString *translatedString = translate(originalString);
    if (translatedString && ![originalString isEqualToString:translatedString]) {
        NSMutableAttributedString *mutAttr = [attributedText mutableCopy];
        [mutAttr.mutableString setString:translatedString];
        %orig([mutAttr copy]);
    } else {
        %orig(attributedText);
    }
}
%end

%hook UITextField
- (void)setPlaceholder:(NSString *)placeholder {
    %orig(translate(placeholder));
}
- (void)setText:(NSString *)text {
    %orig(translate(text));
}
%end

%hook UITextView
- (void)setText:(NSString *)text {
    %orig(translate(text));
}
%end

%hook UITabBarItem
- (void)setTitle:(NSString *)title {
    %orig(translate(title));
}
%end

%hook UIButton
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    %orig(translate(title), state);
}
%end

%hook UIViewController
- (void)setTitle:(NSString *)title {
    %orig(translate(title));
}
%end

%hook UINavigationItem
- (void)setTitle:(NSString *)title {
    %orig(translate(title));
}
%end