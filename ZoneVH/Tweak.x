#import <UIKit/UIKit.h>

@interface UIButtonLabel : UILabel
@end

@interface UISegmentLabel : UILabel
@end

static NSString* translateString(NSString *text) {
    if (!text || text.length == 0) return text;

    NSDictionary *dict = @{
        @"插件作者: iosdump" : @"Tác giả: iosdump",
        @"作者频道: @iosdumpzzz" : @"Kênh tác giả: @iosdumpzzz",
        @"图标设计: @RrrankkK" : @"Thiết kế Icon: @RrrankkK",
        @"越狱源地址: iosdumpzzz.github.io" : @"Nguồn Jailbreak: iosdumpzzz.github.io\nNhóm Telegram K37•JTISVN: @jtisvietnamrepo",
        @"启用插件" : @"Kích hoạt tweak",
        @"插件设置" : @"Cài đặt Tweak",
        @"增强引擎" : @"Nâng cao",
        @"文字阴影" : @"Đổ bóng chữ",
        @"双击锁屏" : @"Chạm kép để khoá",
        @"编辑图片" : @"Sửa ảnh",
        @"动画速度" : @"Tốc độ hoạt ảnh",
        @"导入壁纸" : @"Nhập hình nền",
        @"壁纸目录" : @"Thư mục hình nền",
        @"切换为视频模式" : @"Chuyển sang chế độ Video",
        @"切换为交互模式" : @"Chuyển sang chế độ Tương tác",
        @"清空壁纸" : @"Xoá toàn bộ hình nền",
        @"注销 (Respring)" : @"Khởi động lại (Respring)",
        @"请输入新的视频名称" : @"Vui lòng nhập tên video mới",
        @"原画" : @"Gốc",
        @"默认" : @"M.định",
        @"较快" : @"Nhanh",
        @"极快" : @"Rất nhanh",
        @"光速" : @"Tốc độ á.sáng",
        @"重命名" : @"Đổi tên",
        @"删除" : @"Xóa",
        @"完成" : @"Hoàn tất",
        @"提示" : @"Thông báo",
        @"导入素材" : @"Nhập hình nền",
        @"请选择素材来源" : @"Vui lòng chọn nguồn",
        @"从相册导入" : @"Nhập từ Thư viện ảnh",
        @"从文件导入" : @"Nhập từ Tệp",
        @"请输入新的壁纸名称" : @"Vui lòng nhập tên hình nền mới",
        @"选择来源" : @"Chọn nguồn",
        @"从相册选择" : @"Chọn từ Thư viện ảnh",
        @"从文件选择" : @"Chọn từ Tệp",
        @"没有更多可撤销的操作" : @"Không còn thao tác để hoàn tác",
        @"关闭" : @"Đóng",
        @"保存" : @"Lưu",
        @"保存成功" : @"Lưu thành công",
        @"编辑" : @"Sửa",
        @"编辑素材" : @"Chỉnh sửa hình nền",
        @"素材替换" : @"Thay thế hình nền",
        @"高级编辑" : @"Chỉnh sửa nâng cao",
        @"恢复默认壁纸" : @"Khôi phục hình nền mặc định",
        
        @"已恢复默认壁纸 (系统已同步)" : @"Đã khôi phục hình nền mặc định (Hệ thống đã đồng bộ)",
        
        @"即将恢复到最初壁纸状态" : @"Khôi phục về trạng thái hình nền ban đầu",
        @"正在恢复..." : @"Đang khôi phục...",
        @"点击上方画板中的图片进行编辑" : @"Chạm vào ảnh trong bảng vẽ phía trên để chỉnh sửa",
        @"正在导入..." : @"Đang nhập...",
        @"全部恢复" : @"Khôi phục tất cả",
        @"当前选中: 无 []" : @"Đang chọn: Trống []",
        @"插入图片" : @"Chèn ảnh",
        @"选择要插入的图层级" : @"Chọn lớp để chèn",
        @"插入到背景层" : @"Chèn vào lớp nền",
        @"插入到悬浮层" : @"Chèn vào lớp nổi",
        @"插入到前景层" : @"Chèn vào lớp tiền cảnh",
        @"息屏" : @"Tắt màn hình",
        @"锁屏" : @"Màn hình khóa",
        @"解锁" : @"Mở khóa",
        @"确定要清空所有已导入的壁纸吗？此操作不可撤销。" : @"Bạn có chắc chắn muốn xóa toàn bộ hình nền đã nhập không? Thao tác này không thể hoàn tác.",
        @"取消" : @"Hủy",
        @"确定" : @"Xác nhận",
        @"开启增强引擎将提升识别复杂交互壁纸能力以及适配壁纸暗黑模式等。" : @"Bật Engine nâng cao sẽ cải thiện khả năng nhận diện các hình nền tương tác phức tạp và tương thích với Chế độ tối,...",
        @"关闭文字阴影。" : @"Tắt đổ bóng chữ.",
        @"开启后手机桌面或锁屏息屏。" : @"Bật để cho phép tắt màn hình từ Màn hình chính hoặc Màn hình khóa.",
        @"开启编辑图片可在每个素材右边按钮点击编辑按钮编辑壁纸图片。" : @"Bật để hiển thị nút bên phải mỗi hình nền, cho phép bạn chỉnh sửa ảnh nền.",
        @"开启后可在壁纸素材绿色按钮调节壁纸息屏跟关屏动画速度。" : @"Sau khi bật, bạn có thể chỉnh tốc độ hoạt ảnh tắt màn hình bằng nút màu xanh lá bên cạnh hình nền.",
        @"图片操作" : @"Thao tác hình ảnh",
        @"选图替换此层 (文件)" : @"Chọn ảnh thay thế lớp này (Từ Tệp)",
        @"选图替换此层 (相册)" : @"Chọn ảnh thay thế lớp này (Từ Ảnh)",
        @"保存相册" : @"Lưu vào album ảnh",
        @"低电模式暂停" : @"Tạm dừng khi ở Chế độ nguồn điện thấp",
        @"锁屏桌面使用同素材" : @"Dùng chung nền cho MHK & MHC",
        @"开启启用插件开关应用全局，视频模式下交互壁纸将自动休眠并彻底释放内存。\n开启锁屏桌面使用同素材时需在锁屏/壁纸素材内重新选择一个。" : @"Bật kích hoạt tinh chỉnh sẽ áp dụng trên toàn hệ thống; ở chế độ video, hình nền tương tác sẽ tự động ngủ và giải phóng hoàn toàn bộ nhớ.\nKhi bật dùng chung hình nền, bạn cần phải chọn lại một hình nền trong mục hình nền/màn hình khóa.",
        @"锁屏壁纸" : @"Hình nền Màn hình khóa",
        @"导入锁屏素材" : @"Nhập hình nền MHK",
        @"未选择" : @"Chưa chọn",
        @"点击应用为锁屏壁纸，向左滑动可删除或重命名。" : @"Chạm để áp dụng làm hình nền Khóa, vuốt trái để xóa hoặc đổi tên.",
        @"桌面壁纸" : @"Hình nền Màn bình chính",
        @"导入桌面素材" : @"Nhập hình nền MHC",
        @"点击应用为桌面壁纸，向左滑动可删除或重命名。" : @"Chạm để áp dụng làm hình nền Màn hình chính, vuốt trái để xóa hoặc đổi tên.",
        @"该壁纸文件没有被替换过任何图片。" : @"Tệp hình nền này chưa được thay thế bất kỳ hình ảnh nào.",
        @"知道了" : @"Đã hiểu",
        @"替换素材" : @"Thay thế dữ liệu",
        @"图层动画" : @"Hoạt ảnh của lớp",
        @"上移" : @"Di chuyển lên",
        @"下移" : @"Di chuyển xuống",
        @"删除图层" : @"Xóa lớp",
        @"点选图层•拖动/双指捏合/双指旋转" : @"Chọn lớp • Kéo / Thu phóng bằng hai ngón tay / Xoay bằng hai ngón tay",
        @"编辑 CAML 动画代码" : @"Chỉnh sửa mã hoạt ảnh CAML",
        @"息屏 -> 锁屏" : @"Tắt màn hình -> Màn khóa",
        @"锁屏 -> 息屏" : @"Màn khóa -> Tắt màn hình",
        @"锁屏 -> 解锁" : @"Màn khóa -> Mở khóa",
        @"解锁 -> 锁屏" : @"Mở khóa -> Màn khóa",
        @"解锁 -> 息屏" : @"Mở khóa -> Tắt màn hình",
        @"息屏 -> 解锁" : @"Tắt màn hình -> Mở khóa",
        @"完整 CAML 动画 (全部)" : @"Hoạt ảnh CAML hoàn chỉnh (Tất cả)",
        @"跳转 Filza 查看" : @"Xem trong Filza"
    };

    NSString *translated = dict[text];
    if (translated) return translated;

    if ([text containsString:@"点击切换壁纸"] && [text containsString:@"每帧重绘降采样"]) {
        return @"Chạm để đổi hình nền. Vuốt trái để xóa hoặc đổi tên hình nền.\nChạm nút bên cạnh hình nền để đặt mức giảm độ phân giải khung hình (Gốc/70%/50%/25%), giúp tiết kiệm pin và giảm bộ nhớ.\n\nBiên dịch bởi Kitsudo";
    }

    if ([text containsString:@"已导入的壁纸"] && [text containsString:@"设置壁纸不正常"]) {
        return @"Hình nền đã nhập\nNếu cài đặt hình nền không hoạt động, hãy thử Respring ở góc trên bên phải.";
    }

    if ([text containsString:@"插件作者"]) {
        NSString *t = text;
        t = [t stringByReplacingOccurrencesOfString:@"插件作者:" withString:@"Tác giả:"];
        t = [t stringByReplacingOccurrencesOfString:@"作者频道:" withString:@"Kênh tác giả:"];
        t = [t stringByReplacingOccurrencesOfString:@"图标设计:" withString:@"Thiết kế Icon:"];
        t = [t stringByReplacingOccurrencesOfString:@"越狱源地址:" withString:@"Nguồn Jailbreak:"];
        t = [t stringByReplacingOccurrencesOfString:@"插件作者" withString:@"Tác giả"];
        t = [t stringByReplacingOccurrencesOfString:@"作者频道" withString:@"Kênh tác giả"];
        t = [t stringByReplacingOccurrencesOfString:@"图标设计" withString:@"Thiết kế Icon"];
        t = [t stringByReplacingOccurrencesOfString:@"越狱源地址" withString:@"Nguồn Jailbreak"];
        
        if ([t containsString:@"Nguồn Jailbreak:"] && [t containsString:@"github.io"] && ![t containsString:@"@jtisvietnamrepo"]) {
            t = [t stringByAppendingString:@"\nNhóm Telegram K37•JTISVN: @jtisvietnamrepo"];
        }
        return t;
    }

    if ([text containsString:@"已导入"] && [text containsString:@"张"]) {
        NSString *t = [text stringByReplacingOccurrencesOfString:@"已导入" withString:@"Đã nhập "];
        return [t stringByReplacingOccurrencesOfString:@"张" withString:@" ảnh"];
    }
    
    if ([text containsString:@"已恢复默认壁纸"] && [text containsString:@"系统已同步"]) {
        return @"Đã khôi phục hình nền mặc định (Hệ thống đã đồng bộ)";
    }
    
    if ([text hasPrefix:@"当前选中:"]) {
        NSString *t = [text stringByReplacingOccurrencesOfString:@"当前选中:" withString:@"Đang chọn: "];
        return [t stringByReplacingOccurrencesOfString:@"无" withString:@"Trống"];
    }
    if ([text hasPrefix:@"当前选中图片:"]) {
        return [text stringByReplacingOccurrencesOfString:@"当前选中图片:" withString:@"Hình ảnh đang chọn: "];
    }
    if ([text hasPrefix:@"已选中素材"]) {
        return [text stringByReplacingOccurrencesOfString:@"已选中素材" withString:@"Đã chọn Hình nền "];
    }
    if ([text hasPrefix:@"素材"]) {
        return [text stringByReplacingOccurrencesOfString:@"素材" withString:@"Hình nền "];
    }

    return text;
}

