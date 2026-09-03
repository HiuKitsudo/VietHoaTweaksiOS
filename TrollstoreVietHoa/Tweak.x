#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static NSDictionary *translationDict = nil;
static NSDictionary<NSString *, NSRegularExpression *> *regexCache = nil;
static NSArray<NSDictionary *> *regexPatterns = nil;

static BOOL isValidString(NSString *string) {
    return string != nil && [string isKindOfClass:[NSString class]] && string.length > 0;
}

static NSString *translateText(NSString *originalText) {
    if (!isValidString(originalText)) return originalText;

    NSString *cleanText = [originalText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *translated = translationDict[cleanText];
    if (translated) return translated;

    NSString *result = [originalText mutableCopy];
    BOOL matched = NO;
    
    for (NSDictionary *patternInfo in regexPatterns) {
        NSString *pattern = patternInfo[@"pattern"];
        NSString *replacement = patternInfo[@"replacement"];
        
        NSRegularExpression *regex = regexCache[pattern];
        if (regex) {
            NSTextCheckingResult *match = [regex firstMatchInString:result options:0 range:NSMakeRange(0, result.length)];
            if (match) {
                result = [regex stringByReplacingMatchesInString:result
                                                        options:0
                                                          range:NSMakeRange(0, result.length)
                                                   withTemplate:replacement];
                matched = YES;
            }
        }
    }
    
    return matched ? result : originalText;
}

static void loadTranslations() {
    translationDict = @{
        @"Settings": @"Cài đặt",
        @"Apps": @"Ứng dụng",
        @"UTILITIES": @"TIỆN ÍCH",
        @"SIGNING": @"KÝ ỨNG DỤNG",
        @"PERSISTENCE": @"DUY TRÌ",
        @"SECURITY": @"BẢO MẬT",
        @"Respring": @"Respring (Khởi động lại giao diện)",
        @"Refresh App Registrations": @"Làm mới danh sách ứng dụng",
        @"Rebuild Icon Cache": @"Xây dựng lại bộ đệm ứng dụng",
        @"Downloading": @"Đang tải xuống",
        @"Installing": @"Đang cài đặt",
        @"Install": @"Cài đặt",
        @"Uninstall": @"Gỡ cài đặt",
        @"Open": @"Mở",
        @"Open with JIT": @"Mở cùng với JIT",
        @"Show Details": @"Xem chi tiết",
        @"Switch to \"User\" Registration": @"Chuyển sang đăng ký \"Người dùng\"",
        @"Switch to \"System\" Registration": @"Chuyển sang đăng ký \"Hệ thống\"",
        @"The app has been switched to the \"System\" registration state and will become launchable again after a respring.": @"Ứng dụng đã được chuyển sang trạng thái đăng ký 'Hệ thống' và sẽ hoạt động trở lại sau khi Respring.",
        @"Uninstall App": @"Gỡ ứng dụng",
        @"Install IPA File": @"Cài đặt tệp IPA",
        @"Install from URL": @"Cài đặt từ URL",
        @"Install Persistence Helper": @"Cài đặt chọn ứng dụng để duy trì",
        @"Uninstall Persistence Helper": @"Gỡ bỏ ứng dụng duy trì",
        @"Select App": @"Chọn Ứng dụng Hệ thống",
        @"Helper Installed into Tips": @"Đã cài vào ứng dụng Mẹo (Tips)",
        @"Helper Installed into Home": @"Đã cài vào ứng dụng Nhà (Home)",
        @"URL Scheme Enabled": @"Bật URL Scheme",
        @"Show Install Confirmation Alert": @"Hiện thị xác nhận khi cài đặt",
        @"Advanced": @"Nâng cao",
        @"Donate": @"Ủng hộ",
        @"Donate to alfiecg_dev": @"Ủng hộ alfiecg_dev",
        @"Donate to opa334": @"Ủng hộ opa334 (Tác giả)",
        @"Uninstall TrollStore": @"Gỡ cài đặt TrollStore",
        @"TrollStore is NOT for piracy!": @"TrollStore KHÔNG dành cho vi phạm bản quyền!",
        @"Metadata": @"Thông tin ứng dụng",
        @"Bundle Identifier": @"Mã Bundle",
        @"Version": @"Phiên bản",
        @"Size": @"Dung lượng",
        @"Installation Method": @"Phương thức Cài đặt",
        @"Uninstallation Method": @"Phương thức Gỡ cài đặt",
        @"Custom (Recommended)": @"Custom (Khuyên dùng)",
        @"installd (Recommended)": @"installd (Khuyên dùng)",
        @"installd": @"installd",
        @"Custom": @"Custom",
        @"Cancel": @"Hủy",
        @"Close": @"Đóng",
        @"Always (Recommended)": @"Luôn hỏi (Khuyên dùng)",
        @"Only on Remote URL Installs": @"Chỉ khi cài từ URL",
        @"Never (Not Recommended)": @"Không bao giờ (Không khuyên dùng)",
        @"Never (Not Recommeded)": @"Không bao giờ (Không khuyên dùng)", 

        @"Tips": @"Mẹo", @"Home": @"Nhà", @"Stocks": @"Chứng khoán", @"Mail": @"Mail", @"Contacts": @"Danh bạ",
        @"Reminders": @"Lời nhắc", @"Clock": @"Đồng hồ", @"FindMy": @"Tìm", @"Notes": @"Ghi chú",
        @"Shortcuts": @"Phím tắt", @"VoiceMemos": @"Ghi âm", @"Books": @"Sách", @"Calendar": @"Lịch",
        @"Music": @"Nhạc", @"Podcasts": @"Podcasts", @"Compass": @"La bàn", @"Translate": @"Dịch thuật",
        @"Watch": @"Watch", @"Magnifier": @"Kính lúp", @"Freeform": @"Freeform", @"Weather": @"Thời tiết",
        @"FaceTime": @"FaceTime", @"Wallet": @"Ví", @"Calculator": @"Máy tính", @"AppleTV": @"Apple TV",
        @"iTunes Store": @"iTunes Store", @"Files": @"Tệp", @"Fitness": @"Thể dục", @"Measure": @"Đo đạc",
        @"Health": @"Sức khỏe", @"Maps": @"Bản đồ"
    };

    regexPatterns = @[
        @{ 
            @"pattern": @"(?s)TrollStore\\s+([0-9.]+)\\s+©\\s+([0-9-]+)\\s+Lars Fröder\\s+\\(opa334\\)\\s+TrollStore is NOT for piracy!\\s+Credits:", 
            @"replacement": @"TrollStore $1\n© $2 Lars Fröder (opa334)\n\nTrollStore KHÔNG dành cho vi phạm bản quyền!\n\nTranslated by @Kitsudo🇻🇳(JTISVN)\n\nĐóng góp:"  
        },
        @{ @"pattern": @"Troarious contributions", @"replacement": @"Sự đóng góp của Troarious" },

        @{ @"pattern": @"(I|l)did: Installed.*", @"replacement": @"ldid: Đã cài đặt (Hỗ trợ ký IPA)" },
        @{ @"pattern": @"(I|l)did is installed and allows.*", @"replacement": @"ldid cho phép TrollStore cài đặt các tệp IPA chưa ký." },

        @{ @"pattern": @"(?s)If an app does not immediately appear.*", @"replacement": @"Nếu ứng dụng không hiện ngay sau khi cài đặt, hãy Respring tại đây." },
        @{ @"pattern": @"(?s)When iOS rebuilds the icon cache.*", @"replacement": @"Khuyên dùng ứng dụng Mẹo. Khi iOS làm mới bộ đệm biểu tượng, TrollStore và các app liên quan sẽ bị lỗi. Hãy chọn một ứng dụng hệ thống để cài Trợ lý duy trì, giúp khôi phục khi không mở được các ứng dụng này." },
        @{ @"pattern": @"(?s)Select a system app to install.*", @"replacement": @"Chọn một ứng dụng hệ thống để thay thế bằng Trình hỗ trợ. App này sẽ mất chức năng gốc." },
        @{ @"pattern": @"(?s)The URL Scheme, when enabled.*", @"replacement": @"URL Scheme cho phép các trang web/ứng dung khác kích hoạt cài đặt qua TrollStore bằng liên kết apple-magnifier://install?url=<IPA_URL> và bật JIT qua apple-magnifier://enable-jit?bundle-id=<BUNDLE_ID>." },
        @{ @"pattern": @"(?s)Installs applications by doing a placeholder.*", @"replacement": @"Cài đặt thông qua installd hệ thống, sửa quyền và làm mới cache icon." },
        @{ @"pattern": @"(?s)Installs applications by manually creating.*", @"replacement": @"Cài đặt thủ công bằng MobileContainerManager (An toàn hơn)." },
        @{ @"pattern": @"(?s)Uninstalls applications using the same API.*", @"replacement": @"Gỡ cài đặt bằng API chuẩn của iOS (Giống xóa ngoài màn hình chính)." },
        @{ @"pattern": @"(?s)Uninstalls applications by removing them.*", @"replacement": @"Gỡ cài đặt bằng cách xóa trực tiếp dữ liệu và bộ đệm biểu tượng." },
        @{ @"pattern": @"(?s)NOTE: In cases where installd is selected.*", @"replacement": @"LƯU Ý: Nếu installd thất bại, TrollStore sẽ tự động chuyển sang phương thức Custom." },
        @{ @"pattern": @"(?s)Advantage:.*", @"replacement": @"Ưu điểm: Ổn định hơn hoặc không lỗi vặt." },
        @{ @"pattern": @"(?s)Disadvantage:.*", @"replacement": @"Nhược điểm: Có thể gây lỗi nhỏ hoặc kém bền vững hơn." },
        @{ @"pattern": @"(?s)Alfie found the new CoreTrust bug.*", @"replacement": @"Alfie đã tìm ra lỗi CoreTrust mới (CVE-2023-41991), tạo ra bản POC và công cụ tự động khai thác..." },
        @{ @"pattern": @"(?s)Opa developed the ChOma library.*", @"replacement": @"Opa đã phát triển thư viện ChOma, giúp tự động hóa việc khai thác lỗi và tích hợp nó vào TrollStore." }
    ];

    NSMutableDictionary *tempRegexCache = [NSMutableDictionary dictionary];
    for (NSDictionary *dict in regexPatterns) {
        NSString *pattern = dict[@"pattern"];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators error:nil];
        if (regex) tempRegexCache[pattern] = regex;
    }
    regexCache = [tempRegexCache copy];
}

