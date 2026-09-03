// Tweak.xm
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

// Định nghĩa NSDictionary cho các bản dịch
static NSDictionary *translationDict = nil;

// Cache các NSRegularExpression
static NSDictionary<NSString *, NSRegularExpression *> *regexCache = nil;

// Danh sách các mẫu regex và bản dịch
static NSArray<NSDictionary *> *regexPatterns = nil;

// Hàm kiểm tra chuỗi hợp lệ
static BOOL isValidString(NSString *string) {
    return string != nil && [string isKindOfClass:[NSString class]] && string.length > 0;
}

// Hàm dịch văn bản
static NSString *translateText(NSString *originalText) {
    if (!isValidString(originalText)) return originalText;

    // Dịch bằng NSDictionary
    NSString *translated = translationDict[originalText];
    if (translated) return translated;

    // Dịch bằng regex
    NSString *result = originalText;
    for (NSDictionary *patternInfo in regexPatterns) {
        NSString *pattern = patternInfo[@"pattern"];
        NSString *replacement = patternInfo[@"replacement"];
        NSRegularExpression *regex = regexCache[pattern];
        if (regex) {
            result = [regex stringByReplacingMatchesInString:result
                                                    options:0
                                                      range:NSMakeRange(0, result.length)
                                               withTemplate:replacement];
        }
    }
    return result;
}

