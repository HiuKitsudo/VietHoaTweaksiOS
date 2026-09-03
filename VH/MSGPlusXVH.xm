#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static NSDictionary *translationDict = nil;

static BOOL isValidString(NSString *string) {
    return string != nil && [string isKindOfClass:[NSString class]] && string.length > 0;
}

static NSString *translateText(NSString *originalText) {
    if (!isValidString(originalText)) return originalText;

    // 1. Dịch các chuỗi cố định trước
    NSString *translated = translationDict[originalText];
    if (translated) {
        return translated;
    }
    
    // 2. Xử lý các chuỗi động (Ví dụ: Popup thông tin ứng dụng)
    // Nếu chuỗi chứa từ khoá nhận diện, tiến hành thay thế từng phần
    if ([originalText containsString:@"iOS Version :"]) {
        NSMutableString *dynamicText = [originalText mutableCopy];
        
        [dynamicText replaceOccurrencesOfString:@"iOS Version :" withString:@"Phiên bản iOS :" options:0 range:NSMakeRange(0, dynamicText.length)];
        [dynamicText replaceOccurrencesOfString:@"Device :" withString:@"Thiết bị :" options:0 range:NSMakeRange(0, dynamicText.length)];
        [dynamicText replaceOccurrencesOfString:@"Messenger Version :" withString:@"Phiên bản Messenger :" options:0 range:NSMakeRange(0, dynamicText.length)];
        [dynamicText replaceOccurrencesOfString:@"MSGPlusX Version :" withString:@"Phiên bản MSGPlusX :" options:0 range:NSMakeRange(0, dynamicText.length)];
        [dynamicText replaceOccurrencesOfString:@"Bundle :" withString:@"Bundle iD :" options:0 range:NSMakeRange(0, dynamicText.length)];
        [dynamicText replaceOccurrencesOfString:@"Status :" withString:@"Trạng thái :" options:0 range:NSMakeRange(0, dynamicText.length)];
        [dynamicText replaceOccurrencesOfString:@"OriginalBundle" withString:@"Bản gốc" options:0 range:NSMakeRange(0, dynamicText.length)];
        
        return [dynamicText copy];
    }
    
    return originalText;
}

static void loadTranslations() {
    translationDict = @{
        @"CHAT" : @"TRÒ CHUYỆN",
        @"View Photos Unlimited" : @"Xem Ảnh Không Giới Hạn",
        @"View 'view once' photos more than once" : @"Xem ảnh 'xem một lần' nhiều lần",
        @"View Videos Unlimited" : @"Xem Video Không Giới Hạn",
        @"View 'view once' videos more than once" : @"Xem video 'xem một lần' nhiều lần",
        @"Read Chats Anonymously" : @"Đọc Tin Nhắn Ẩn Danh",
        @"Read chats without marking them as read" : @"Đọc tin nhắn mà không báo đã đọc",
        @"Download photos [HD]" : @"Tải Xuống Ảnh [HD]",
        @"Long-press to save 'view once' photos" : @"Nhấn giữ để lưu ảnh 'xem một lần'",
        @"Download videos" : @"Tải Xuống Video",
        @"Long-press to save 'view once' videos" : @"Nhấn giữ để lưu video 'xem một lần'",
        @"Loop videos" : @"Lặp Lại Video",
        @"No Screenshot Detection" : @"Chặn Phát Hiện Chụp Màn Hình",
        @"Upload videos as voice messages" : @"Gửi Video Dạng Tin Nhắn Thoại",
        @"Videos will be sent as 'voice messages'" : @"Video sẽ được gửi dưới dạng 'tin nhắn thoại'",
        @"Upload photos in HD" : @"Tải Lên Ảnh HD",
        @"Photos will be uploaded in HD quality" : @"Ảnh sẽ được tải lên với chất lượng HD",
        
        @"STORIES" : @"TIN (STORIES)",
        @"Watch stories anonymously" : @"Xem Tin Ẩn Danh",
        @"Watch without marking them as seen" : @"Xem mà không báo đã xem",
        @"Remove Tray Stories" : @"Xoá Khay Tin",
        @"Hides Stories Tray In Main Feed" : @"Ẩn khay tin trên bảng tin chính",
        @"Hide Reply Bar" : @"Ẩn Thanh Trả Lời",
        @"Hide reply bar in stoires" : @"Ẩn thanh trả lời trong tin",
        
        @"CONFIRMATION" : @"XÁC NHẬN",
        @"Call Confirmation" : @"Xác Nhận Cuộc Gọi",
        @"Show alert before calling someone" : @"Hiện cảnh báo trước khi gọi",
        @"Do you want to call?" : @"Bạn có muốn gọi không?",
        @"Disables the 'You took a screenshot' notification in chats" : @"Tắt thông báo 'Bạn đã chụp ảnh màn hình' trong đoạn chat",
        @"Cancel" : @"Hủy",
        @"Yes" : @"Có",
        @"OK" : @"Ok",
        
        @"TABS" : @"CÁC TAB",
        @"Hide 'Stories' tab" : @"Ẩn tab 'Tin'",
        @"Hide 'Menu' tab" : @"Ẩn tab 'Menu'",
        @"Hide 'Notifications' tab" : @"Ẩn tab 'Thông báo'",
        @"Hide 'Chats' tab" : @"Ẩn tab 'Trò chuyện'",
        
        @"SUPPORT DENSOR" : @"HỖ TRỢ DENSOR (VIỆT HÓA BỞI KITSUDO)",
        @"Paypal" : @"Paypal",
        @"Telegram" : @"Telegram",
        @"Instagram" : @"Instagram",
        @"More by DeNsor" : @"Thêm từ DeNsor",
        @"MSGPlusX is a powerful tweak for messenger and its totally free - and its made by DeNsor" : @"MSGPlusX là một tinh chỉnh mạnh mẽ cho Messenger và hoàn toàn miễn phí - được tạo bởi DeNsor"
    };
}

%hook UILabel
- (void)setText:(NSString *)text {
    if (isValidString(text)) {
        %orig(translateText(text));
    } else {
        %orig(text);
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

%ctor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            loadTranslations();
            %init;
        }
    });
}