static NSAttributedString* translateAttributedString(NSAttributedString *orig) {
    if (!orig || orig.length == 0) return orig;
    
    NSMutableAttributedString *mas = [orig mutableCopy];
    BOOL changed = NO;

    NSArray *k = @[@"插件作者:", @"插件作者", @"作者频道:", @"作者频道", @"图标设计:", @"图标设计", @"越狱源地址:", @"越狱源地址"];
    NSArray *v = @[@"Tác giả:", @"Tác giả", @"Kênh tác giả:", @"Kênh tác giả", @"Thiết kế Icon:", @"Thiết kế Icon", @"Nguồn Jailbreak:", @"Nguồn Jailbreak"];
    
    for (int i = 0; i < 8; i++) {
        NSRange range = [[mas string] rangeOfString:k[i]];
        while (range.location != NSNotFound) {
            [mas replaceCharactersInRange:range withString:v[i]];
            changed = YES;
            NSRange nextRange = NSMakeRange(range.location + [v[i] length], [mas string].length - (range.location + [v[i] length]));
            range = [[mas string] rangeOfString:k[i] options:0 range:nextRange];
        }
    }
    
    if ([[mas string] containsString:@"Nguồn Jailbreak:"] && [[mas string] containsString:@"github.io"] && ![[mas string] containsString:@"@jtisvietnamrepo"]) {
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        if ([mas length] > 0) {
            [attrs addEntriesFromDictionary:[mas attributesAtIndex:[mas length] - 1 effectiveRange:NULL]];
        }
        [attrs removeObjectForKey:NSLinkAttributeName];
        
        NSMutableAttributedString *appendStr = [[NSMutableAttributedString alloc] initWithString:@"\nNhóm Telegram K37•JTISVN: @jtisvietnamrepo" attributes:attrs];
        NSURL *teleUrl = [NSURL URLWithString:@"https://t.me/jtisvietnamrepo"];
        if (teleUrl) {
            NSRange linkRange = [[appendStr string] rangeOfString:@"@jtisvietnamrepo"];
            if (linkRange.location != NSNotFound) {
                [appendStr addAttribute:NSLinkAttributeName value:teleUrl range:linkRange];
            }
        }
        [mas appendAttributedString:appendStr];
        changed = YES;
    }
    
    return changed ? mas : orig;
}

