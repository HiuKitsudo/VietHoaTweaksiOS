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
        @"🔍 扫描垃圾文件" : @"🔍 Quét các tệp tin rác",
        @"🚀 一键清理全部" : @"🚀 Dọn Sach Tất Cả",
        @"清理" : @"Dọn",
        @"正在清理" : @"Đang dọn dẹp",
        @"确认清理" : @"Xác nhận dọn dẹp",
        @"确定" : @"Xác nhận",
        @"清理完成" : @"Dọn dẹp hoàn tất",
        @"清理全部" : @"Dọn dẹp tất cả",
        @"取消" : @"Huỷ",
        @"移除" : @"Xoá bỏ",
        @"打开路径" : @"Đường dẫn",
        @"打开 Filza" : @"Mở Filza",
        @"清理项目" : @"Chi Tiết Dọn Dẹp",
        @"缓存文件" : @"Tệp bộ nhớ đệm",
        @"临时文件" : @"Tệp tin tạm thời",
        @"Cookie & 网页数据" : @"Cookie & Dữ liệu Web",
        @"系统日志" : @"Nhật ký hệ thống",
        @"📱 第三方应用缓存" : @"📱 Bộ nhớ đệm ứng dụng",
        @"199.41 MB (68个应用)" :@"(68个应用 Ứng dụng)",
        @"扫描完成" : @"Quét hoàn tất",
        @"发现 24.40 MB 可清理空间" : @"Đã tìm thấy 24.40 MB dung lượng có thể dọn dẹp",
        @"确定要清理所有第三方应用的缓存吗？\n此操作不会影响应用数据。" : @"Bạn có chắc chắn muốn dọn dẹp bộ nhớ đệm của tất cả ứng dụng bên thứ ba không?\nThao tác này sẽ không ảnh hưởng đến dữ liệu ứng dụng.",
        @"确定要清理所有垃圾文件吗？" : @"Bạn có chắc chắn muốn dọn dẹp tất cả các tệp rác không?",
        @"选择要清理的应用" : @"Chọn ứng dụng cần dọn dẹp",
        @"加载应用列表" : @"Đang tải danh sách ứng dụng",
        @"正在扫描已安装应用..." : @"Đang quét các ứng dụng đã cài đặt...",
        @"设置" : @"Cài Đặt",
        @"存储设置" : @"Cài đặt lưu trữ",
        @"显示隐藏文件" : @"Hiển thị tệp ẩn",
        @"在文件列表中显示隐藏文件" : @"Hiển thị các tệp ẩn trong danh sách tệp tin",
        @"大文件阈值" : @"Ngưỡng tệp lớn",
        @"选择大文件的判定标准" : @"Chọn tiêu chi xác định cho tệp lớn",
        @"设置大文件的判定标准" : @"Đặt tiêu chi xác định tệp lớn",
        @"扫描深度" : @"Độ sâu quét",
        @"选择扫描目录的深度级别" : @"Chọn mức độ sâu khi quét thư mục",
        @"深度扫描会检查更多目录，但可能需要更长时间。" : @"Quét sâu sẽ kiểm tra nhiều thư mục hơn, nhưng có thể cần nhiều thời gian hơn.",
        @"深度扫描" : @"Quét sâu",
        @"快速扫描" : @"Quét nhanh",
        @"标准扫描" : @"Quét tiêu chuẩn",
        @"清理记录" : @"Nhật ký dọn dẹp",
        @"清理历史记录" : @"Xoá lịch sử",
        @"查看清理历史" : @"Xem lịch sử dọn dẹp",
        @"清理详情" : @"Chi tiết",
        @"暂无清理历史记录" : @"Chưa có lịch sử (Trống)",
        @"第三方应用: " : @"Ứng dụng bên thứ ba",
        @"第三方应用缓存（全部）" : @"Bộ nhớ đệm ứng dụng bên thứ ba (Tất cả)",
        @"清理统计" : @"Thống kê dọn dẹp",
        @"查看总清理空间统计" : @"Xem số thống kê tổng dung lượng trống",
        @"应用信息" : @"Thông tin ứng dụng",
        @"版本信息" : @"Thông tin phiên bản",
        @"版本 1.0 (Build 1)重构版本" : @"Phiên bản 1.0 (Build 1) tái cáu trúc",
        @"版本 1.1 (Build 1)重构版本" : @"Phiên bản 11 (Build 1) tái cấu trúc",
        @"使用帮助" : @"Gợi ý sử dụng",
        @"我知道了" :  @"Ok, Đã biểu",
        @"查看使用说明和常见问题" : @"Xem hướng dẫn sử dụng và câu hỏi thường gặp",
        @"隐私政策" : @"Chính sách bảo mật",
        @"查看隐私政策" : @"Xem chính sách bảo mật",
        @"关于我们" : @"Giới thiệu - Dịch bơi @Kitsudo",
        @"关于 iOSCleanPro" : @"Giới thiệu về iOSCleanPro",
        @"关注我们" : @"Liên hệ & Ủng hộ chúng tôi",
        @"访问官网" : @"Trang web chính thức",
        @"关注公众号" : @"Thông tin liên hệ chính thức",
        @"获取更多精彩内容" : @"Xem thêm nhiều nội dung hấp dẫn",
        @"给个Star支持一下" : @"Tặng ngôi sao để ủng hộ",
        @"清空" : @"Xoá",
        @"清空历史记录" : @"Xoá lịch sử",
        @"确定要清空所有清理历史记录吗？此操作无法撤销。" : @"Bạn có chắc chắn muốn xoá tất cả lịch sử dọn dẹp không? Thao tác này không thể hoàn tác",
        @"清理第三方应用缓存" : @"Dọn bộ nhớ đệm ứng dụng bên thứ ba",
        @"正在清理第三方应用缓存" : @"Đang dọn dẹp ứng dụng bên thứ ba",
        @"一键清理全部" : @"Dọn dẹp tất cả",
        @"清理应用缓存" : @"Dọn dẹp bộ nhớ đệm ứng dụng",
        @"清理强度" : @"Cường độ dọn dẹp",
        @"选择清理的深度级别" : @"Chọn mức độ dọn dẹp",
        @"超级清理" : @"Dọn dẹp tất cả",
        @"深度清理" : @"Dọn dẹp sâu",
       @"标准清理" :@"Dọn dẹp tiêu chuẩn",
        @"清理保护" : @"Bảo vệ dọn dẹp",
        @"清理白名单" : @"Xoá danh sách trăng",
        @"管理清理白名单应用" :@"Quản lý ứng dụng trong danh sách trắng",
        @"应用列表" : @"Danh sách ứng dụng",
        @"搜索应用" : @"Tìm kiểm ứng dụng",
        @"清理系统应用缓存" : @"Dọn dẹp bộ nhớ đệm Ứng dụng hệ thống",
        @"选择清理的深度级别\n\n• 标准清理：只清理应用沙盒内的缓存\n• 深度清理：包括系统级路径的清理\n• 超级清理：深度清理 + 更多系统路径" : @"Chọn mức độ dọn dẹp phù hợp\n\n• Dọn tiêu chuẩn: Chỉ xóa bộ nhớ đệm trong hộp cát ứng dụng\n• Dọn sâu: Bao gồm dọn dẹp đường dẫn cấp hệ thống\n• Dọn tất cả: Dọn dẹp sâu + nhiều đường dẫn hệ thống hơn",
       @"暂无白名单应用\n\n点击右上角 + 按钮添加应用" : @"Chưa có ứng dụng trong danh sách trắng\n\nNhấn nút + ở góc trên bên phải để thêm ứng dụng",
        @"确认移除" : @"Xác nhận xoá",
    };

    regexPatterns = @[
@{
            @"pattern": @"([^’']+)\n已使用",
            @"replacement": @"Đã sử dụng\n$1",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"清理中...([^’']+)",
            @"replacement": @"Đang dọn...$1",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"将在 Filza 中打开路径：([^’']+)您可以在 Filza 中按需删除文件。",
            @"replacement": @"Vào đường dẫn Filza$1Bạn có thể xóa các tệp tin trong Filza nếu cần.",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"确定要将([^’']+)从白名单移除吗？\n移除后，该应用的缓存可被一键清理。",
            @"replacement": @"Bạn có chắc chắn muốn xóa$1khỏi danh sách trắng không?\nSau khi xóa, bộ nhớ đệm của ứng dụng này có thể bị dọn dẹp (khi dùng tính năng dọn dẹp tất cả).",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"用户应用([^’']+)",
            @"replacement": @"Ứng dụng người dùng$1",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"系统应用([^’']+)",
            @"replacement": @"Ứng dựng hệ thống$1",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"([\\d.]+)\\s*([KMGT]?B)\\s*\\((\\d+)个应用\\)",
            @"replacement": @"$1 $2 ($3 ứng dụng)",
    @"options": @(NSRegularExpressionCaseInsensitive)
},
@{
            @"pattern": @"总容量:([^’']+)已用:([^’']+)可用:([^’']+)",
            @"replacement": @"Tổng dung lượng: $1 Sử dụng: $2 Còn lại: $3",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"确定要清理([^’']+)的缓存吗？\n将清理约([^’']+)空间",
            @"replacement": @"Bạn có chắc chắn muốn xoá bộ nhớ đêm của$1không?\nSẽ dọn dẹp$2dung lượng",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"发现([^’']+)可清理空间",
            @"replacement": @"Đã tìm thầy$1dung lượng có thể dọn dẹp",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"成功清理 ([^’']+)",
            @"replacement": @"Dọn dẹp thành công $1",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"还有([^’']+)个应用未显示",
            @"replacement": @"Còn$1ứng dụng chưa hiển thị",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"共找到([^’']+)个第三方应用",
            @"replacement": @"Dã tìm thấy tổng$1ứng dụng của bên thứ ba",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"清理类型:([^’']+)\n清理大小:([^’']+)\n清理时间:([^’']+)",
            @"replacement": @"Loại: $1\nKích thước: $2\nThời gian: $3",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"共([^’']+)条记录，累计清理([^’']+)",
            @"replacement": @"Tổng cộng có$1mục, đã dọn dẹp$2",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"总清理次数([^’']+)次\n\n累计清理空间:([^’']+)\n\n上次清理([^’']+)",
            @"replacement": @"Tổng số lần dọn dẹp: $1lần\n\nTổng dung lượng đã dọn: $2\n\n:Dọn sạch lần cuối: $3",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"已保护([^’']+)个应用",
            @"replacement": @"Đã bảo vệ$1ứng dụng",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"📱 iOSCleanPro 使用帮助",
            @"replacement": @"📱 Hướng dẫn sử dụng iOSCleanPro",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"1. 扫描垃圾文件\n   点击「扫描垃圾文件」按钮，系统会自动扫描可清理的文件。\n\n2. 查看文件详情\n   点击清理卡片可展开查看文件列表。\n\n3. 清理文件\n   点击卡片右侧的「清理」按钮清理对应类型的文件。\n\n4. 一键清理\n   点击「一键清理全部」可清理所有类型的垃圾文件。",
            @"replacement": @"1. Quét tệp tin rác\n Nhấn nút 'Quét tệp tin rác', Hệ thống sẽ tự dộng quét các tệp tin có thể dọn dẹp.\n\n2. Xem chi tiết các tệp tin\n Nhấn vào thẻ ben trái để mở rộng xem danh sách các tệp tin.\n\n3. Dọn dẹp tệp tin\n Nhấn nut 'Dọn' ở bên phải thẻ để dọn dẹp các tệp tin thuộc loại tương ứng.\n\n4. Dọn dẹp một lần\n Nhấn nút 'Dọn dẹp tất cả' để dọn sạch tất cả các loại tệp tin rác.",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"⚠️ 注意事项：\n• Cookie清理会清除网站登录状态\n• 清理操作不可恢复，请谨慎操作\n• 建议定期清理以保持设备性能",
            @"replacement": @"⚠️ Lưu ý quan trọng：\n• Dọn dẹp Cookie sẽ xóa trạng thái đăng nhập của bạn trên các trang web.\n• Thao tác dọn dẹp không thể hoàn tác (khôi phục lại). Hãy cẩn thận.\n• Khuyến nghị dọn dẹp định kỳ để duy trì hiệu suất cho thiết bị.",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"🔒 隐私政策\n\niOSCleanPro 非常重视您的隐私安全。\n\n• 本应用完全在本地运行\n• 不会收集任何用户数据\n• 不会上传任何信息到服务器\n• 不会访问您的个人文件\n• 只会清理应用缓存和临时文件\n\n所有清理操作都在您的设备上完成，确保数据安全。",
            @"replacement": @"🔒 Chính sách bảo mật\n\niOSCleanPro rất coi trọng sự an toàn về quyền riêng tư của bạn.\n\n• Ứng dụng này hoàn toàn chạy cục bộ (offline).\n• Không thu thập bất kỳ dữ liệu người dùng nào.\n• Không tải bất kỳ thông tin nào lên máy chủ.\n• Không truy cập các tệp cá nhân của bạn.\n• Chỉ dọn dẹp bộ nhớ đệm ứng dụng và các tệp tạm thời.\n\nMọi các thao tác dọn dẹp đều được hoàn thành trên thiết bị của bạn, đảm bảo an toàn dữ liệu.",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"版本:([^’']+)(Build 1)",
            @"replacement": @"Phiên bản: $1(Build 1)",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern":@"一个功能强大的iOS清理工具，专为深度清理和系统优化设计。",
            @"replacement": @"Một công cụ dọn dẹp iOS mạnh mẽ, được thiết kế chuyên dành cho việc dọn dẹp sâu và tối ưu hoá hệ thống.",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
@{
            @"pattern": @"开发者: 木木\n创建日期: 2025-10-30\n\n© 2025 木木. All rights reserved.",
            @"replacement": @"Nhà phát triển: Mộc Mộc\nNgày tạp:: 2025-10-30\n\n@ 2025 Mộc Mộc, Đã đăng ký bản quyển.",
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