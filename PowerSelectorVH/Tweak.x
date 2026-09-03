#import <UIKit/UIKit.h>

// --- BIẾN TĨNH (Tối ưu hiệu năng) ---
static NSDictionary *g_TuDien = nil;

static void KhoiTaoTuDien() {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_TuDien = @{
            // Menu chính
            @"PowerSelector": @"PowerSelector",
            @"SYSTEM FUNCTION": @"CHỨC NĂNG HỆ THỐNG",
            @"Power Off": @"Tắt nguồn",
            @"Reboot": @"Khởi động lại",
            @"UserSpace Reboot": @"Khởi động lại ko gian người dùng",
            @"LDRestart": @"LDRestart",
            @"Safe Mode": @"Chế độ an toàn",
            @"gUICache": @"Xóa bộ nhớ đệm (GUI)", // Đã chuẩn hoá
            @"UICache": @"Xóa bộ nhớ đệm",       // Đã chuẩn hoá
            @"Respring": @"Respring",
            @"Cancel": @"Hủy",
            
            // Popup xác nhận
            @"Confirm Power Off": @"Xác nhận Tắt nguồn",
            @"Confirm Reboot": @"Xác nhận Khởi động lại",
            @"Confirm UserSpace Reboot": @"Xác nhận KĐL UserSpace",
            @"Confirm LDRestart": @"Xác nhận LDRestart",
            @"Confirm SafeMode": @"Xác nhận Chế độ an toàn",
            @"Confirm UICache": @"Xác nhận Xóa bộ nhớ đệm", // Đã chuẩn hoá
            @"Confirm Respring": @"Xác nhận Respring",
            
            // Thông tin & Cài đặt
            @"INFOMATION": @"THÔNG TIN",
            @"INFORMATION": @"THÔNG TIN",
            @"CREDIT": @"THÔNG TIN (Việt Hoá bởi @Kitsudo)", 
            @"Donate": @"Ủng hộ",
            @"Donation": @"Ủng hộ",
            @"Follow on Twitter": @"Theo dõi Twitter",
            @"Operate iOS power supply relationship": @"Quản lý các chức năng nguồn iOS",
            @"CC TOGGLE SETTINGS": @"CÀI ĐẶT NÚT CONTROL CENTER",
            @"Control Center": @"Trung tâm điều khiển",
            @"POWER SLIDER SETTINGS": @"CÀI ĐẶT THANH TRƯỢT TẮT NGUỒN",
            @"Power Slider": @"Thanh trượt nguồn",
            @"RESPRING": @"CÀI ĐẶT RESPRING",
            @"Use sbreload": @"Dùng sbreload",
            @"APPLICATIONS": @"ỨNG DỤNG",
            @"Use Apps": @"Hiện trong Ứng dụng",
            
            // Control Center
            @"RESPRING WITH A LONG PRESS": @"RESPRING KHI NHẤN GIỮ",
            @"Respring by Long press": @"Nhấn giữ để Respring",
            @"If you turn it on, press and hold the CC button to Respring.": @"Nếu bật, nhấn và giữ nút trong CC để Respring.",
            @"RESPRING ONLY": @"CHỈ RESPRING",
            @"Use Respring Only": @"Chỉ dùng tính năng Respring",
            @"If you turn it on, tap the CC button and it will immediately respring.": @"Nếu bật, chạm vào nút CC sẽ Respring ngay lập tức.",
            @"SELECT BUTTON TO USE": @"CHỌN NÚT ĐỂ SỬ DỤNG",
            @"Lock": @"Khóa màn hình",
            @"CommCenter & mediaserverd": @"Khởi động lại Mạng & Media",
            @"Copy WiFi IP": @"Sao chép IP Wi-Fi",
            @"Copy Global IP": @"Sao chép IP Global",
            @"INFORMATION SECTION": @"MỤC THÔNG TIN",
            @"Display Wi-Fi IP": @"Hiện IP Wi-Fi",
            @"Display Global IP": @"Hiện IP Global",
            @"Display uptime": @"Hiện thời gian hoạt động",
            @"Display RAM Info": @"Hiện thông tin RAM",
            @"OPTION": @"TÙY CHỌN",
            @"Disable when Passcode Locked": @"Vô hiệu hóa khi khóa mật khẩu",
            @"Respring after gUICache": @"Respring sau khi xóa bộ nhớ đệm" // Đã chuẩn hoá
        };
    });
}