// --- HOOKS ---

%hook UILabel
- (void)setText:(NSString *)text {
    if (isValidString(text)) {
        %orig(translateText(text));
    } else {
        %orig(text);
    }
}

- (void)setAttributedStringText:(NSAttributedString *)attributedText {
    if (attributedText && attributedText.length > 0) {
        NSMutableAttributedString *newAttr = [[NSMutableAttributedString alloc] init];
        [attributedText enumerateAttributesInRange:NSMakeRange(0, attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
            NSString *substring = [attributedText.string substringWithRange:range];
            NSString *translated = translateText(substring);
            NSAttributedString *newSub = [[NSAttributedString alloc] initWithString:translated attributes:attrs];
            [newAttr appendAttributedString:newSub];
        }];
        %orig(newAttr);
    } else {
        %orig(attributedText);
    }
}
%end

%hook UITextView
- (void)setText:(NSString *)text {
    if (isValidString(text)) {
        %orig(translateText(text));
    } else {
        %orig(text);
    }
}

- (void)setAttributedStringText:(NSAttributedString *)attributedText {
    if (attributedText && attributedText.length > 0) {
        NSMutableAttributedString *newAttr = [[NSMutableAttributedString alloc] init];
        [attributedText enumerateAttributesInRange:NSMakeRange(0, attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
            NSString *substring = [attributedText.string substringWithRange:range];
            NSString *translated = translateText(substring);
            NSAttributedString *newSub = [[NSAttributedString alloc] initWithString:translated attributes:attrs];
            [newAttr appendAttributedString:newSub];
        }];
        %orig(newAttr);
    } else {
        %orig(attributedText);
    }
}
%end

