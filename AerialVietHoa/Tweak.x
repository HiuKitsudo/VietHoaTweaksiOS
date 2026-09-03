#import <UIKit/UIKit.h>

@interface PSSpecifier : NSObject
- (NSString *)name;
@end

static NSString *DichTiengViet(NSString *text) {
    if (!text || text.length == 0) return nil;

    static NSDictionary *dict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dict = @{
            @"Open App": @"Mở ứng dụng",
            @"Maximize": @"Phóng to",
            @"Minimize": @"Thu nhỏ",
            @"Close": @"Đóng",
            @"Split Stage": @"Chia màn hình",
            @"Two-way": @"Chia đôi (VH bởi Kitsudo-JTISVN)",
            @"Upper Half": @"Nửa trên",
            @"Lower Half": @"Nửa dưới",
            @"Three-way": @"Chia ba",
            @"Upper Third": @"1/3 Trên",
            @"Middle Third": @"1/3 Giữa",
            @"Lower Third": @"1/3 Dưới",
            @"Trim Mode": @"Chế độ thu gọn",
            @"Lock Stage": @"Khóa vị trí",
            @"Open in Aerial": @"Mở trong Aerial",
            @"Enable flex resize" : @"Bật co giãn linh hoạt",
            @"Disable keyboard avoidance" : @"Tắt tính năng tránh bàn phím",
            @"Restore original scale" : @"Khôi phục tỷ lệ gốc",
            @"Disable flex resize": @"Tắt đổi kích thước",
            @"Enable keyboard avoidance": @"Tránh bàn phím",
            @"Remove Stage State": @"Xóa trạng thái",
            @"Aerial": @"Aerial",
            @"Appearance": @"Giao diện",
            @"Use New Design": @"Sử dụng thiết kế mới",
            @"Only Notch devices can use updated styling": @"Chỉ thiết bị có Tai thỏ mới dùng được giao diện mới",
            @"Per-App Settings": @"Cài đặt riêng cho ứng dụng",
            @"App Settings": @"Cài đặt ứng dụng",
            @"Configure settings for individual apps": @"Thiết lập cấu hình riêng cho từng ứng dụng",
            @"Gesture Settings": @"Cài đặt cử chỉ",
            @"Swipe Mode: Swipe up to minimize, swipe down to open app. Resize Mode: Drag to resize stage visually.": @"Chế độ vuốt: Vuốt lên để thu nhỏ, vuốt xuống để mở ứng dụng. Chế độ kích thước: Kéo để thay đổi kích cỡ khung hình.",
            @"Minus Handle Default Mode": @"Chế độ mặc định của thanh điều khiển",
            @"Swipe Mode": @"Chế độ vuốt",
            @"Resize Mode": @"Chế độ kích thước",
            @"App Switcher Gesture": @"Cử chỉ Trình đa nhiệm",
            @"Choose the gesture to trigger Aerial from the App Switcher.": @"Chọn cử chỉ để kích hoạt Aerial từ Trình đa nhiệm.",
            @"Trigger Gesture": @"Kích hoạt cử chỉ",
            @"Pinch Out": @"Bóp tay ra (Pinch Out)",
            @"Long Press": @"Nhấn giữ",
            @"Swipe Down": @"Vuốt xuống",
            @"Reset": @"Đặt lại",
            @"RESET ALL": @"ĐẶT LẠI TẤT CẢ",
            @"AVAILABLE SHORTCUTS" : @"CÁC PHÍM TẮT KHẢ DỤNG",
            @"Shortcut Settings" : @"Cài đặt phím tắt",
            @"Choose which shortcuts appear in 3D Touch menu" : @"Chọn phím tắt xuất hiện trong menu 3D Touch",
            @"Enable/Disable Flex Resize" : @"Bật/Tắt Thay đổi kích thước linh hoạt",
            @"Enable/Disable Keyboard Avoidance" : @"Bật/Tắt Né bàn phím",
            @"Select which shortcuts to show in the 3D Touch/Haptic Touch menu on app icons." : @"Chọn các phím tắt hiển thị trong menu 3D Touch/Haptic Touch trên biểu tượng ứng dụng.",
            @"Configure settings for this specific app. If a setting matches the global default, it will be removed to save space." : @"Cấu hình cài đặt riêng cho ứng dụng này. Nếu cài đặt trùng với mặc định chung, nó sẽ bị loại bỏ để tiết kiệm dung lượng.",
            @"RESIZE BEHAVIOR" : @"HÀNH VI THAY ĐỔI KÍCH THƯỚC",
            @"Disable Flex Resize" : @"Tắt thay đổi kích thước linh hoạt",
            @"When disabled, the app will be displayed at a fixed scale and cannot be resized freely." : @"Khi tắt, ứng dụng sẽ hiển thị ở tỷ lệ cố định và không thể thay đổi kích thước tự do.",
            @"KEYBOARD BEHAVIOR" : @"HÀNH VI BÀN PHÍM",
            @"Reset App Settings" : @"Đặt lại cài đặt ứng dụng",
            @"Reset all settings for this app to global defaults?" : @"Đặt lại toàn bộ cài đặt của ứng dụng này về mặc định?",
            @"Cancel" : @"Hủy",
            @"Settings Reset" : @"Đặt lại cài đặt",
            @"All settings for this app have been reset to global defaults." : @"Toàn bộ cài đặt của ứng dụng này đã được đặt lại về mặc định.",
            @"Are you sure you want to reset all the preferences?" : @"Bạn có chắc muốn đặt lại toàn bộ tùy chọn không?",
            @"Yes" : @"Có",
            @"No" : @"Không",
            @"Enable Keyboard Avoidance" : @"Bật tính năng né bàn phím",
            @"When enabled, the stage will automatically move up to avoid being covered by the keyboard." : @"Khi bật, khung hình sẽ tự động di chuyển lên để tránh bị bàn phím che khuất.",
            @"Reset to Global Defaults" : @"Đặt lại về mặc định",
            @"ICON SHORTCUTS" : @"Phím tắt biểu tượng",
            @"LINKS" : @"Liên kết",
            @"Copyright ©︎ 2026 uz.ra (@Chr0miumCandy)" : @"Bản quyền ©︎ 2026 uz.ra (@Chr0miumCandy)\nViệt Hoá bởi @Kitsudo"
        };
    });

    return dict[text];
}

%hook UILabel
- (void)setText:(NSString *)text {
    NSString *translated = DichTiengViet(text);
    if (translated) {
        %orig(translated);
    } else {
        %orig(text);
    }
}
%end

%hook PSSpecifier
- (NSString *)name {
    NSString *origName = %orig;
    NSString *translated = DichTiengViet(origName);
    return translated ? translated : origName;
}
%end