%hook UIViewController
%new
- (void)openWallpapersLink {
    NSURL *url = [NSURL URLWithString:@"https://caplayground.vercel.app/wallpapers"];
    if (url) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}
%end

%hook UILabel
- (void)setText:(NSString *)text {
    NSString *t = translateString(text);
    %orig(t);
    // Bắt đúng dòng chứa tên bạn và ép nó tự căn giữa tuyệt đối ở dưới cùng
    if ([t containsString:@"Biên dịch bởi Kitsudo"]) {
        [self setTextAlignment:NSTextAlignmentCenter];
        [self setTextColor:[UIColor secondaryLabelColor]];
    }
}
- (void)setAttributedText:(NSAttributedString *)text {
    NSAttributedString *t = translateAttributedString(text);
    %orig(t);
    if ([[t string] containsString:@"Biên dịch bởi Kitsudo"]) {
        [self setTextAlignment:NSTextAlignmentCenter];
        [self setTextColor:[UIColor secondaryLabelColor]];
    }
}
%end

%hook UITextView
- (void)setText:(NSString *)text {
    NSString *t = translateString(text);
    %orig(t);
}
- (void)setAttributedText:(NSAttributedString *)text {
    NSAttributedString *t = translateAttributedString(text);
    %orig(t);
}
%end

