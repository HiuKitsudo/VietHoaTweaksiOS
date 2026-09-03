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

    // Dịch bằng NSDictionary trước
    NSString *translated = translationDict[originalText];
    if (translated) return translated;

    // Dịch bằng Regex cho các chuỗi động
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
        @"MANAGE" : @"QUẢN LÝ",
        @"Search Installed Apps" : @"Tìm kiếm ứng dụng đã cài đặt",
        @"OPEN" : @"MỞ",
        @"Upgrade/Downgrade" : @"Nâng cấp / Hạ cấp",
        @"Back Up App Data" : @"Sao lưu dữ liệu ứng dụng",
        @"Manage App Data Backups" : @"Quản lý bản sao lưu dữ liệu",
        @"Clear All App Data" : @"Xóa toàn bộ dữ liệu ứng dụng",
        @"Delete Cached Versions" : @"Xóa phiên bản trong bộ nhớ đệm",
        @"Delete App" : @"Xóa ứng dụng",
        @"AppStore++ is free. Donations are optional and help support continued development." : @"AppStore++ hoàn toàn miễn phí. Đóng góp là tùy tâm nhằm hỗ trợ quá trình phát triển liên tục.",
        @"LOGGING" : @"NHẬT KÝ HỆ THỐNG",
        @"AppStore++ Logging" : @"Nhật ký AppStore++",
        @"Advanced iOS Logging" : @"Nhật ký iOS nâng cao",
        @"Contact Support" : @"Liên hệ hỗ trợ",
        @"All Backup Apps" : @"Tất cả ứng dụng đã sao lưu",
        @"AppStore++ logging records only AppStore++ diagnostic messages. Advanced logging attempts to record the entire iOS unified log and may create a large file. Logs are deleted whenever AppStore++ restarts." : @"Nhật ký AppStore++ chỉ ghi lại các thông báo chẩn đoán của AppStore++. Nhật ký nâng cao sẽ ghi lại toàn bộ hệ thống log hợp nhất của iOS nên có thể tạo tệp dung lượng lớn. Tệp nhật ký sẽ bị xóa mỗi khi khởi động lại AppStore++.",
        @"IPA Library" : @"Thư viện IPA",
        @"Search IPA Library" : @"Tìm kiếm thư viện IPA",
        @"No saved IPAs yet." : @"Chưa có tệp IPA nào được lưu.",
        @"Export a selected version to add it to your library." : @"Xuất một phiên bản đã chọn để thêm vào thư viện của bạn.",
        @"Settings" : @"Cài đặt",
        @"Manual" : @"Thủ công",
        @"APPLE ACCOUNT" : @"TÀI KHOẢN APPLE",
        @"Restore App Data" : @"Khôi phục dữ liệu ứng dụng",
        @"Restore App Data + Keychain" : @"Khôi phục dữ liệu ứng dụng + Chuỗi khóa (Keychain)",
        @"Delete Backup" : @"Xóa bản sao lưu",
        @"Legacy AppStore++ Login" : @"Đăng nhập AppStore++ kiểu cũ",
        @"Use Saved Login" : @"Sử dụng thông tin đã lưu",
        @"Legacy Login Deprecated" : @"Đăng nhập cũ không còn được hỗ trợ",
        @"Logging in separately inside AppStore++ is deprecated. AppStore++ now uses the Apple Account already signed in on this device for version lookup, purchased apps, and downloads. Continue only if you specifically need the legacy saved-login session." : @"Tính năng đăng nhập riêng biệt trong AppStore++ đã ngừng hỗ trợ. AppStore++ hiện sử dụng Tài khoản Apple đã đăng nhập trên thiết bị này để tra cứu phiên bản, ứng dụng đã mua và tải xuống. Chỉ tiếp tục nếu bạn thực sự cần phiên đăng nhập cũ đã lưu.",
        @"The on-device account is managed by iOS and cannot be changed here. Separate AppStore++ login is deprecated. Turn off Use Saved Login to keep the Apple-issued session in the device-only Keychain without allowing AppStore++ features to use it. On-device App Store account features continue to work independently." : @"Tài khoản trên thiết bị do iOS quản lý và không thể thay đổi tại đây. Tính năng đăng nhập riêng qua AppStore++ đã ngừng hỗ trợ. Tắt \"Sử dụng thông tin đã lưu\" để giữ phiên đăng nhập do Apple cấp trong Keychain độc lập mà không cho phép các tính năng của AppStore++ sử dụng. Tài khoản App Store gốc vẫn tiếp tục hoạt động bình thường.",
        @"DOWNLOADS" : @"TẢI XUỐNG",
        @"Round Robin" : @"Xử lý luân phiên (Round Robin)",
        @"Round Robin alternates version lookups between queued apps. Turn it off to finish one app's version list before starting the next." : @"Round Robin sẽ luân phiên tìm nạp danh sách phiên bản cho các ứng dụng trong hàng đợi. Tắt tùy chọn này để hoàn tất danh sách của một ứng dụng trước khi bắt đầu ứng dụng tiếp theo.",
        @"INSTALLATION" : @"CÀI ĐẶT",
        @"IPA Installation Method" : @"Phương thức cài đặt IPA",
        @"Choose whether saved IPAs install directly through iOS MobileInstallation or are handed to TrollStore." : @"Chọn cài đặt tệp IPA trực tiếp qua hệ thống MobileInstallation của iOS hoặc chuyển tiếp sang TrollStore.",
        @"SUPPORT" : @"HỖ TRỢ",
        @"Made by @CokePokes" : @"Phát triển bởi @CokePokes",
        @"Donate with Cash App" : @"Ủng hộ qua Cash App",
        @"Fetching Versions" : @"Đang tải phiên bản",
        @"Preparing version list..." : @"Đang chuẩn bị danh sách phiên bản...",
        @"Manual Install" : @"Cài đặt thủ công",
        @"Please enter the BUNDLE ID of the app you're trying to downgrade." : @"Vui lòng nhập BUNDLE ID của ứng dụng bạn muốn hạ cấp.",
        @"Downloads" : @"Tải xuống",
        @"Done" : @"Xong",
        @"com.yourcompany.app" : @"com.yourcompany.app",
        @"Proceed" : @"Tiếp tục",
        @"Search the App Store" : @"Tìm kiếm trên App Store",
        @"No backups yet." : @"Chưa có bản sao lưu nào.",
        @"Use Back Up App Data from the installed app's menu." : @"Sử dụng tùy chọn Sao lưu dữ liệu ứng dụng từ menu của ứng dụng đã cài đặt.",
        @"App Data Backup Complete" : @"Sao lưu dữ liệu ứng dụng hoàn tất",
        @"Describe the Problem" : @"Mô tả sự cố",
        @"Describe what happened and the steps needed to reproduce it." : @"Mô tả những gì đã xảy ra và các bước để tái hiện lại lỗi.",
        @"Apps, games, and more" : @"Ứng dụng, trò chơi và hơn thế nữa",
        @"Cancel" : @"Hủy",
        @"Continue" : @"Tiếp tục",
        @"App Store++ could not retrieve downloadable versions for this app." : @"App Store++ không thể tải danh sách phiên bản cho ứng dụng này.",
        @"Versions Unavailable" : @"Không có phiên bản khả dụng",
        @"All Versions" : @"Tất cả phiên bản",
        @"Search versions or builds" : @"Tìm kiếm phiên bản hoặc số bản dựng",
        @"Available Versions" : @"Các phiên bản khả dụng",
        @"Choose how saved IPAs are installed." : @"Chọn cách cài đặt các tệp IPA đã lưu."
    };

    regexPatterns = @[
        // Bắt chuỗi động "Installed: x.y.z"
        @{
            @"pattern": @"^Installed:\\s*(.*)$",
            @"replacement": @"Đã cài đặt: $1",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
        @{
            @"pattern": @"Download Photo([^’']+)",
            @"replacement": @"Tải xuống ảnh $1",
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
        }
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

- (void)setAttributedText:(NSAttributedString *)attributedText {
    if (attributedText && attributedText.length > 0) {
        NSMutableAttributedString *newAttributedString = [[NSMutableAttributedString alloc] init];
        
        [attributedText enumerateAttributesInRange:NSMakeRange(0, attributedText.length)
                                           options:0
                                        usingBlock:^(NSDictionary<NSAttributedStringKey, id> *attrs, NSRange range, BOOL *stop) {
            NSString *substring = [attributedText.string substringWithRange:range];
            NSString *translatedSubstring = translateText(substring);
            
            NSAttributedString *newSubAttributedString = [[NSAttributedString alloc] initWithString:translatedSubstring attributes:attrs];
            [newAttributedString appendAttributedString:newSubAttributedString];
        }];
        
        %orig(newAttributedString);
    } else {
        %orig(attributedText);
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

// Constructor
%ctor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            loadTranslations();
            %init;
        }
    });
}
