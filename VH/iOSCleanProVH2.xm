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
        @"English" : @"Tiếng Việt",
        @"清理历史记录" : @"Xóa lịch sử",
        @"清空" : @"Xoá",
        @"确定要清空所有清理历史记录吗？此操作无法撤销。" : @"Bạn có chắc chắn muốn xoá tất cả lịch sử dọn dẹp không? Thao tác này không thể hoàn tác.",
        @"一键清理全部" : @"Dọn dẹp tất cả",
        @"清理白名单" : @"Danh sách trắng",
        @"暂无白名单应用\n\n点击右上角 + 按钮添加应用" : @"Chưa có ứng dụng trong danh sách trắng\n\nNhấn nút + ở góc trên bên phải để thêm ứng dụng",
        @"确认移除" : @"Xác nhận xoá",
        @"取消" : @"Huỷ",
        @"移除" : @"Xoá",
        @"临时文件" : @"Tệp tạm thời",
        @"缓存文件" : @"Tệp bộ nhớ đệm",
        @"系统日志" : @"Nhật ký hệ thống",
        @"清理详情" : @"Chi tiết",
        @"删除" : @"Xoá",
        @"清空历史记录" : @"Xoá lịch sử",
        @"GitHub" : @"GitHub - Dịch bởi @Kitsudo (JTISVN)",
        @"暂无清理历史记录" : @"Chưa có lịch sử xóa",
        @"确定" : @"Xác nhận",
        @"网页数据" : @"Dữ liệu trang web",
    };

    regexPatterns = @[
@{
            @"pattern": @"确定要将([^’']+)从白名单移除吗？\n移除后，该应用的缓存可被一键清理。",
            @"replacement": @"Bạn có chắc chắn muốn xóa$1khỏi danh sách trắng không?\nSau khi xóa, bộ nhớ đệm của ứng dụng này có thể bị dọn dẹp (khi dùng tính năng dọn dẹp tất cả).",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"共([^’']+)条记录，累计清理([^’']+)",
            @"replacement": @"Tổng cộng có$1mục, đã dọn dẹp$2",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"清理类型:([^’']+)\n清理大小:([^’']+)\n清理时间:([^’']+)",
            @"replacement": @"Loại: $1\nKích thước: $2\nThời gian: $3",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"第三方应用:([^’']+)",
            @"replacement": @"Ứng dụng bên thứ ba$1",
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