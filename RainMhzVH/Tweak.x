#import <UIKit/UIKit.h>

static inline NSDictionary<NSString *, NSString *> *getStaticDict() {
    static NSDictionary<NSString *, NSString *> *dict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dict = @{
            @"Rain的Mhz" : @"Rain Mhz",
            @"Rain Mhz" : @"Rain Mhz",
            @"性能与调频" : @"Hiệu năng & Tần số",
            @"智能调频" : @"Điều xung thông minh",
            @"常用" : @"Thường dùng",
            @"功能与工具" : @"Tính năng & Công cụ",
            @"监控与跑分" : @"Giám sát & Chấm điểm",
            @"使用说明" : @"Hướng dẫn sử dụng",
            @"高级设置" : @"Cài đặt nâng cao",
            @"全局设置" : @"Cài đặt toàn cục",
            @"撤销" : @"Hoàn tác",
            @"全部" : @"Tất cả",
            @"已更新：" : @"Đã cập nhật: ",
            @"搜索设置" : @"Tìm kiếm cài đặt",
            @"APPLICATIONS" : @"ỨNG DỤNG",
            @"自定义" : @"Tùy chỉnh",
            @"手动调节" : @"Điều chỉnh thủ công",
            @"省电" : @"Tiết kiệm pin",
            @"低发热" : @"Ít tỏa nhiệt",
            @"日常" : @"Thường ngày",
            @"均衡" : @"Cân bằng",
            @"智能平衡" : @"Cân bằng thông minh",
            @"游戏" : @"Chơi game",
            @"性能释放" : @"Giải phóng hiệu năng",
            @"稳帧" : @"Ổn định khung hình",
            @"稳定帧率优先" : @"Ưu tiên ổn định tốc độ khung hình",
            @"帧时优先" : @"Ưu tiên frametime",
            @"跑分" : @"Chấm điểm",
            @"短时极限" : @"Cực hạn ngắn hạn",
            @"极限性能" : @"Hiệu năng tối đa",
            @"精细" : @"Tinh chỉnh chi tiết",
            @"未测试" : @"Chưa kiểm tra",
            @"已显示全部实验选项" : @"Đã hiển thị tất cả tùy chọn thử nghiệm",
            @"已显示精细调节" : @"Đã hiển thị tinh chỉnh chi tiết",
            @"仅显示常用设置" : @"Chỉ hiển thị cài đặt thường dùng",
            @"未充电" : @"Chưa sạc pin",
            @"应用此模式" : @"Áp dụng chế độ này",
            @"关闭" : @"Đóng",
            @"好的" : @"OK",
            @"再跑一次" : @"Chấm điểm lại",
            @"保留手动选择，适合熟悉各项参数的用户。" : @"Giữ lựa chọn thủ công, phù hợp với người dùng đã hiểu rõ các thông số.",
            @"由负载和温度智能调节，适合大多数日常使用。" : @"Tự động điều chỉnh theo mức tải và nhiệt độ, phù hợp phần lớn nhu cầu thường ngày.",
            @"优先减少帧时波动，适合长时间运行游戏。" : @"Ưu tiên giảm dao động frametime, phù hợp chơi game trong thời gian dài.",
            @"短时间释放较高性能，功耗和温度可能明显增加。" : @"Giải phóng hiệu năng cao trong thời gian ngắn, mức tiêu thụ pin và nhiệt độ có thể tăng rõ rệt.",
            @"降低性能请求并优先控制温度，适合阅读、聊天和待机。" : @"Giảm yêu cầu hiệu năng và ưu tiên kiểm soát nhiệt độ, phù hợp đọc sách, nhắn tin và chờ.",
            @"提高前台应用、GPU 与触控响应，仍保留温度保护。" : @"Tăng phản hồi ứng dụng tiền cảnh, GPU và cảm ứng, vẫn giữ bảo vệ nhiệt độ.",
            @"跑分结果" : @"Kết quả chấm điểm",
            @"进阶跑分 2.0" : @"Chấm điểm nâng cao 2.0",
            @"进阶跑分 2.0 结果" : @"Kết quả chấm điểm nâng cao 2.0",
            @"雷达图:" : @"Biểu đồ radar:",
            @"散热评估中.." : @"Đang đánh giá tản nhiệt...",
            @"再测一次" : @"Kiểm tra lại lần nữa",
            @"散热评估结果" : @"Kết quả đánh giá tản nhiệt",
            @"开始测试" : @"Bắt đầu kiểm tra",
            @"将进行 10 秒满载压力测试，CPU 会全速运行并产生热量。\n确定开始？" : @"Sẽ tiến hành kiểm tra áp lực tải tối đa trong 10 giây, CPU sẽ chạy hết công suất và sinh nhiệt.\nBạn có chắc chắn muốn bắt đầu?",
            @"散热评估" : @"Đánh giá khả năng tản nhiệt",
            @"切换 CPU 模式后重新跑分可对比性能差异" : @"Đổi chế độ CPU rồi chấm điểm lại để so sánh sự khác biệt hiệu năng",
            @"运行状态" : @"Trạng thái chạy",
            @"已启用" : @"Đã bật",
            @"未启用" : @"Chưa bật",
            @"等待策略裁决" : @"Đang chờ quyết định chính sách",
            @"等待频率反馈" : @"Đang chờ phản hồi tần số",
            @"实时温度" : @"Nhiệt độ hiện tại",
            @"温度" : @"Nhiệt độ",
            @"内存" : @"Bộ nhớ RAM",
            @"CPU" : @"CPU",
            @"智能自适应" : @"Tự thích ứng thông minh",
            @"常用游戏快捷添加" : @"Thêm nhanh game thường dùng",
            @"暂无配置" : @"Chưa có cấu hình",
            @"已配置的应用" : @"Ứng dụng đã cấu hình",
            @"应用级智能调频" : @"Điều xung thông minh theo ứng dụng",
            @"启动加速应用" : @"Ứng dụng tăng tốc khởi động"
        };
    });
    return dict;
}

