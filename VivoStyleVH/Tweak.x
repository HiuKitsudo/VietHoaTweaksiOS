#import <UIKit/UIKit.h>

@interface PSListController : UIViewController
- (UITableView *)table;
@end

%hook UILabel

- (void)setText:(NSString *)text {
    if (!text || ![text isKindOfClass:[NSString class]]) {
        %orig;
        return;
    }

    if ([text isEqualToString:@"Enabled"]) { 
        %orig(@"Bật / Tắt"); 
        return; 
    }
    if ([text isEqualToString:@"VivoStyle re-creates vivo's gyroscope \"Flip Card\" lock screen wallpapers. Tilt your phone left/right to cross-fade between your photos."]) {
        %orig(@"VivoStyle tái tạo lại hiệu ứng hình nền màn khoá \"Thẻ lật\" dựa trên con quay hồi chuyển của vivo. Nghiêng máy sang trái hoặc phải để chuyển đổi mượt mà giữa các bức ảnh."); 
        return;
    }

    if ([text isEqualToString:@"PHOTOS"]) { 
        %orig(@"ẢNH"); 
        return; 
    }
    if ([text isEqualToString:@"Choose Photos…"] || [text isEqualToString:@"Choose Photos..."]) { 
        %orig(@"Chọn ảnh…"); 
        return; 
    }
    if ([text isEqualToString:@"Clear Photos"]) { 
        %orig(@"Xoá ảnh"); 
        return; 
    }
    if ([text isEqualToString:@"vivo uses 4 photos by default — you can pick as many as you like. They flip in the order you select them."]) {
        %orig(@"vivo sử dụng mặc định 4 ảnh — bạn có thể chọn số lượng tuỳ thích. Ảnh sẽ lật theo thứ tự mà bạn đã chọn."); 
        return;
    }
    if ([text hasPrefix:@"Selected: "] && [text hasSuffix:@" photos"]) {
        NSString *number = [text stringByReplacingOccurrencesOfString:@"Selected: " withString:@""];
        number = [number stringByReplacingOccurrencesOfString:@" photos" withString:@""];
        NSString *newText = [NSString stringWithFormat:@"Đã chọn: %@ ảnh", number];
        %orig(newText); 
        return;
    }

    if ([text isEqualToString:@"VIDEO WALLPAPER"]) { 
        %orig(@"HÌNH NỀN VIDEO"); 
        return; 
    }
    if ([text isEqualToString:@"Use Video Wallpaper"]) { 
        %orig(@"Dùng hình nền Video"); 
        return; 
    }
    if ([text isEqualToString:@"Choose Video…"] || [text isEqualToString:@"Choose Video..."]) { 
        %orig(@"Chọn Video…"); 
        return; 
    }
    if ([text isEqualToString:@"Video: none"]) { 
        %orig(@"Video: không có"); 
        return; 
    }
    if ([text hasPrefix:@"Video: chosen"]) { 
        NSString *newText = [text stringByReplacingOccurrencesOfString:@"Video: chosen" withString:@"Video: đã chọn"];
        %orig(newText); 
        return; 
    }
    if ([text isEqualToString:@"Clear Video"]) { 
        %orig(@"Xoá Video"); 
        return; 
    }
    if ([text isEqualToString:@"Play a looping, muted video as the lock screen wallpaper instead of the photo flip cards. When on, the video replaces the photos (no gyroscope)."]) {
        %orig(@"Phát lặp lại một đoạn video (tắt tiếng) làm hình nền khoá thay cho các thẻ ảnh lật. Khi bật, video sẽ thay thế toàn bộ ảnh (không dùng con quay hồi chuyển)."); 
        return;
    }

    if ([text isEqualToString:@"FEEL"]) { 
        %orig(@"TRẢI NGHIỆM"); 
        return; 
    }
    if ([text isEqualToString:@"Loop Around"]) { 
        %orig(@"Lặp vòng"); 
        return; 
    }
    if ([text isEqualToString:@"Sensitivity controls how much tilt is needed to flip through all photos. Parallax adds depth. Smoothing makes the motion silkier."]) {
        %orig(@"Độ nhạy kiểm soát mức độ nghiêng máy cần thiết để lướt qua các ảnh. Thị sai tạo thêm chiều sâu. Làm mượt giúp chuyển động trơn tru hơn."); 
        return;
    }

    if ([text isEqualToString:@"TRANSITION"]) { 
        %orig(@"HIỆU ỨNG CHUYỂN CẢNH"); 
        return; 
    }
    if ([text isEqualToString:@"Transition"]) { 
        %orig(@"Hiệu ứng chuyển cảnh"); 
        return; 
    }
    if ([text isEqualToString:@"How photos change as you tilt"]) { 
        %orig(@"Cách ảnh thay đổi khi bạn nghiêng máy"); 
        return; 
    }
    if ([text hasPrefix:@"Transition: "]) {
        NSString *type = [text substringFromIndex:12];
        NSString *localizedType = type;
        if ([type isEqualToString:@"Cross-fade"]) localizedType = @"Mờ dần";
        else if ([type isEqualToString:@"Prism Lenticular"]) localizedType = @"Lăng kính";
        else if ([type isEqualToString:@"Frosted Glass"]) localizedType = @"Kính mờ";
        else if ([type isEqualToString:@"Depth"]) localizedType = @"Chiều sâu";
        
        NSString *newText = [NSString stringWithFormat:@"Hiệu ứng: %@", localizedType];
        %orig(newText); 
        return;
    }
    if ([text isEqualToString:@"vivo's lenticular transitions. Cross-fade (渐隐渐显): dissolve. Prism Lenticular (棱镜光栅): the next photo opens through vertical light-grating strips. Frosted Glass (磨砂玻璃): cross-fade through frosted glass. Depth (景深): a depth-of-field focus shift."]) {
        %orig(@"Các hiệu ứng của vivo. Mờ dần: hoà trộn. Lăng kính: ảnh tiếp theo xuất hiện qua các vệt sáng dọc. Kính mờ: mờ dần qua lớp kính mờ. Chiều sâu: thay đổi tiêu cự độ sâu trường ảnh."); 
        return;
    }
    
    if ([text hasSuffix:@"Cross-fade"]) { 
        NSString *newText = [text stringByReplacingOccurrencesOfString:@"Cross-fade" withString:@"Mờ dần"];
        %orig(newText); 
        return; 
    }
    if ([text hasSuffix:@"Prism Lenticular"]) { 
        NSString *newText = [text stringByReplacingOccurrencesOfString:@"Prism Lenticular" withString:@"Lăng kính"];
        %orig(newText); 
        return; 
    }
    if ([text hasSuffix:@"Frosted Glass"]) { 
        NSString *newText = [text stringByReplacingOccurrencesOfString:@"Frosted Glass" withString:@"Kính mờ"];
        %orig(newText); 
        return; 
    }
    if ([text hasSuffix:@"Depth"]) { 
        NSString *newText = [text stringByReplacingOccurrencesOfString:@"Depth" withString:@"Chiều sâu"];
        %orig(newText); 
        return; 
    }

    if ([text isEqualToString:@"WALLPAPER SIZE"]) { 
        %orig(@"KÍCH THƯỚC HÌNH NỀN"); 
        return; 
    }
    if ([text isEqualToString:@"Fill Screen"]) { 
        %orig(@"Kín màn hình"); 
        return; 
    }
    if ([text isEqualToString:@"OFF (Original): the whole photo is shown, centered, with a blurred backdrop filling the edges.\nON (Fill Screen): the photo is scaled up to fill the entire screen — edges cropped, no stretching."]) {
        %orig(@"TẮT (Gốc): hiển thị toàn bộ ảnh ở giữa, với nền mờ lấp đầy các viền.\nBẬT (Kín màn hình): ảnh được phóng to để lấp đầy toàn bộ màn hình — cắt bớt viền, không kéo giãn."); 
        return;
    }
    if ([text isEqualToString:@"Apply & Respring"]) { 
        %orig(@"Áp dụng & Respring"); 
        return; 
    }

    if ([text isEqualToString:@"Saving your photos."]) { 
        %orig(@"Đang lưu ảnh của bạn."); 
        return; 
    }
    if ([text isEqualToString:@"Saving your video."]) { 
        %orig(@"Đang lưu video của bạn."); 
        return; 
    }
    if ([text isEqualToString:@"Importing…"] || [text isEqualToString:@"Importing..."]) { 
        %orig(@"Đang nhập…"); 
        return; 
    }

    %orig(text);
}

%end

%hook PSListController

- (void)viewWillAppear:(BOOL)animated {
    %orig;
    
    if ([self.title isEqualToString:@"VivoStyle"]) {
        UITableView *tableView = nil;
        
        if ([self respondsToSelector:@selector(table)]) {
            tableView = [self table];
        } else if ([self valueForKey:@"_table"]) {
            tableView = [self valueForKey:@"_table"];
        }
        
        if (tableView && tableView.tableFooterView.tag != 999) {
            UIView *footerContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 50)];
            footerContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            footerContainer.tag = 999; 
            
            UILabel *lblCredit = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, tableView.bounds.size.width, 20)];
            lblCredit.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            lblCredit.text = @"Biên dịch bởi @Kitsudo";
            lblCredit.textAlignment = NSTextAlignmentCenter;
            lblCredit.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
            lblCredit.textColor = [UIColor systemGrayColor]; 
            
            [footerContainer addSubview:lblCredit];
            
            tableView.tableFooterView = footerContainer;
        }
    }
}

%end