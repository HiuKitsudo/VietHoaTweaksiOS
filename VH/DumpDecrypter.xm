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
        @"AppsList" : @"Danh sách Ứng dụng",
        @"Developer" : @"Nhà phát triển",
        @"Cancel" : @"Hủy",
        @"Continue" : @"Tiếp tục",
        @"FILE" : @"TỆP",
        @"Files" : @"Các Tệp",
        @"INFO" : @"THÔNG TIN",
        @"Version" : @"Phiên bản",
        @"BuildTime" : @"Thời gian Xây dựng",
        @"Donate" : @"Ủng hộ",
        @"Decryption Completed" :
        @"Giải mã Hoàn tất",        
        @"Decrypt Images" : @"Giải mã Hình ảnh",
        @"Show in Filza" : @"Hiển thị trong Filza",
        @"Share to Other" : @"Chia sẻ đến Ứng dụng khác",
        @"Okey" : @"OK",
        @"Decrypting" : @"Đang giải mã",
        @"Please wait, this will take a few seconds or minutes..." : @"Vui lòng đợi, việc này sẽ mất vài giây hoặc vài phút...",

    };

    regexPatterns = @[
@{
            @"pattern": @"Decrypt([^’']+)?",
            @"replacement": @"Giải mã $1?",
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