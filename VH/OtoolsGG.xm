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
        @"分析工具" : @"Công cụ Phân tích",
        @"选择二进制文件" : @"Chọn tệp dylib",
        @"开始分析" : @"Bắt đầu Phân tích",
        @"请选择一个二进制文件进行分析" : @"Vui lòng chọn một tệp dylib để phân tích",
        @"应用列表" : @"Danh sách Ứng dụng",
        @"已安装应用" : @"Ứng dụng đã Cài đặt",
        @"文件浏览器" : @"Trình duyệt Tệp",
        @"设置" : @"Cài đặt",
        @"搜索应用..." : @"Tìm kiếm ứng dụng...",
        @"根目录" : @"Thư mục Gốc",
        @"通用" : @"Chung",
        @"关于" : @"Giới thiệu",
        @"版本信息" : @"Thông tin Phiên bản",
        @"工具配置" : @"Cấu hình Công cụ",
        @"其他" : @"Khác",
        @"清除缓存" : @"Xóa bộ đệm",
        @"相关信息" : @"Thông tin Liên quan",
        @"官网" : @"Trang web Chính thức",
        @"Telegram 频道" : @"Kênh Telegram",
        @"微信公众号" : @"Tài khoản Công khai WeChat",
        @"工具助手" : @"Trợ lý Công cụ",
        @"选择文件" : @"Chọn tệp",
        @"请选择文件来源" : @"Vui lòng chọn nguồn tệp",
        @"从文件选择器" : @"Chọn từ tệp",
        @"切换到文件浏览器标签" : @"Chuyển sang tab Trình duyệt Tệp",
        @"切换到应用列表标签" : @"Chuyển sang tab Danh sách Ứng dụng",
        @"取消" : @"Hủy",
        @"确定" : @"Xác nhận",
        @"复制" : @"Sao chép",
        @"查看 otool 工具路径" : @"Xem đường dẫn công cụ otool",
        @"查看 classdumpios 工具路径" : @"Xem đường dẫn công cụ classdumpios",
        @"确定要清除所有缓存数据吗？此操作不可恢复。" : @"Bạn có chắc muốn xóa tất cả dữ liệu bộ dệm không? Thao tác này không thể hoàn tác.",
        @"清除" : @"Xóa",
        @"分析二进制文件" : @"Phân tích Tệp dylib",
        @"查看应用信息" : @"Xem Thông tin Ứng dụng",
        @"浏览应用文件夹" : @"Duyệt Thư mục Ứng dụng",
        @"📄 预览/查看" : @"📄 Xem trước/Xem",
        @"尝试解析为 IPA" : @"Thử phân tích dưới dạng IPA",
        @"查看文件信息" : @"Xem thông tin tệp",
        @"OtoolsGG - iOS 二进制分析工具\n\n一款强大的 iOS 应用二进制文件分析工具，支持 otool 分析、classdump 导出等功能。" : @"OtoolsGG - Công cụ Phân tích dylib iOS\n\nMột công cụ phân tích tệp dylib ứng dụng iOS mạnh mẽ, hỗ trợ phân tích otool, xuất classdump và các tính năng khác.",
        @"完成" : @"Hoàn thành",
        @"缓存已清除" : @"Bộ đệm đã được xóa",
        @"分析完成" : @"Phân tích thành công",
        @"📁 在 Filza 中查看" : @"📁 Xem trong Filza",
        @"📂 在文件浏览器中浏览" : @"📂 Duyệt trong Trình duyệt Tệp",
        @"应用信息" : @"Thông tin Ứng dụng",
    };

    regexPatterns = @[
@{
            @"pattern": @"找到([^’']+)个应用",
            @"replacement": @"Tìm thấy$1ứng dụng",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"Bundle ID:([^’']+)\n可执行文件:([^’']+)",
            @"replacement": @"Mã định danh:$1\nTệp thực thi:$2",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"路径:([^’']+)\n大小:([^’']+)",
            @"replacement": @"Đường dẫn:$1\nKích thước:$2",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"版本:([^’']+)\n构建:([^’']+)",
            @"replacement": @"Phiên bán:$1\nBản dựng:$2",
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