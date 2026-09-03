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
@"清理": @"Dọn dẹp",
@"应用列表": @"Danh savh ứng dụng",
@"关于": @"Giới thiệu",
@"系统清理工具": @"Công cụ dọn dẹp hệ thống",
@"点击扫描按钮开始检测": @"Quét để bắt đầu kiểm tra",
@"扫描缓存": @"Quét bộ nhớ đệm",
@"清理系统缓存": @"Dọn dẹp bộ nhớ đệm hệ thống",
@"清理应用缓存": @"Dọn dẹp bộ nhớ đệm ứng dụng",
@"清理临时文件": @"Dọn dẹp tệp tạm thời",
@"清理照片缓存": @"Dọn dẹp bộ nhớ đệm ảnh",
@"一键清理全部": @"Dọn dẹp tất cả",
@"确定": @"Xác nhận",
    };

    regexPatterns = @[
@{
            @"pattern": @"([^’']+) 已保存到“管理文件”页面。",
            @"replacement": @"Đã lưu $1 vào Quản lý tệp",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"确定要删除选中的 ([^’']+) 个文件吗？此操作不可撤销。",
            @"replacement": @"Bạn có chắc chắn muốn xóa $1 tập tin đã chọn không? Hành động này không thể thay đổi được",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"您确定要删除项目 “([^’']+)” 吗？此操作不可撤销。",
            @"replacement": @"Bạn có chắc chắn muốn xóa $1 không? Không thể hoàn tác hành động này.",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"您确定要删除选中的 ([^’']+) 个越狱源吗？此操作不可撤销。",
            @"replacement": @"Bạn có chắc chắn muốn xóa $1 nguồn jailbreak đã chọn không? Hành động này không thể thay đổi được",
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