// Hàm khởi tạo dữ liệu dịch và regex
static void loadTranslations() {
    translationDict = @{
@"正在加载进程...": @"Đang tải tiến trình...",
@"终止": @"Dừng",
@"搜索进程...": @"Tìm kiếm tiến trình",
@"所有进程": @"tất cả",
@"应用进程": @"Tiến trình ứng dụng",
@"应用列表": @"Ứng dụng",
@"进程列表": @"Danh sách",
@"取消": @"Huỷ",
@"搜索应用...": @"Tìm kiém ứng dụng",
@"批量打开": @"Mở theo đợt",
@"批量终止": @"Dừng hàng loạt",
@"已选择 1 个应用": @"Đã chọn 1 ứng dụng",
@"设置": @"Cài đặt",
@"应用设置": @"Cài đặt chung",
@"自动刷新间隔": @"Thời gian tự động làm mới",
@"设置进程列表自动刷新时间 (默认: 5秒)": @"Đặt thời gian tự động làm mới danh sách quy trình (Mặc định: 5 giây)",
@"1秒": @"1 giây",
@"2秒": @"2 giây",
@"5秒": @"5 giây",
@"10秒": @"10 giây",
@"30秒": @"30 giây",
@"关闭自动刷新": @"Tắt tính năng tự động làm mới",
@"选择进程列表的自动刷新时间间隔": @"Chọn hời gian tự động làm mới",
@"按进程名称": @"Theo tên tiến trình",
@"按内存使用率": @"Theo dung lượng bộ nhớ",
@"按CPU使用率": @"Theo tiến trình CPU",
@"已设置为按CPU使用率":  @"Đang đặt sắp xếp theo mức sử dụng CPU",
@"当前: 按CPU使用率排序": @"Hiện tại: Sắp xếp theo mức sử dụng CPU",
@"已设置为按内存使用率": @"Đang đặt sắp xếp theo mức sử dụng bộ nhớ",
@"当前: 按内存使用率排序": @"Hiện tại: Sắp xếp theo mức sử dụng bộ nhớ",
@"已设置为按进程名称": @"Đang đặt sắp xếp theo tên tiến trình",
@"当前: 按进程名称排序": @"Hiện tại: Sắp xếp theo tên tiến trình",
@"进程排序方式": @"Sắp xêp tiến trình",
@"按CPU使用率或内存使用率排序 (默认: CPU)": @"Sắp xếp theo mức sử dụng CPU hoặc mức sử dụng bộ nhớ (Mặc định: CPU)",
@"选择进程列表的排序方式": @"Chọn cách sắp xếp danh sách tiến trình",
@"界面设置": @"Cài đặt giao điện",
@"已关闭深色模式": @"Đang tắt chế độ tối",
@"已开启深色模式": @"Đang bật chế độ tối",
@"深色模式": @"Chế độ tối",
@"手动切换深浅模式主题": @"Chuyển đổi thủ công chủ đề Sáng/Tối",
@"悬浮 Tabbar 透明度": @"Trong suốt thanh tab nổi",
@"调整悬浮 Tabbar 的透明度 (默认: 0.8)" : @"Tuỳ chỉnh độ trong suốt tab nổi (Mặc định: 0.8)",
@"确定": @"Xác nhận",
@"调整悬浮 Tabbar 的透明度": @"Điều chỉnh độ trong suốt của thanh tab nổi",
@"动画效果": @"Hiệu ứng hoạt ảnh",
@"开启或关闭界面动画": @"Bật hoặc Tắt giao điện hoạt ảnh",
@"已开启动画效果": @"Đang bật hiệu ứng hoạt ảnh",
@"已关闭动画效果": @"Đang tắt hiệu ứng hoạt ảnh",
@"功能设置": @"Cài đặt tính năng",
@"已开启进程终止确认": @"Đang bật xác nhận kết thúc tiến trình",
@"已关闭进程终止确认": @"Đang tắt xác nhận kết thúc tiến trình",
@"进程终止确认": @"Kết thúc tiến trình.",
@"终止进程前是否显示确认对话框": @"Hiển thị hộp thoại xác nhận trước khi kết thúc tiến trình",
@"数据清理": @"Dọn dẹp dữ liệu",
@"清理日志": @"Xoá nhật ký",
@"清理缓存": @"Xoá bộ nhớ đệm",
@"清理所有数据": @"Xoá tất cả dữ liệu",
@"清理应用缓存和临时数据": @"Dọn dẹp bộ nhớ đệm và dữ liệu tạm thời của ứng dụng",
@"导出日志" : @"Xuất nhật ký",
@"没有找到日志文件": @"Không tìm thấy tệp nhật ký",
@"缓存已清理 0 项，释放 0B": @"Đã dọn dẹp 0 mục bộ nhớ đệm, giải phóng 0B",
@"导出应用运行日志": @"Xuất nhật ký chạy ứng dụng",
@"关于": @"Giới thiệu",
@"版本信息": @"Phiên bản",
@"ProcFlowGG v1.1.0": @"ProcFlowGG v1.1.0",
@"开发者": @"Nhà phát triển",
@"木木" : @"Mumu",
@"官网" : @"Trang web chính thức",
@"访问 JoiHouse 官网" : @"Truy cập trang web chính thức của JoiHouse",
@"Telegram 频道" : @"Kênh Telegram",
@"关注我们的 Telegram 频道" : @"Theo dõi kênh Telegram của chúng tôi",
@"GitHub 项目" : @"Dự án GiHub",
@"查看源代码和贡献" : @"Xem mã nguồn và đóng góp",
@"反馈建议": @"Phản hồi và góp ý",
@"如有问题或建议，欢迎通过邮件联系我们": @"Nếu bạn có bất ký câu hỏi  hoặc góp ý nào, vui lòng liên hệ với chúng tôi qua email",
@"如有问题请及时反馈": @"Nếu có vấn đề, vui lòng phản hồi ngay cho chúng tôi",
@"发送邮件": @"Gửi Email",
    };

    regexPatterns = @[
@{
            @"pattern": @"缓存: ([^’']+)B\n日志: ([^’']+)B\n\n选择要清理的数据类型",
            @"replacement": @"Bộ nhớ đệm: $1B\nNhật kí: $2B\n\nChọn dữ liệu cần xoá",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"一个强大的进程管理工具，帮助您监控和管理系统进程。",
            @"replacement": @"Một công cụ quản lý tiến trình mạnh mẽ giúp bạn giám sát và quản lý các tiến trình hệ thống",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"感谢您的使用！如有问题或建议，欢迎反馈。",
            @"replacement": @"Cảm ơn bạn đã sử dụng! Nếu bạn có bất ký câu hỏi hoặc góp ý nào, vui lòng phản  hồi cho chúng tôi.",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"开发者：木木",
            @"replacement": @"Nhà phát triển: Mumu_VH bởi @Kitsudo",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"您确定要删除选中的 ([^’']+) 个项目吗？此操作不可撤销。",
            @"replacement": @"Bạn có chắc chắn muốn xóa $1 mục đã chọn? Không thể hoàn tác hành động này.",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"您确定要删除选中的 ([^’']+) 个项目吗？此操作不可撤销。",
            @"replacement": @"Bạn có chắc chắn muốn xóa $1 mục đã chọn không? Không thể hoàn tác hành động này.",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"您确定要删除越狱源 “([^’']+)” 吗？此操作不可撤销。",
            @"replacement": @"Bạn có chắc chắn muốn xóa nguồn jailbreak $1 không? Không thể hoàn tác hành động này.",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
    ];

    // Cache NSRegularExpression
    NSMutableDictionary *tempRegexCache = [NSMutableDictionary dictionary];
    NSError *error = nil;

    for (NSDictionary *patternInfo in regexPatterns) {
        NSString *pattern = patternInfo[@"pattern"];
        NSRegularExpressionOptions options = [patternInfo[@"options"] unsignedIntegerValue];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                              options:options
                                                                                error:&error];
        if (!error && regex) {
            tempRegexCache[pattern] = regex;
        } else if (error) {
            NSLog(@"[TranslationTweak] Regex error for pattern %@: %@", pattern, error.localizedDescription);
        }
    }

    regexCache = [tempRegexCache copy];
}

