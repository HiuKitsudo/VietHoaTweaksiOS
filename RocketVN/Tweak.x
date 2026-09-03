#import <UIKit/UIKit.h>

static NSString *translateString(NSString *text) {
    if (!text || text.length == 0) return text;

    // 1. Xử lý nhận diện động cho các chuỗi có thể thay đổi phiên bản (Version/Build)
    if ([text rangeOfString:@"Rocket for Instagram" options:NSCaseInsensitiveSearch].location != NSNotFound) {
        // Tìm số phiên bản và build để giữ lại
        NSRange range = [text rangeOfString:@"v[0-9.]+(\\s+Build\\s+[a-zA-Z0-9]+)?" options:NSRegularExpressionSearch];
        if (range.location != NSNotFound) {
            NSString *versionInfo = [text substringWithRange:range];
            return [NSString stringWithFormat:@"Rocket cho Instagram %@.", versionInfo];
        }
        return @"Rocket cho Instagram";
    }
    
    if ([text rangeOfString:@"Manage license at" options:NSCaseInsensitiveSearch].location != NSNotFound) {
        return @"Quản lý bản quyền tại https://getrocketapp.io/license.";
    }

    // 2. Từ điển dịch các chuỗi tĩnh cố định
    static NSDictionary *dict = nil;
    if (!dict) {
        dict = @{
            @"Save": @"Lưu",
            @"Copy Media URL": @"Sao chép liên kết",
            @"Repost": @"Đăng lại",
            @"Copy Caption": @"Sao chép chú thích",
            @"Auto-scroll": @"Tự động cuộn",
            @"Select which actions should appear in Feed": @"Chọn các hành động hiển thị trong Bảng tin",
            @"Select which actions should appear in Reels": @"Chọn các hành động hiển thị trong Reels",
            @"Select which actions should appear in Stories": @"Chọn các hành động hiển thị trong Tin",
            @"FEED": @"Bảng tin",
            @"REELS": @"Reels",
            @"STORIES": @"Tin",
            @"MESSAGES" : @"TIN NHẮN",
            @"Select which actions should appear in Messages" : @"Chọn các thao tác sẽ xuất hiện trong Tin nhắn",
            @"Restore defaults" : @"Đặt lại",
            @"Restore defaults?" : @"Đặt lại về mặc định?",
            @"This will reset the app tab bar layout and clear your custom tab bar preferences." : @"Thao tác này sẽ đặt lại bố cục thanh tab của ứng dụng và xóa các thiết lập tùy biến thanh tab của bạn.",
            @"Cancel" : @"Hủy",
            @"DRAG TABS HERE" : @"KÉO CÁC TAB VÀO ĐÂY",
            @"Hidden" : @"Bị ẩn",
            @"Press and hold on a tab to re-arrange it. You can also drag it to the section below to hide it." : @"Nhấn giữ vào một tab để sắp xếp lại thứ tự. Bạn cũng có thể kéo nó xuống phần bên dưới để ẩn đi.",
            @"Close" : @"Đóng",
            @"Rocket is unlocked" : @"Đã mở khóa Rocket",
            @"You already have unlocked all features of the tweak. Enjoy!" : @"Bạn đã mở khóa toàn bộ tính năng của tweak. Hãy tận hưởng nhé!",
            @"CONFIGURATION" : @"CẤU HÌNH",
            @"Enable grid feed" : @"Bật bảng tin dạng lưới",
            @"Default feed" : @"Bảng tin mặc định",
            @"List" : @"Danh sách",
            @"Grid" : @"Lưới",
            @"Grid density" : @"Mật độ lưới",
            @"Default" : @"Mặc định",
            @"Compact" : @"Thu gọn",
            @"Adds the grid feed controls. When enabled, choose whether the feed opens in grid or list mode when the app starts." : @"Thêm trình điều khiển bảng tin dạng lưới. Khi bật, bạn có thể chọn bảng tin hiển thị dạng lưới hoặc danh sách mỗi khi mở ứng dụng.",
            @"Customize tab bar" : @"Tùy biến thanh tab",
            @"5 visible" : @"Hiển thị 5 tab",
            @"Customize the main Instagram tab bar order and hide tabs." : @"Tùy chỉnh thứ tự thanh tab chính của Instagram và ẩn các tab không cần thiết.",
            @"Enable action buttons" : @"Bật các nút thao tác",
            @"Action buttons" : @"Nút thao tác",
            @"All selected" : @"Đã chọn tất cả",
            @"Adds action buttons to feed, Reels, Profile, stories, and message media. Choose exactly which buttons appear." : @"Thêm các nút thao tác nhanh vào bảng tin, Reels, Trang cá nhân, Story và phương tiện trong tin nhắn. Bạn có thể chọn chính xác các nút sẽ xuất hiện.",
            @"Zoom posts and profile pictures" : @"Phóng to bài viết và ảnh đại diện",
            @"Long-press feed posts or profile pictures to open Rocket's zoom viewer." : @"Nhấn giữ vào bài viết trên bảng tin hoặc ảnh đại diện để mở trình xem phóng to của Rocket.",
            @"Confirm like actions" : @"Xác nhận trước khi thích",
            @"Shows a confirmation prompt before like button taps and double-tap likes are sent." : @"Hiển thị hộp thoại xác nhận trước khi bạn nhấn nút Thích hoặc chạm đúp để thích bài viết.",
            @"Hide sponsored media" : @"Ẩn bài viết được tài trợ",
            @"Removes sponsored media from the feed and suppresses ad payloads in stories, Reels, and other feeds." : @"Loại bỏ các bài viết được tài trợ khỏi bảng tin và chặn hoàn toàn quảng cáo trong Story, Reels cũng như các khu vực khác.",
            @"Anonymously view stories" : @"Xem Story ẩn danh",
            @"Prevents story owners from receiving seen receipts until you manually mark a story as seen." : @"Ngăn người đăng Story biết bạn đã xem cho đến khi bạn tự nhấn đánh dấu đã xem thủ công.",
            @"Pause story auto-advance" : @"Tạm dừng tự động chuyển Story",
            @"Stops the story timer from advancing to the next item. Taps and swipes still advance stories." : @"Dừng bộ đếm thời gian tự động chuyển sang Story tiếp theo. Bạn vẫn có thể chạm hoặc vuốt để tự chuyển.",
            @"Anonymously view messages" : @"Xem tin nhắn ẩn danh",
            @"Prevents direct message seen receipts and visual-message playback receipts until you manually mark messages as seen." : @"Ngăn đối phương biết bạn đã đọc tin nhắn hoặc đã xem ảnh/video tạm thời cho đến khi bạn tự nhấn đánh dấu đã đọc thủ công.",
            @"Hide typing indicator" : @"Ẩn trạng thái đang soạn thảo",
            @"Prevents direct-message typing status updates from being sent while you compose messages." : @"Ngăn hiển thị trạng thái \"đang nhập...\" trong tin nhắn trực tiếp khi bạn đang soạn nội dung.",
            @"Spoof profile stats" : @"Fake thông số trang cá nhân",
            @"Locally overrides profile stats on your own profile. Other users do not see these values." : @"Thay đổi các số liệu hiển thị trên trang cá nhân của riêng bạn (chỉ có tác dụng cục bộ trên máy của bạn, người khác sẽ không nhìn thấy).",
            @"View friendship status on profile" : @"Xem trạng thái theo dõi trên trang cá nhân",
            @"Shows whether profile users follow you while viewing profiles." : @"Hiển thị thông tin người đó có đang theo dõi bạn hay không ngay khi bạn truy cập vào trang cá nhân của họ.",
            @"SUPPORT" : @"HỖ TRỢ (Biên dịch bởi @Kitsudo)",
            @"Stats to override" : @"Thông số muốn thay đổi",
            @"None" : @"Không có",
            @"Override Followers" : @"Thay đổi số Người theo dõi",
            @"Enable this stat and enter the value you should be shown locally." : @"Bật thông số này và nhập giá trị bạn muốn hiển thị trên thiết bị của mình.",
            @"Override Following" : @"Thay đổi số Đang theo dõi",
            @"Override Posts" : @"Thay đổi số Bài viết",
            @"Override Verified badge" : @"Fake tích xanh",
            @"Shows a local verified badge on your own profile when spoofing is enabled." : @"Hiển thị biểu tượng tích xanh (chỉ hiển thị trên máy của bạn) trên trang cá nhân khi tính năng fake thông số được bật.",
            @"View Image" : @"Xem ảnh",
            @"Copy to Clipboard" : @"Sao chép",
            @"Profile" : @"Trang cá nhân",
            @"Public" : @"Công khai",
            @"Posts" : @"Bài viết",
            @"Followers" : @"Người theo dõi",
            @"Following" : @"Đang theo dõi"
        };
    }
    return dict[text] ? dict[text] : text;
}

// Hook toàn bộ UILabel (Bao gồm cả UIButtonLabel nội bộ của UIButton)
%hook UILabel
- (void)setText:(NSString *)text {
    self.adjustsFontSizeToFitWidth = YES;
    if (self.minimumScaleFactor == 0.0) {
        self.minimumScaleFactor = 0.7;
    }
    %orig(translateString(text));
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    if (attributedText && attributedText.string.length > 0) {
        NSString *translated = translateString(attributedText.string);
        if (![translated isEqualToString:attributedText.string]) {
            NSMutableAttributedString *mutAttr = [attributedText mutableCopy];
            [mutAttr replaceCharactersInRange:NSMakeRange(0, attributedText.length) withString:translated];
            %orig(mutAttr);
            return;
        }
    }
    %orig(attributedText);
}
%end

%hook _UITableViewHeaderFooterViewLabel
- (void)setText:(NSString *)text {
    UILabel *label = (UILabel *)self;
    label.adjustsFontSizeToFitWidth = YES;
    if (label.minimumScaleFactor == 0.0) {
        label.minimumScaleFactor = 0.7;
    }
    %orig(translateString(text));
}
%end

%hook UIButton
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    %orig(translateString(title), state);
}
%end
