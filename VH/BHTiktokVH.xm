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
        @"Feed" : @"Bảng Tin",
        @"Hide Ads" : @"Ẩn Quảng Cáo",
        @"Hide all ads from the app" : @"Ẩn quảng cáo khỏi ứng dụng",
        @"Download Button" : @"Nút Tải Xuống",
        @"Enable download button for videos" : @"Bật nút tải về cho video",
        @"Share Sheet" : @"Bảng Chia Sẻ",
        @"Enable sharing options in share sheet" : @"Bật các tuỳ chọn chia sẻ trong bàng chia sẻ",
        @"Remove Watermark" : @"Xoá Hình Mờ",
        @"Remove the TikTok watermark from videos" : @"Xoá hình mờ BHTiktok khỏi các video",
        @"Show/Hide UI Button" : @"Nút Ẩn & Hiện",
        @"Show or hide the UI button" : @"Hiển thị hoặc ẩn nút giao điện",
        @"Stop Playback" : @"Dùng Phát",
        @"Stop video playback automatically" : @"Tự động dừng phát lại video",
        @"Auto Play Next Video" : @"Tự Động Phát Video",
        @"Automatically play the next video" : @"Tự động phát video tiếp theo",
        @"Show Progress Bar" : @"Hiển thị Thanh tiến trình",
        @"Display progress bar on video playback" : @"Hiển thị thanh tiến trình khi phát video",
        @"Transparent Comments" : @"Bình Luận Trong Suốt",
        @"Make comments transparent" : @"Làm cho bình luận trong suốt",
        @"Show Usernames" : @"Hiển thị Tên người dùng",
        @"Display usernames on videos" : @"Hiển thị tên người dùng trong video",
        @"Disable Sensitive Content" : @"Tắt Nội dung Nhạy cảm",
        @"Disable sensitive content filter" : @"Tắt bộ lọc nội dung nhạy cảm",
        @"Disable Warnings" : @"Tắt Cảnh báo",
        @"Disable TikTok warnings" : @"Tắt các cảnh báo của TikTok",
        @"Disable Live Streaming" : @"Tắt Phát Trực tiếp",
        @"Disable live video streaming" : @"Tắt tính năng phát trực tiếp",
        @"Skip Recommendations" : @"Bỏ qua Đề xuất",
        @"Skip recommended videos" : @"Bỏ qua các video được đề xuất",
        @"Upload Region" : @"Khu Vực Tải lên",
        @"Show Upload Region Flag Next to Username" : @"Hiển thị quốc gia khu vực tải lên bên cạnh Tên người dùng",
        @"Profile" : @"Hồ Sơ",
        @"Profile Save" : @"Lưu Ảnh Hồ Sơ",
        @"Save profile details to clipboard" : @"Lưu ảnh hồ sơ vào bộ nhớ tạm",
        @"Profile Copy" : @"Sao Chép Hồ Sơ",
        @"Copy profile information" : @"Sao chép thông tin hồ sơ",
        @"Show the number of likes on videos" : @"Hiển thị số lượt thích trên video",
        @"Video Upload Date" : @"Ngày Đăng Video",
        @"Show the date videos were uploaded" : @"Hiển thị ngày video được tải lên",
        @"Follower:" : @"Người theo dõi:",
        @"Enter follower count" : @"Nhập số lượng người theo dõi",
        @"Following:" : @"Đang theo dõi:",
        @"Enter following count" : @"Nhập số lượng đang theo dõi",
        @"Fake Verified" : @"Tích xanh Giả",
        @"Extended Bio" : @"Tiểu Sử Mở Rộng",
        @"Extended Comments" : @"Bình Luận Mở Mộng",
        @"Extend the length of your comments" : @"Mở rộng giới hạn ký tự cho bình luận",
        @"Upload HD" : @"Tải Lên HD",
        @"Upload videos in HD quality" : @"Tải lên video với chất lượng HD",
        @"App Lock" : @"Khoá Ứng Dụng",
        @"Lock the app with a passcode" : @"Khóa ứng dụng bằng mật mã",
        @"Enable Flex" : @"Bật tính năng kích hoạt",
        @"Developers Only, DON'T touch it if you don't know what you are doing." : @"Chỉ dành cho nhà phát triển, KHÔNG chạm vào nó nếu bạn không biết mình đang làm gì.",
        @"Region" : @"Khu vực",
        @"Enable Region Changing" : @"Bật thay đổi khu vực",
        @"Enable region changing functionality" : @"Bật chức năng đổi khu vực",
        @"Regions" : @"Các khu vực",
        @"Change The Default Live Button Action" : @"Thay đổi Hành động Nút Live Mặc định",
        @"Actions" : @"Các hành động",
        @"Playback Speed" : @"Tốc độ phát",
        @"Enable Presistent Playback Speed." : @"Bật Ghi nhớ Tốc độ phát.",
        @"Speeds" : @"Các Tốc độ",
        @"Developer" : @"Nhà Phát Triển - Biển Dịch Bởi @Kitsudo",
        @"Buy Me A Coffe" : @"Mua cho tôi một ly cà phê",
        @"To keep me Motivated and the Tweak Updated." : @"Để tôi có động lực và tinh chỉnh được cập nhật",
        @"Download Photos Menu" : @"Menh Tải Xuống Ảnh",
        @"Downloads Menu" : @"Menu Tải Xuống",
        @"Copy Menu" : @"Menu Sao Chép",
        @"Download Video" : @"Tải xuống Video",
        @"Download HD Video" : @"Tải xuống Video HD",
        @"Download Music" : @"Tải xuống Nhạc",
        @"Copy Music link" : @"Sao chép liên kết Nhạc",
        @"Copy Video link" : @"Sao chép liên kết Video",
        @"Copy Decription" : @"Sao chép Mô tả",
        @"Confirm" : @"Xác nhận",
        @"Like Confirmation" : @"Xác nhận thích",
        @"Like Comment Confirmation" : @"Xác nhận Thích Bình luận",
        @"Dislike Comment Confirmation" : @"Xác nhận Không thích Bình luận",
        @"Follow Confirmation" : @"Xác nhận Theo dõi",
        @"Other" : @"Khác",
        @"Always Open Safari" : @"Luôn mở bằng Safari",
        @"Enable Fake Changes" : @"Bật Thay đổi Ảo",
        @"Live Button Function" : @"Chức năng Nút Live",
        @"Make your account appear verified" : @"Làm cho tài khoản của bạn được xác minh",
        @"Hide Top Feed items" : @"Ẩn Các Mục Bảng Tin Hàng Đầu",
        @"Hide The search and live buttons and the (FYP, Following, Shop, etc...)" : @"Ẩn các nút tìm kiếm, live và (Dành cho bạn, Đang theo dõi, Cửa hàng, v.v...)",
        @"Video Like Count" : @"Số lượt thích video",
        @"Extend bio section of your profile" : @"Mở rộng phần tiểu sử trong hồ sơ của bạn",
        @"Confirm before liking a video" : @"Xác nhận trước khi thích video",
        @"Confirm before liking a comment" : @"Xác nhận trước khi thích một bình luận",
        @"Confirm before following a user" : @"Xác nhận trước khi theo dõi người dùng",
        @"Download All Photos" : @"Tải xuống tất cả ảnh",
    };

    regexPatterns = @[
@{
            @"pattern": @"Download Photo[^’']+)",
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