// Hook UILabel
%hook UILabel
- (void)setText:(NSString *)text {
    if (isValidString(text)) {
        %orig(translateText(text));
    } else {
        %orig(text);
    }
}
%end

// Hook UITextView
%hook UITextView
- (void)setText:(NSString *)text {
    if (isValidString(text)) {
        %orig(translateText(text));
    } else {
        %orig(text);
    }
}
%end

// Hook UIButton
%hook UIButton
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    if (isValidString(title)) {
        %orig(translateText(title), state);
    } else {
        %orig(title, state);
    }
}
%end

// Hook UIAlertController
%hook UIAlertController
- (void)setTitle:(NSString *)title {
    if (isValidString(title)) {
        %orig(translateText(title));
    } else {
        %orig(title);
    }
}
- (void)setMessage:(NSString *)message {
    if (isValidString(message)) {
        %orig(translateText(message));
    } else {
        %orig(message);
    }
}
%end

// Hook UINavigationItem
%hook UINavigationItem
- (void)setTitle:(NSString *)title {
    if (isValidString(title)) {
        %orig(translateText(title));
    } else {
        %orig(title);
    }
}
%end

// Hook UITextField
%hook UITextField
- (void)setPlaceholder:(NSString *)placeholder {
    if (isValidString(placeholder)) {
        %orig(translateText(placeholder));
    } else {
        %orig(placeholder);
    }
}
%end

// Hook NSAttributedString trong UILabel - ĐÃ SỬA LỖI
%hook UILabel
- (void)setAttributedText:(NSAttributedString *)attributedText {
    if (attributedText && attributedText.length > 0) {
        NSMutableAttributedString *newAttributedString = [[NSMutableAttributedString alloc] init];
        
        // Vòng lặp duyệt qua từng đoạn có attributes khác nhau
        [attributedText enumerateAttributesInRange:NSMakeRange(0, attributedText.length)
                                           options:0
                                        usingBlock:^(NSDictionary<NSAttributedStringKey, id> *attrs, NSRange range, BOOL *stop) {
            // Lấy chuỗi con và dịch nó
            NSString *substring = [attributedText.string substringWithRange:range];
            NSString *translatedSubstring = translateText(substring);
            
            // Tạo attributed string mới với chuỗi đã dịch và attributes cũ
            NSAttributedString *newSubAttributedString = [[NSAttributedString alloc] initWithString:translatedSubstring attributes:attrs];
            
            // Nối vào kết quả cuối cùng
            [newAttributedString appendAttributedString:newSubAttributedString];
        }];
        
        %orig(newAttributedString);
    } else {
        %orig(attributedText);
    }
}
%end


// Hook UIApplication
%hook UIApplication
- (NSString *)displayName {
    NSString *originalName = %orig;
    return isValidString(originalName) ? translateText(originalName) : originalName;
}
%end

// Constructor
%ctor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            loadTranslations();
            if (@available(iOS 15.0, *)) {
                %init;
            } else {
                NSLog(@"[TranslationTweak] This tweak requires iOS 14 or later.");
            }
        }
    });
}