static inline NSString *translateString(NSString *origText) {
    if (!origText || origText.length == 0) return origText;

    if ([origText containsString:@"省电：降低性能请求"] || [origText containsString:@"智能调频，适合普通使用"] || [origText containsString:@"短时间启用高性能策略"]) {
        return @"Tiết kiệm pin: Giảm hiệu năng yêu cầu và bật kiểm soát nhiệt.\nThường ngày: Tự điều xung nhịp, phù hợp nhu cầu cơ bản.\nChơi game: Tăng ưu tiên CPU, GPU và ứng dụng tiền cảnh.\nỔn định khung hình: Ưu tiên ổn định frametime, giữ giới hạn nhiệt an toàn.\nChấm điểm: Kích hoạt cấu hình hiệu năng cao trong thời gian ngắn.";
    }

    if ([origText containsString:@"游戏模式不生效"] || [origText containsString:@"模式自动变化"] || [origText containsString:@"重置所有设置"]) {
        return @"Chế độ game không có tác dụng: Đảm bảo công tắc tổng và Chế độ game đã bật, hoặc thêm thủ công trong Cấu hình ứng dụng.\n\nChế độ tự động đổi: Trang chủ mục \"Lý do kích hoạt\" sẽ hiển thị do nhiệt độ, tăng tốc khởi động, sạc pin, cấu hình ứng dụng hay ngữ cảnh game.\n\nĐổi cài đặt không có tác dụng: Thử tắt rồi bật lại tweak, nếu cần hãy Respring (注销 SpringBoard).\n\nCần khôi phục mặc định: Quay lại Cài đặt nâng cao, nhấn \"Đặt lại tất cả cài đặt\".";
    }

    NSString *trimmed = [origText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSDictionary *dict = getStaticDict();
    
    if (dict[origText]) return dict[origText];
    if (dict[trimmed]) {
        return [origText stringByReplacingOccurrencesOfString:trimmed withString:dict[trimmed]];
    }

    NSString *processed = origText;

    if ([processed containsString:@"模式切换"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"模式切换" withString:@"Đổi chế độ"];
    }
    if ([processed containsString:@"当前模式:"] || [processed containsString:@"当前模式："]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"当前模式:" withString:@"Chế độ hiện tại: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"当前模式：" withString:@"Chế độ hiện tại: "];
    }
    if ([processed containsString:@"充电极速"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"充电极速" withString:@"Sạc tăng tốc"];
    }
    if ([processed containsString:@"极限性能"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"极限性能" withString:@"Hiệu năng tối đa"];
    }

    if ([processed containsString:@"多核并行测试"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"多核并行测试" withString:@"Kiểm tra đa nhân song song"];
    }
    if ([processed containsString:@"持续负载"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"持续负载" withString:@"Mức tải duy trì"];
    }

    if ([processed containsString:@"综合总分:"] || [processed containsString:@"综合总分："] || [processed containsString:@"综合:"] || [processed containsString:@"综合："]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"综合总分:" withString:@"Tổng điểm tổng hợp: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"综合总分：" withString:@"Tổng điểm tổng hợp: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"综合:" withString:@"Tổng hợp: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"综合：" withString:@"Tổng hợp: "];
    }
    if ([processed containsString:@"总分:"] || [processed containsString:@"总分："]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"总分:" withString:@"Tổng điểm: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"总分：" withString:@"Tổng điểm: "];
    }
    if ([processed containsString:@"单核性能:"] || [processed containsString:@"单核性能："] || [processed containsString:@"单核:"] || [processed containsString:@"单核："]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"单核性能:" withString:@"Hiệu năng đơn nhân: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"单核性能：" withString:@"Hiệu năng đơn nhân: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"单核:" withString:@"Đơn nhân: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"单核：" withString:@"Đơn nhân: "];
    }
    if ([processed containsString:@"多核性能:"] || [processed containsString:@"多核性能："] || [processed containsString:@"多核:"] || [processed containsString:@"多核："]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"多核性能:" withString:@"Hiệu năng đa nhân: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"多核性能：" withString:@"Hiệu năng đa nhân: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"多核:" withString:@"Đa nhân: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"多核：" withString:@"Đa nhân: "];
    }
    if ([processed containsString:@"核)"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"核)" withString:@" nhân)"];
    }
    if ([processed containsString:@"整数运算:"] || [processed containsString:@"整数运算："]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"整数运算:" withString:@"Tính toán số nguyên: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"整数运算：" withString:@"Tính toán số nguyên: "];
    }
    if ([processed containsString:@"浮点运算:"] || [processed containsString:@"浮点运算："]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"浮点运算:" withString:@"Tính toán dấu phẩy động: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"浮点运算：" withString:@"Tính toán dấu phẩy động: "];
    }
    if ([processed containsString:@"内存带宽:"] || [processed containsString:@"内存带宽："]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"内存带宽:" withString:@"Băng thông bộ nhớ: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"内存带宽：" withString:@"Băng thông bộ nhớ: "];
    }
    if ([processed containsString:@"存储:"] || [processed containsString:@"存储："]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"存储:" withString:@"Bộ nhớ lưu trữ: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"存储：" withString:@"Bộ nhớ lưu trữ: "];
    }
    if ([processed containsString:@"稳定性:"] || [processed containsString:@"稳定性："]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"稳定性:" withString:@"Độ ổn định: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"稳定性：" withString:@"Độ ổn định: "];
    }
    if ([processed containsString:@"降频幅度:"] || [processed containsString:@"降频幅度："]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"降频幅度:" withString:@"Mức độ hạ xung: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"降频幅度：" withString:@"Mức độ hạ xung: "];
    }

    if ([processed containsString:@"频率反馈不可用"] || [processed containsString:@"当前为估算"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"频率反馈不可用" withString:@"Phản hồi tần số không khả dụng"];
        processed = [processed stringByReplacingOccurrencesOfString:@"当前为估算" withString:@"Hiện đang ước tính"];
    }
    if ([processed containsString:@"物理"] || [processed containsString:@"逻辑"] || [processed containsString:@"活跃"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"物理" withString:@"Vật lý"];
        processed = [processed stringByReplacingOccurrencesOfString:@"逻辑" withString:@"Logic"];
        processed = [processed stringByReplacingOccurrencesOfString:@"活跃" withString:@"Hoạt động"];
    }

    if ([processed containsString:@"正常"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"正常" withString:@"Bình thường"];
    }
    if ([processed containsString:@"发热"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"发热" withString:@"Nóng máy"];
    }
    if ([processed containsString:@"过热"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"过热" withString:@"Quá nhiệt"];
    }

    if ([processed containsString:@"已应用："] || [processed containsString:@"已应用:"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"已应用：" withString:@"Đã áp dụng: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"已应用:" withString:@"Đã áp dụng: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"省电" withString:@"Tiết kiệm pin"];
        processed = [processed stringByReplacingOccurrencesOfString:@"日常" withString:@"Thường ngày"];
        processed = [processed stringByReplacingOccurrencesOfString:@"均衡" withString:@"Cân bằng"];
        processed = [processed stringByReplacingOccurrencesOfString:@"游戏" withString:@"Chơi game"];
        processed = [processed stringByReplacingOccurrencesOfString:@"稳帧" withString:@"Ổn định khung hình"];
        processed = [processed stringByReplacingOccurrencesOfString:@"跑分" withString:@"Chấm điểm"];
        processed = [processed stringByReplacingOccurrencesOfString:@"自定义" withString:@"Tùy chỉnh"];
        processed = [processed stringByReplacingOccurrencesOfString:@"极限性能" withString:@"Hiệu năng tối đa"];
        return processed;
    }

    if ([processed containsString:@"多耗电"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"多耗电" withString:@"Tốn thêm pin "];
    }
    if ([processed containsString:@"省电"] && [processed containsString:@"%"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"省电" withString:@"Tiết kiệm "];
    }

    if ([processed containsString:@"等待 SpringBoard 状态"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"等待 SpringBoard 状态" withString:@"Đang chờ trạng thái SpringBoard"];
    } else if ([processed hasPrefix:@"等待"] && [processed hasSuffix:@"状态"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"等待" withString:@"Đang chờ "];
        processed = [processed stringByReplacingOccurrencesOfString:@"状态" withString:@" trạng thái"];
    }

    if ([processed hasPrefix:@"已更新："] || [processed hasPrefix:@"已更新:"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"已更新：" withString:@"Đã cập nhật: "];
        processed = [processed stringByReplacingOccurrencesOfString:@"已更新:" withString:@"Đã cập nhật: "];
    }
    if ([processed hasPrefix:@"温度"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"温度" withString:@"Nhiệt độ"];
    }
    if ([processed hasPrefix:@"内存"]) {
        processed = [processed stringByReplacingOccurrencesOfString:@"内存" withString:@"Bộ nhớ RAM"];
    }

    return processed;
}

%hook UILabel

- (void)setText:(NSString *)text {
    %orig(translateString(text));
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    if (!attributedText || attributedText.string.length == 0) {
        %orig(attributedText);
        return;
    }
    NSString *translated = translateString(attributedText.string);
    if (![translated isEqualToString:attributedText.string]) {
        NSMutableAttributedString *mAttr = [attributedText mutableCopy];
        [mAttr.mutableString setString:translated];
        %orig(mAttr);
    } else {
        %orig(attributedText);
    }
}

%end

%hook _UITableViewHeaderFooterViewLabel
- (void)setText:(NSString *)text {
    %orig(translateString(text));
}
%end

%hook UITableViewHeaderFooterView
- (void)setText:(NSString *)text {
    %orig(translateString(text));
}
%end

%hook UITextView

- (void)setText:(NSString *)text {
    %orig(translateString(text));
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    if (!attributedText || attributedText.string.length == 0) {
        %orig(attributedText);
        return;
    }
    NSString *translated = translateString(attributedText.string);
    if (![translated isEqualToString:attributedText.string]) {
        NSMutableAttributedString *mAttr = [attributedText mutableCopy];
        [mAttr.mutableString setString:translated];
        %orig(mAttr);
    } else {
        %orig(attributedText);
    }
}

%end

%hook UIButton

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    %orig(translateString(title), state);
}

%end

%hook UINavigationItem
- (void)setTitle:(NSString *)title {
    %orig(translateString(title));
}
%end

%hook UIViewController
- (void)setTitle:(NSString *)title {
    %orig(translateString(title));
}
%end

%hook UITextField
- (void)setPlaceholder:(NSString *)placeholder {
    %orig(translateString(placeholder));
}
- (void)setText:(NSString *)text {
    %orig(translateString(text));
}
%end

%hook UISearchBar
- (void)setPlaceholder:(NSString *)placeholder {
    %orig(translateString(placeholder));
}
- (void)setText:(NSString *)text {
    %orig(translateString(text));
}
%end