%hook UIButton
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    if (isValidString(title)) {
        %orig(translateText(title), state);
    } else {
        %orig(title, state);
    }
}
%end

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

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style {
    NSString *transTitle = isValidString(title) ? translateText(title) : title;
    NSString *transMsg = isValidString(message) ? translateText(message) : message;
    return %orig(transTitle, transMsg, style);
}
%end

%hook UIAlertAction
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *action))handler {
    NSString *transTitle = isValidString(title) ? translateText(title) : title;
    return %orig(transTitle, style, handler);
}
%end

%hook UINavigationItem
- (void)setTitle:(NSString *)title {
    if (isValidString(title)) {
        %orig(translateText(title));
    } else {
        %orig(title);
    }
}
%end

%hook UITableViewCell
- (void)layoutSubviews {
    %orig;
    for (UIView *sub in self.contentView.subviews) {
        if ([sub isKindOfClass:[UILabel class]]) {
            UILabel *lbl = (UILabel *)sub;
            NSString *trans = translateText(lbl.text);
            if (trans && ![lbl.text isEqualToString:trans]) {
                lbl.text = trans;
            }
        }
    }
}
%end

%hook UITableViewHeaderFooterView
- (void)layoutSubviews {
    %orig;
    if (self.textLabel) {
        NSString *trans = translateText(self.textLabel.text);
        if (trans && ![self.textLabel.text isEqualToString:trans]) {
            self.textLabel.text = trans;
        }
    }
}
%end

%ctor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loadTranslations();
        %init;
    });
}