static NSString *DichTiengViet(NSString *text) {
    if (!text || ![text isKindOfClass:[NSString class]] || text.length == 0 || text.length > 2000) return nil;

    if (!g_TuDien) KhoiTaoTuDien();
    
    // 1. Tra từ điển
    NSString *kq = g_TuDien[text];
    if (kq) return kq;
    
    // 2. Xử lý RAM / IP
    if ([text containsString:@"RAM"]) {
        if ([text containsString:@"Free RAM"]) 
            return [text stringByReplacingOccurrencesOfString:@"Free RAM" withString:@"RAM Trống"];
        if ([text containsString:@"Installed RAM"]) 
            return [text stringByReplacingOccurrencesOfString:@"Installed RAM" withString:@"Tổng RAM"];
    }
    if ([text containsString:@"Wi-Fi IP:"]) 
        return [text stringByReplacingOccurrencesOfString:@"Wi-Fi IP:" withString:@"IP Wi-Fi:"];

    // 3. Xử lý các đoạn văn dài
    if ([text containsString:@"kernel space intact"]) {
        return @"LDRestart là khởi động lại mềm (Soft-reboot). Nó giống như khởi động lại truyền thống nhưng giữ nguyên Kernel để không mất Jailbreak.";
    }
    
    if ([text containsString:@"kernel_task is not restarted"]) {
        return @"UserSpace Reboot: Khởi động lại không gian người dùng (không chạy lại kernel_task). Giữ nguyên trạng thái Jailbreak. Đây KHÔNG PHẢI là untether.\n- Có thể hoạt động không ổn định tùy thiết bị.";
    }
    
    if ([text containsString:@"sbreload works"]) 
        return @"Nếu sbreload hoạt động, nó sẽ được ưu tiên thay thế Respring thường (Nhanh hơn).";
    if ([text containsString:@"displayed in Safe Mode"]) 
        return @"Cho phép hiển thị menu ngay cả khi thiết bị vào Chế độ an toàn (Safe Mode).";
    if ([text containsString:@"donation by Paypal"]) 
        return @"Nếu bạn thích tweak này, hãy ủng hộ tôi qua PayPal.";
    if ([text containsString:@"Global IP is acquired"])
        return @"IP Global lấy từ ipify.org. Nếu TẮT sẽ không kết nối server.\nIP thay đổi tùy theo Wi-Fi hoặc Dữ liệu di động.";

    return nil;
}

// --- GROUP HOOKS ---
%group PowerSelectorHooks

%hook UILabel
- (void)setText:(NSString *)text {
    NSString *tv = DichTiengViet(text);
    %orig(tv ?: text);
}

// Đã FIX lỗi Crash dãn cách bộ nhớ
- (void)setAttributedText:(NSAttributedString *)attributedText {
    if (attributedText && attributedText.length > 0) {
        NSMutableAttributedString *newAttr = [[NSMutableAttributedString alloc] init];
        [attributedText enumerateAttributesInRange:NSMakeRange(0, attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
            NSString *substring = [attributedText.string substringWithRange:range];
            NSString *translated = DichTiengViet(substring);
            NSAttributedString *newSub = [[NSAttributedString alloc] initWithString:(translated ?: substring) attributes:attrs];
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
    NSString *tv = DichTiengViet(title);
    %orig(tv ?: title, state);
}
%end

%hook UIAlertAction
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *action))handler {
    NSString *tv = DichTiengViet(title);
    return %orig(tv ?: title, style, handler);
}
%end

%hook UIAlertController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    NSString *tvTitle = DichTiengViet(title);
    NSString *tvMessage = DichTiengViet(message);
    return %orig(tvTitle ?: title, tvMessage ?: message, preferredStyle);
}
%end

%hook UITableView
- (void)setTableFooterView:(UIView *)view {
    %orig;
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel *lbl = (UILabel *)view;
        NSString *tv = DichTiengViet(lbl.text);
        if (tv && ![lbl.text isEqualToString:tv]) {
            lbl.text = tv;
        }
    }
}
%end

%end // End Group

// --- BỘ LỌC AN TOÀN ---
%ctor {
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    NSString *processName = [[NSProcessInfo processInfo] processName];
    
    if ([bundleID isEqualToString:@"com.apple.springboard"] ||
        [bundleID isEqualToString:@"com.apple.Preferences"] ||
        [bundleID.lowercaseString containsString:@"powerselector"] || 
        [processName.lowercaseString containsString:@"powerselector"]) {
        %init(PowerSelectorHooks);
    }
}