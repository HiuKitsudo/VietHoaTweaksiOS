// Tweak.xm
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <CoreText/CoreText.h>

static NSDictionary *translationDict = nil;
static NSDictionary<NSString *, NSRegularExpression *> *regexCache = nil;
static NSArray<NSDictionary *> *regexPatterns = nil;

static BOOL isValidString(NSString *string) {
    return string != nil && [string isKindOfClass:[NSString class]] && string.length > 0;
}

static NSString *normalizeString(NSString *str) {
    if (!str) return @"";
    NSString *clean = [str stringByReplacingOccurrencesOfString:@"\u00a0" withString:@" "];
    return [clean stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

static NSString *translateText(NSString *originalText) {
    if (!isValidString(originalText)) return originalText;

    NSString *cleanText = normalizeString(originalText);

    // 1. Dịch bằng NSDictionary
    NSString *translated = translationDict[cleanText];
    if (translated) return translated;

    translated = translationDict[originalText];
    if (translated) return translated;

    // 2. Dịch bằng Regex (xử lý chuỗi động)
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

static void loadTranslations() {
    translationDict = @{
        // --- Chuỗi thao tác & Menu mới ---
        @"保存" : @"Lưu",
        @"重新打包" : @"Đóng gói lại",
        @"重新打包并上传越狱源" : @"Đóng gói lại & tải lên nguồn",
        @"正在重新打包..." : @"Đang đóng gói lại...",
        @"选择要上传的越狱源" : @"Chọn nguồn Jailbreak cần tải lên",
        @"新建文件夹" : @"Tạo thư mục mới",
        @"正在导出项目..." : @"Đang xuất mục...",
        @"正在解压到 Debs..." : @"Đang giải nén vào Debs...",
        @"下载 Deb 文件" : @"Tải xuống tệp Deb",
        @"版本:" : @"Phiên bản:",
        @"版本：" : @"Phiên bản:",
        @"作者:" : @"Tác giả:",
        @"作者：" : @"Tác giả:",
        @"架构:" : @"Kiến trúc:",
        @"架构：" : @"Kiến trúc:",

        // --- Giao diện Quản lý nguồn GitHub ---
        @"关闭" : @"Đóng",
        @"全选" : @"Chọn tất cả",
        @"绑定 GitHub 仓库" : @"Liên kết kho chứa GitHub",
        @"您尚未绑定任何 GitHub 源仓库。" : @"Bạn chưa liên kết kho chứa nguồn GitHub nào.",
        @"点击右上角 '+' 使用 Token 绑定仓库。" : @"Nhấn '+' ở góc trên bên phải để sử dụng Token liên kết kho chứa.",
        @"仓库信息" : @"Thông tin kho chứa",
        @"GitHub 用户名" : @"Tên người dùng GitHub",
        @"仓库名" : @"Tên kho chứa",
        @"例如你的项目是 github.com/iosdumpzzz/repo，则用户名填 iosdumpzzz，仓库名填 repo" : @"Ví dụ dự án của bạn là github.com/iosdumpzzz/repo, nhập tên người dùng là iosdumpzzz, tên kho chứa là repo",
        @"身份验证" : @"Xác thực danh tính",
        @"GitHub Token (PAT)" : @"GitHub Token (PAT)",
        @"前往 GitHub 网页端 -> Settings -> Developer settings -> Personal access tokens (classic) 生成一个勾选了 'repo' 权限的 Token 粘贴在此处。" : @"Truy cập GitHub web -> Settings -> Developer settings -> Personal access tokens (classic) để tạo Token có quyền 'repo' rồi dán vào đây.",
        @"保存并绑定" : @"Lưu và liên kết",

        // --- Thông báo & Cảnh báo dài ---
        @"即将重新打包并上传至越狱源，确认继续?" : @"Sắp đóng gói lại và tải lên nguồn Jailbreak, xác nhận tiếp tục?",
        @"即将重新打包并上传至越狱源，确认\n继续?" : @"Sắp đóng gói lại và tải lên nguồn Jailbreak, xác nhận tiếp tục?",
        @"即将重新打包并上传至越狱源, 确认\n继续?" : @"Sắp đóng gói lại và tải lên nguồn Jailbreak, xác nhận tiếp tục?",
        @"即将重新打包并上传至越狱源, 确认继续?" : @"Sắp đóng gói lại và tải lên nguồn Jailbreak, xác nhận tiếp tục?",
        @"还未绑定任何 GitHub 仓库，先在源页面的“我的越狱源”中进行绑定配置。" : @"Chưa liên kết kho chứa GitHub nào, vui lòng liên kết trong \"Nguồn Jailbreak của tôi\" ở trang nguồn trước.",
        @"还未绑定任何 GitHub 仓库, 先在源页面的\n“我的越狱源”中进行绑定配置。" : @"Chưa liên kết kho chứa GitHub nào, vui lòng liên kết trong \"Nguồn Jailbreak của tôi\" ở trang nguồn trước.",
        @"还未绑定任何 GitHub 仓库, 先在源页面的“我的越狱源”中进行绑定配置。" : @"Chưa liên kết kho chứa GitHub nào, vui lòng liên kết trong \"Nguồn Jailbreak của tôi\" ở trang nguồn trước.",

        // --- Hệ thống & Cài đặt ---
        @"还没有文件。" : @"Chưa có tệp nào.",
        @"请从“管理文件”页面解压一个 Deb 文件。" : @"Vui lòng giải nén tệp Deb từ trang \"Quản lý tệp\".",
        @"请从\"管理文件\"页面解压一个 Deb 文件。" : @"Vui lòng giải nén tệp Deb từ trang \"Quản lý tệp\".",
        @"通用设置" : @"Cài đặt chung",
        @"启动时自动刷新越狱源" : @"Tự động làm mới nguồn khi k.động",
        @"开启后，每次启动打开应用时将自动在后台刷新所有越狱源。" : @"Khi bật, tất cả các nguồn jailbreak sẽ tự động được làm mới trong nền mỗi khi mở ứng dụng.",        
        @"下载设置" : @"Cài đặt tải xuống",
        @"默认 (debs目录)" : @"Mặc định (Thư mục debs)",
        @"自定义目录" : @"Tuỳ chỉnh thư mục",
        @"以插件名称命名下载文件" : @"Đặt tên tệp tải xuống theo tên tweak",
        @"开启后，下载的.deb 文件将自动重命名为“插件名-版本号.deb”，方便识别。关闭则保留原始文件名。" : @"Khi bật, tệp .deb được tải xuống sẽ tự động đổi tên thành \"TênTweak-PhiênBản.deb\" để dễ nhận biết. Khi tắt sẽ giữ nguyên tên tệp gốc.",        
        @"开启后，下载的.deb 文件将自动重命名为\n“插件名-版本号.deb”，方便识别。关闭则保留原始文件名。" : @"Khi bật, tệp .deb được tải xuống sẽ tự động đổi tên thành \"TênTweak-PhiênBản.deb\" để dễ nhận biết. Khi tắt sẽ giữ nguyên tên tệp gốc.",
        @"开启后，下载的.deb 文件将自动重命名为 “插件名-版本号.deb”，方便识别。关闭则保留原始文件名。" : @"Khi bật, tệp .deb được tải xuống sẽ tự động đổi tên thành \"TênTweak-PhiênBản.deb\" để dễ nhận biết. Khi tắt sẽ giữ nguyên tên tệp gốc.",
        @"上传越狱源设置" : @"Cài đặt tải lên nguồn Jailbreak",
        @"上传目录" : @"Thư mục tải lên",
        @"配置全局快捷上传越狱源时的目标文件夹。留空为根目录。" : @"Cấu hình thư mục đích khi tải lên nguồn jailbreak qua phím tắt toàn cục. Để trống nếu muốn chọn thư mục gốc.",        
        @"关于" : @"Giới thiệu",
        @"作者" : @"Tác giả",
        @"版本号" : @"Phiên bản",
        @"完成" : @"Xong",
        @"Sileo 显示名称" : @"Tên hiển thị Sileo",
        @"Sileo显示名称" : @"Tên hiển thị Sileo",
        @"无根：前缀 /var/jb，注入目录 /usr/lib/TweakInject\n(ElleKit) 。" : @"Rootless: Tiền tố /var/jb, thư mục inject /usr/lib/TweakInject\n(ElleKit).",
        @"无根：前缀 /var/jb，注入目录 /usr/lib/TweakInject (ElleKit) 。" : @"Rootless: Tiền tố /var/jb, thư mục inject /usr/lib/TweakInject (ElleKit).",
        @"无根：前缀 /var/jb，注入目录 /usr/lib/TweakInject\n(ElleKit)。" : @"Rootless: Tiền tố /var/jb, thư mục inject /usr/lib/TweakInject\n(ElleKit).",
        @"无根：前缀 /var/jb，注入目录 /usr/lib/TweakInject (ElleKit)。" : @"Rootless: Tiền tố /var/jb, thư mục inject /usr/lib/TweakInject (ElleKit).",
        @"选择一种添加方式。" : @"Chọn một phương thức thêm.",
        @"管理我的源" : @"Quản lý nguồn của tôi",
        @"无更新记录" : @"Không có lịch sử cập nhật",
        @"刷新源后，新增或更新的插件将显示在此处。" : @"Sau khi làm mới nguồn, các tweak mới hoặc bản cập nhật sẽ hiển thị tại đây.",
        @"列表为空" : @"Danh sách trống",
        @"搜索所有源中的插件" : @"Tìm kiếm tất cả",
        @"越狱源" : @"Nguồn Jailbreak",
        @"取消" : @"Hủy",
        @"搜索插件" : @"Tìm kiếm tweak",
        @"手动输入" : @"Nhập thủ công",
        @"从剪贴板粘贴" : @"Dán từ bộ nhớ tạm",
        @"添加越狱源" : @"Thêm nguồn",
        @"您可以输入单个或多个URL，用逗号或换行分隔。" : @"Bạn có thể nhập một hoặc nhiều URL, phân tách bằng dấu phẩy hoặc xuống dòng.",
        @"按名称 (A-Z)" : @"Theo tên (A-Z)",
        @"版本号 (从小到大)" : @"Phiên bản (Thấp đến cao)",
        @"版本号 (从大到小)" : @"Phiên bản (Cao đến thấp)",
        @"全部" : @"Tất cả",
        @"返回" : @"Q.lại",
        @"添加" : @"Thêm",
        @"Debs 项目" : @"Mục Debs",
        @"搜索项目" : @"Tìm kiếm",
        @"好的" : @"OK",
        @"打包Deb" : @"Đóng gói Deb",
        @"Deb 打包" : @"Đóng gói Deb",
        @"插件元数据" : @"Meta Data của Tweak",
        @"包名 (com.example.tweak)" : @"Mã gói (com.example.tweak)",
        @"版本" : @"Phiên bản",
        @"描述" : @"Mô tả",
        @"维护者 (可选)" : @"Nhà phát triển (Không bắt buộc)",
        @"打包方案" : @"Phương thức đóng gói",
        @"隐根：前缀 /var/jb，注入目录 /usr/lib/TweakInject。" : @"Roothide: Tiền tố /var/jb, thư mục inject /usr/lib/TweakInject.",
        @"有根：前缀 /，注入目录 /Library/MobileSubstrate/DynamicLibraries。" : @"Rootful: Tiền tố /, thư mục inject /Library/MobileSubstrate/DynamicLibraries.",
        @"导入的 DYLIB 及注入目标" : @"Tệp Dylib đã nhập & Mục tiêu Inject",
        @"添加 .dylib 文件" : @"Thêm tệp .dylib",
        @"请先导入 Dylib" : @"Vui lòng nhập Dylib trước",
        @"有根 (arm)" : @"Rootful (arm)",
        @"无根 (arm64)" : @"Rootless (arm64)",
        @"隐根 (arm64e)" : @"Roothide (arm64e)",
        @"下载完成" : @"Tải xuống hoàn tất",
        @"解压 Deb" : @"Giải nén tệp Deb",
        @"提取动态库" : @"Trích xuất Dylib",
        @"导入到下载列表" : @"Nhập vào danh sách tải xuống",
        @"管理文件" : @"Quản lý tệp",
        @"搜索文件" : @"Tìm kiếm tệp",
        @"删除" : @"Xóa",
        @"分享" : @"Chia sẻ",
        @"确认清理？" : @"Xác nhận dọn dẹp?",
        @"此操作将删除应用部分缓存文件。" : @"Thao tác này sẽ xóa một số tệp bộ nhớ đệm của ứng dụng.",
        @"确认" : @"Xác nhận",
        @"确定删除" : @"Xác nhận xóa",
        @"设置" : @"Cài đặt",
        @"确定删除吗？" : @"Bạn có chắc chắn muốn xóa không?",
        @"选择要导出的文件" : @"Chọn tệp cần xuất",
        @"搜索文件或文件夹" : @"Tìm kiếm tệp hoặc thư mục",
        @"刷新" : @"Làm mới",
        @"复制" : @"Sao chép",
        @"提取框架或动态库" : @"Trích xuất Framework hoặc Dylib",
        @"提取框架与动态库" : @"Trích xuất Framework và Dylib",
        @"清理完成" : @"Hoàn tất dọn dẹp",
        @"临时文件已全部被清理。" : @"Tất cả các tệp tạm thời đã được dọn dẹp.",
        @"提示" : @"Gợi ý",
        @"重新打包Deb？" : @"Đóng gói lại tệp Deb?",
        @"继续打包" : @"Tiếp tục đóng gói",
        @"请选择一种添加方式。" : @"Vui lòng chọn phương thức thêm nguồn.",
        @"导入到管理文件列表" : @"Nhập vào danh sách quản lý tệp",
        @"上传越狱源" : @"Tải lên nguồn Jailbreak",
        @"导入文件" : @"Nhập tập tin",
        @"批量编辑" : @"Chỉnh sửa hàng loạt",
        @"清理缓存" : @"Xóa bộ nhớ đệm",
        @"Debs Folder" : @"Thư mục Debs",
        @"新闻" : @"Tin tức",
        @"我的越狱源" : @"Nguồn Jailbreak của tôi",
        @"编辑源列表" : @"Chỉnh sửa danh sách nguồn",
        @"分享全部源" : @"Chia sẻ tất cả nguồn",
    };

    regexPatterns = @[
        // --- REGEX MỚI: Bắt cụm Giá trị Động (Phiên bản, Tác giả, Kiến trúc) ---
        @{
            @"pattern": @"^版本[:：]\\s*(.*)$",
            @"replacement": @"Phiên bản: $1",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
        @{
            @"pattern": @"^作者[:：]\\s*(.*)$",
            @"replacement": @"Tác giả: $1",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
        @{
            @"pattern": @"^架构[:：]\\s*(.*)$",
            @"replacement": @"Kiến trúc: $1",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },

        // --- Các REGEX động đã tối ưu ---
        @{
            @"pattern": @"确定要删除项目\\s*[“\"]([^”\"]+)[”\"]\\s*吗[？?]\\s*此操作不可撤销[。.]",
            @"replacement": @"Bạn có chắc chắn muốn xóa mục \"$1\" không? Thao tác này không thể hoàn tác.",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
        @{
            @"pattern": @"即将重新打包并上传至越狱源[，,]\\s*确认\\s*继续[？?]",
            @"replacement": @"Sắp đóng gói lại và tải lên nguồn Jailbreak, xác nhận tiếp tục?",
            @"options": @(NSRegularExpressionDotMatchesLineSeparators | NSRegularExpressionCaseInsensitive)
        },
        @{
            @"pattern": @"还未绑定任何\\s*GitHub\\s*仓库[，,]\\s*先在源页面的\\s*[“\"]我的越狱源[”\"]\\s*中进行绑定配置[。.]",
            @"replacement": @"Chưa liên kết kho chứa GitHub nào, vui lòng liên kết trong \"Nguồn Jailbreak của tôi\" ở trang nguồn trước.",
            @"options": @(NSRegularExpressionDotMatchesLineSeparators | NSRegularExpressionCaseInsensitive)
        },
        @{
            @"pattern": @"开启后[，,]\\s*下载的\\.deb\\s*文件将自动重命名为.*方便识别[。.]\\s*关闭则保留原始文件名[。.]",
            @"replacement": @"Khi bật, tệp .deb được tải xuống sẽ tự động đổi tên thành \"TênTweak-PhiênBản.deb\" để dễ nhận biết. Khi tắt sẽ giữ nguyên tên tệp gốc.",
            @"options": @(NSRegularExpressionDotMatchesLineSeparators | NSRegularExpressionCaseInsensitive)
        },
        @{
            @"pattern": @"^版本号?\\s*([0-9]+\\.[0-9]+(?:\\.[0-9]+)?)$",
            @"replacement": @"Phiên bản $1",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
        @{
            @"pattern": @"无根[:：]\\s*前缀\\s*/var/jb[，,]\\s*注入目录\\s*/usr/lib/TweakInject\\s*\\(?ElleKit\\)?\\s*。",
            @"replacement": @"Rootless: Tiền tố /var/jb, thư mục inject /usr/lib/TweakInject (ElleKit).",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
        @{
            @"pattern": @"([^’']+) 已保存到“管理文件”页面。",
            @"replacement": @"Đã lưu $1 vào Quản lý tệp",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
        @{
            @"pattern": @"确定要删除选中的 ([^’']+) 个文件吗？此操作不可撤销。",
            @"replacement": @"Bạn có chắc chắn muốn xóa $1 tập tin đã chọn không? Hành động này không thể thay đổi được",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
        @{
            @"pattern": @"您确定要删除项目 “([^’']+)” 吗？此操作不可撤销。",
            @"replacement": @"Bạn có chắc chắn muốn xóa $1 không? Không thể hoàn tác hành động này.",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
        @{
            @"pattern": @"您确定要删除选中的 ([^’']+) 个越狱源吗？此操作不可撤销。",
            @"replacement": @"Bạn có chắc chắn muốn xóa $1 nguồn jailbreak đã chọn không? Hành động này không thể thay đổi được",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
        @{
            @"pattern": @"您确定要删除选中的 ([^’']+) 个项目吗？此操作不可撤销。",
            @"replacement": @"Bạn có chắc chắn muốn xóa $1 mục đã chọn không? Không thể hoàn tác hành động này.",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
        @{
            @"pattern": @"您确定要删除越狱源 “([^’']+)” 吗？此操作不可撤销。",
            @"replacement": @"Bạn có chắc chắn muốn xóa nguồn jailbreak $1 không? Không thể hoàn tác hành động này.",
            @"options": @(NSRegularExpressionCaseInsensitive)
        },
    ];

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
        }
    }

    regexCache = [tempRegexCache copy];
}

%hook UILabel
- (void)setText:(NSString *)text {
    %orig(isValidString(text) ? translateText(text) : text);
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

%hook UITextView
- (void)setText:(NSString *)text {
    %orig(isValidString(text) ? translateText(text) : text);
}
%end

%hook UIButton
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    %orig(isValidString(title) ? translateText(title) : title, state);
}
%end

%hook UIAlertController
- (void)setTitle:(NSString *)title {
    %orig(isValidString(title) ? translateText(title) : title);
}
- (void)setMessage:(NSString *)message {
    %orig(isValidString(message) ? translateText(message) : message);
}
%end

%hook UINavigationItem
- (void)setTitle:(NSString *)title {
    %orig(isValidString(title) ? translateText(title) : title);
}
%end

%hook UITextField
- (void)setPlaceholder:(NSString *)placeholder {
    %orig(isValidString(placeholder) ? translateText(placeholder) : placeholder);
}
%end

%hook UIApplication
- (NSString *)displayName {
    NSString *originalName = %orig;
    return isValidString(originalName) ? translateText(originalName) : originalName;
}
%end

%hook NSBundle
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    NSString *origString = %orig;
    if (isValidString(origString)) {
        NSString *translated = translateText(origString);
        if (translated && ![translated isEqualToString:origString]) {
            return translated;
        }
    }
    if (isValidString(key)) {
        NSString *translatedKey = translateText(key);
        if (translatedKey && ![translatedKey isEqualToString:key]) {
            return translatedKey;
        }
    }
    return origString;
}
%end

%hookf(CTLineRef, CTLineCreateWithAttributedString, CFAttributedStringRef attrString) {
    if (!attrString) return %orig(attrString);
    
    NSString *string = [(__bridge NSAttributedString *)attrString string];
    if (isValidString(string)) {
        NSString *translated = translateText(string);
        if (translated && ![translated isEqualToString:string]) {
            NSMutableAttributedString *mutableAttr = [(__bridge NSAttributedString *)attrString mutableCopy];
            [mutableAttr replaceCharactersInRange:NSMakeRange(0, mutableAttr.length) withString:translated];
            return %orig((__bridge CFAttributedStringRef)mutableAttr);
        }
    }
    return %orig(attrString);
}

%ctor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            loadTranslations();
            if (@available(iOS 14.0, *)) {
                %init;
            }
        }
    });
}