%hook UIButtonLabel
- (void)setText:(NSString *)text {
    NSString *t = translateString(text);
    %orig(t);
}
- (void)setAttributedText:(NSAttributedString *)text {
    NSAttributedString *t = translateAttributedString(text);
    %orig(t);
}
%end

%hook UISegmentLabel
- (void)setText:(NSString *)text {
    NSString *t = translateString(text);
    %orig(t);
}
- (void)setAttributedText:(NSAttributedString *)text {
    NSAttributedString *t = translateAttributedString(text);
    %orig(t);
}
%end

%hook UIButton
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    NSString *t = translateString(title);
    %orig(t, state);
}
- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state {
    NSAttributedString *t = translateAttributedString(title);
    %orig(t, state);
}
%end

%hook UISegmentedControl
- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)segment {
    NSString *t = translateString(title);
    %orig(t, segment);
}
%end

%hook UIBarButtonItem
- (void)setTitle:(NSString *)title {
    NSString *t = translateString(title);
    %orig(t);
}
%end

%hook UINavigationItem
- (void)setTitle:(NSString *)title {
    NSString *t = translateString(title);
    %orig(t);
}
%end

%hook NSBundle
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    NSString *orig = %orig;
    NSString *translated = translateString(orig);
    if (![translated isEqualToString:orig]) return translated;
    
    translated = translateString(key);
    if (![translated isEqualToString:key]) return translated;
    
    return orig;
}
%end