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
        @"View and manage app data from the home screen icon" : @"Xem và quản lý dữ liệu ứng dụng từ biểu tượng trên màn hình chính",
        @"Refresh" : @"Làm mới",
        @"Shut Down" : @"Tắt nguồn",
        @"Settings" : @"Cài đặt",
        @"SETTINGS" : @"CÀI ĐẶT",
        @"Swipe Up" : @"Vuốt lên",
        @"Swipe Down" : @"Vuốt xuống",
        @"Icon Long Press" : @"Nhấn giữ biểu tượng",
        @"Remove Separator" : @"Ẩn đường phân cách",
        @"Theme Style" : @"Kiểu giao diện",
        @"Light" : @"Sáng",
        @"Dark" : @"Tối",
        @"Automatic" : @"Tự động",
        @"More Info" : @"Thông tin thêm (Biên dịch bởi @Kitsudo)",
        @"DEVELOPER" : @"NHÀ PHÁT TRIỂN",
        @"Follow Author" : @"Theo dõi tác giả",
        @"Open Source" : @"Mã nguồn mở",
        @"Modify Optimize" : @"Sửa đổi & Tối ưu",
        @"Rename Icon Name" : @"Đổi tên biểu tượng",
        @"Please enter a new app icon name" : @"Vui lòng nhập tên ứng dụng mới",
        @"Copy" : @"Sao chép",
        @"Update" : @"Cập nhật",
        @"Reset" : @"Đặt lại",
        @"MANAGE" : @"QUẢN LÝ",
        @"Update\nBadge" : @"Cập nhật Huy hiệu",
        @"Update or clear the app badges count" : @"Cập nhật hoặc xóa số đếm huy hiệu ứng dụng",
        @"Clear" : @"Xóa",
        @"Clear\nCaches" : @"Xóa Bộ đệm",
        @"Reset\nData" : @"Đặt lại Dữ liệu",
        @"Resetting the data will clear the \"Documents\" and \"Library\" and \"Tmp\" and \"Program group\" folders from the application data package" : @"Việc đặt lại dữ liệu sẽ xóa các thư mục \"Documents\", \"Library\", \"Tmp\" và \"Program group\" khỏi gói dữ liệu ứng dụng",
        @"取消" : @"Hủy",
        @"Reset\nPermissions" : @"Đặt lại Quyền",
        @"This will clear all the app permissions to access your Contacts, Photos, Camera, etc.\nNext time you use the app it will ask you again to grant permissions." : @"Thao tác này sẽ xóa toàn bộ quyền truy cập của ứng dụng vào Danh bạ, Ảnh, Camera, v.v.\nTrong lần sử dụng tiếp theo, ứng dụng sẽ yêu cầu bạn cấp quyền lại.",
        @"Downgrade\nApp" : @"Hạ cấp Ứng dụng",
        @"Delete app" : @"Xóa ứng dụng",
        @"This will directly delete the app without retaining any app data" : @"Thao tác này sẽ xóa trực tiếp ứng dụng mà không giữ lại bất kỳ dữ liệu nào",
        @"Keep Awake" : @"Giữ sáng màn hình",
        @"Indicator Color" : @"Màu đèn chỉ báo",
        @"Delete" : @"Xóa",
        @"CONTAINERS" : @"THƯ MỤC ỨNG DỤNG",
        @"Bundle" : @"Gói ứng dụng",
        @"Data" : @"Dữ liệu",
        @"APP GROUPS" : @"NHÓM ỨNG DỤNG",
        @"App Internal Version" : @"Phiên bản nội bộ",
        @"Minimum Compatible Version" : @"Phiên bản tương thích tối thiểu",
        @"Platform Build Version" : @"Phiên bản nền tảng",
        @"App Encryption Status" : @"Trạng thái mã hóa ứng dụng",
        @"URL SCHEMES" : @"LƯỢC ĐỒ URL",
        @"QUERIES SCHEMES" : @"LƯỢC ĐỒ TRUY VẤN",
        @"ACTIVITY TYPES" : @"LOẠI HOẠT ĐỘNG",
        @"BACKGROUND MODES" : @"CÁC CHẾ ĐỘ NỀN",
        @"ENTITLEMENTS" : @"QUYỀN HỆ THỐNG",
        @"System App" : @"Ứng dụng hệ thống",
        @"Encrypted" : @"Đã mã hóa",
        @"Open in Filza" : @"Mở trong Filza",
        @"Copy Path" : @"Sao chép đường dẫn",
        @"Copy Identifier" : @"Sao chép định danh",
        @"App Groups" : @"Nhóm ứng dụng",
        @"Manage app data on the Home Screen." : @"Quản lý dữ liệu ứng dụng trên Màn hình chính.",
        @"3D Touch Menu" : @"Menu 3D Touch",
        @"Auto Clear" : @"Tự động xóa bộ nhớ đệm",
        @"Hide Separators" : @"Ẩn đường phân cách",
        @"Running Indicator" : @"Chỉ báo ứng dụng đang chạy",
        @"Layout" : @"Bố cục",
        @"Hidden Apps" : @"Ứng dụng bị ẩn",
        @"None" : @"Không có",
        @"Themes" : @"Giao diện",
        @"Import" : @"Nhập",
        @"Appearance" : @"Giao diện hiển thị",
        @"语言 / Language" : @"Ngôn ngữ / Language",
        @"English" : @"Tiếng Anh (Tiếng Việt)",
        @"简体中文" : @"Tiếng Trung giản thể",
        @"Swipe up/down or 3D Touch to open.\nAuto-clear applies to all.\nHidden apps need respring.\nImport zip themes named by Bundle ID.\nRunning indicator adds a dot." : @"Vuốt lên/xuống hoặc dùng 3D Touch để mở.\nTự động xóa bộ nhớ đệm áp dụng cho tất cả.\nỨng dụng bị ẩn cần Respring để áp dụng.\nNhập tệp giao diện zip được đặt tên theo Bundle ID.\nChỉ báo đang chạy sẽ thêm một chấm nhỏ.",
        @"Default" : @"Mặc định",
        @"MAIN BUTTONS (MAX 6)" : @"NÚT CHÍNH (TỐI ĐA 6)",
        @"MORE LIST" : @"DANH SÁCH KHÁC",
        @"Badge" : @"Huy hiệu",
        @"Clear Cache" : @"Xóa bộ đệm",
        @"Clear Data" : @"Xóa dữ liệu",
        @"Reset Perms" : @"Đặt lại quyền",
        @"Downgrade" : @"Hạ cấp",
        @"Uninstall" : @"Gỡ cài đặt",
        @"Block Open" : @"Chặn mở ứng dụng",
        @"Block Notifs" : @"Chặn thông báo",
        @"No Uninstall" : @"Chặn gỡ ứng dụng",
        @"Block App Update" : @"Chặn cập nhật ứng dụng",
        @"Mute App" : @"Tắt tiếng ứng dụng",
        @"App Lock" : @"Khóa ứng dụng",
        @"Startup Brightness" : @"Độ sáng khi mở",
        @"Features & Guide" : @"Tính năng & Hướng dẫn",
        @"BG Apps" : @"Ứng dụng chạy nền",
        @"Redirects" : @"Chuyển hướng",
        @"Guide" : @"Hướng dẫn",
        @"Developer" : @"Nhà phát triển",
        @"Source Code" : @"Mã nguồn",
        @"Modified By" : @"Chỉnh sửa bởi",
        @"Search" : @"Tìm kiếm",
        @"Apply" : @"Áp dụng",
        @"Respring to apply hidden apps." : @"Respring để áp dụng danh sách ứng dụng bị ẩn.",
        @"- Tap ID/icon/name to edit.\n- Long press icon to mute.\n- Clear Cache: Deletes Caches/Tmp.\n- Clear Data: Deletes Lib/Doc/Tmp.\n- Long press Uninstall/Downgrade for options." : @"- Nhấn vào ID/biểu tượng/tên để chỉnh sửa.\n- Nhấn giữ biểu tượng để tắt tiếng.\n- Xóa bộ nhớ đệm: Xóa các mục Caches/Tmp.\n- Xóa dữ liệu: Xóa các mục Lib/Doc/Tmp.\n- Nhấn giữ Gỡ cài đặt/Hạ cấp để xem thêm tùy chọn.",
        @"Advanced" : @"Nâng cao",
        @"iOS Settings" : @"Cài đặt iOS",
        @"Backgrounding" : @"Chạy nền",
        @"Allowed" : @"Đã cho phép",
        @"Blocked" : @"Đã chặn",
        @"Add Block" : @"Thêm quy tắc chặn",
        @"Exceptions" : @"Ngoại lệ",
        @"Add Exception" : @"Thêm ngoại lệ",
        @"Save" : @"Lưu",
        @"App Perms" : @"Quyền ứng dụng",
        @"Auto" : @"Tự động",
        @"Select" : @"Chọn",
        @"Off" : @"Tắt",
        @"On" : @"Bật",
        @"General" : @"Chung",
        @"Block App Opening" : @"Chặn ứng dụng mở ứng dụng khác",
        @"Block App Being Opened" : @"Chặn ứng dụng bị mở",
        @"Suspend" : @"Tạm dừng",
        @"Auto Suspend" : @"Tự động tạm dừng",
        @"Auto-pause restrictions 10s after launch." : @"Tự động tạm dừng giới hạn 10 giây sau khi khởi chạy.",
        @"Simulate" : @"Mô phỏng",
        @"Simulate Success" : @"Mô phỏng thành công",
        @"Return success signal to caller to stop fallback methods." : @"Trả về tín hiệu thành công cho bên gọi để chặn các phương thức dự phòng.",
        @"Common" : @"Phổ biến",
        @"Custom Blocks" : @"Quy tắc chặn tùy chỉnh",
        @"Backgrounding (Current App)" : @"Chạy nền (Ứng dụng hiện tại)",
        @"Enable Backgrounding" : @"Bật chạy nền",
        @"Prevent Kill" : @"Chống buộc dừng",
        @"Allow Push" : @"Cho phép thông báo Push",
        @"Keep app active in background even if terminated." : @"Giữ ứng dụng hoạt động dưới nền ngay cả khi bị đóng.",
        @"Global Settings" : @"Cài đặt chung",
        @"Enable Component" : @"Bật thành phần",
        @"Show Indicator" : @"Hiện chỉ báo",
        @"Show Toast" : @"Hiện thông báo Toast",
        @"Add 🔒 to Name" : @"Thêm 🔒 vào tên",
        @"Manage background UI indicators." : @"Quản lý các chỉ báo giao diện chạy nền.",
        @"ACTIONS" : @"THAO TÁC",
        @"Power Options" : @"Tùy chọn nguồn",
        @"Action" : @"Thao tác",
        @"Userspace Reboot" : @"Khởi động lại Userspace",
        @"Block Update" : @"Chặn cập nhật",
        @"Revokes all privacy permissions (Camera, Photos, etc.)." : @"Thu hồi tất cả quyền riêng tư (Máy ảnh, Ảnh, v.v.).",
        @"Reset App Perms" : @"Đặt lại quyền ứng dụng",
        @"0个权限" : @"0 quyền",
        @"彻底卸载应用" : @"Gỡ cài đặt hoàn toàn ứng dụng",
        @"Deletes app and all data. Cannot be undone." : @"Xóa ứng dụng và toàn bộ dữ liệu. Thao tác này không thể hoàn tác.",
        @"BG Disabled" : @"Đã tắt chạy nền",
        @"BG Active" : @"Đang chạy nền",
        @"iOS Perms" : @"Quyền iOS",
        @"设置" : @"Cài đặt",
        @"Redirects List" : @"Danh sách chuyển hướng",
        @"Notice" : @"Thông báo",
        @"Respring to change language." : @"Respring để áp dụng thay đổi ngôn ngữ.",
        @"Later" : @"Để sau",
        @"No apps configured." : @"Chưa có ứng dụng nào được cấu hình.",
        @"Enter Brightness (0.0~1.0)" : @"Nhập độ sáng (0.0~1.0)",
        @"-1 to Disable" : @"-1 để Tắt",
        @"Tap to remove.\nRe-enable via AppData panel." : @"Chạm để xóa.\nBật lại thông qua bảng điều khiển AppData.",
        @"Disabled. Re-enable via AppData panel." : @"Đã tắt. Bật lại thông qua bảng điều khiển AppData.",
        @"Downgrade App" : @"Hạ cấp ứng dụng",
        @"Select downgrade method." : @"Chọn phương thức hạ cấp.",
        @"Server" : @"Máy chủ",
        @"Custom ID" : @"Tuỳ chỉnh ID",
        @"Enter App Store Build ID." : @"Nhập Build ID từ App Store.",
        @"Select Version" : @"Chọn phiên bản",
        @"Choose a version to install." : @"Chọn một phiên bản để cài đặt.",
        @"Copyright ©︎ 2026 uz.ra (@Chr0miumCandy)" : @"Bản quyền ©︎ 2026 uz.ra (@Chr0miumCandy)\nViệt Hoá bởi @Kitsudo"
        };
    });

    NSString *translated = dict[text];
    if (translated) return translated;

    if ([text hasSuffix:@" Hidden"]) {
        NSString *countStr = [text stringByReplacingOccurrencesOfString:@" Hidden" withString:@""];
        return [NSString stringWithFormat:@"Đã ẩn %@ ứng dụng", countStr];
    }
    if ([text hasPrefix:@"URL SCHEMES"]) {
        return [text stringByReplacingOccurrencesOfString:@"URL SCHEMES" withString:@"LƯỢC ĐỒ URL"];
    }
    if ([text hasPrefix:@"App:"]) {
        return [text stringByReplacingOccurrencesOfString:@"App:" withString:@"Ứng dụng:"];
    }
    if ([text hasPrefix:@"Version:"]) {
        return [text stringByReplacingOccurrencesOfString:@"Version:" withString:@"Phiên bản:"];
    }
    if ([text hasPrefix:@"Version "]) {
        return [text stringByReplacingOccurrencesOfString:@"Version " withString:@"Phiên bản "];
    }
    if ([text hasPrefix:@"Identifier:"]) {
        return [text stringByReplacingOccurrencesOfString:@"Identifier:" withString:@"Định danh:"];
    }
    if ([text hasPrefix:@"QUERIES SCHEMES"]) {
        return [text stringByReplacingOccurrencesOfString:@"QUERIES SCHEMES" withString:@"LƯỢC ĐỒ TRUY VẤN"];
    }
    if ([text hasPrefix:@"ACTIVITY TYPES"]) {
        return [text stringByReplacingOccurrencesOfString:@"ACTIVITY TYPES" withString:@"LOẠI HOẠT ĐỘNG"];
    }
    if ([text hasPrefix:@"BACKGROUND MODES"]) {
        return [text stringByReplacingOccurrencesOfString:@"BACKGROUND MODES" withString:@"CÁC CHẾ ĐỘ NỀN"];
    }
    if ([text hasPrefix:@"ENTITLEMENTS"]) {
        return [text stringByReplacingOccurrencesOfString:@"ENTITLEMENTS" withString:@"QUYỀN HỆ THỐNG"];
    }

    return nil;
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

- (void)setAttributedText:(NSAttributedString *)attributedText {
    if (attributedText && attributedText.string) {
        NSString *translated = DichTiengViet(attributedText.string);
        if (translated) {
            NSMutableAttributedString *mut = [attributedText mutableCopy];
            [mut replaceCharactersInRange:NSMakeRange(0, mut.length) withString:translated];
            %orig(mut);
            return;
        }
    }
    %orig(attributedText);
}
%end

%hook _UITableViewHeaderFooterViewLabel
- (void)setText:(NSString *)text {
    NSString *translated = DichTiengViet(text);
    %orig(translated ? translated : text);
}
%end

%hook UITableViewHeaderFooterView
- (void)setText:(NSString *)text {
    NSString *translated = DichTiengViet(text);
    %orig(translated ? translated : text);
}
%end

%hook PSSpecifier
- (NSString *)name {
    NSString *origName = %orig;
    NSString *translated = DichTiengViet(origName);
    return translated ? translated : origName;
}
%end
