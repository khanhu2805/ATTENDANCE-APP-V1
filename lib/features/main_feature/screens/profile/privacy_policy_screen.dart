
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  final String termsAndConditionsText = """
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NT ("chúng tôi") cam kết bảo vệ quyền riêng tư của bạn khi bạn sử dụng Ứng dụng Nhận diện NT ("Ứng dụng"). Chính sách Bảo mật này giải thích cách chúng tôi thu thập, sử dụng, chia sẻ và bảo vệ thông tin của bạn.

## 1. Thông tin chúng tôi thu thập

* **Thông tin bạn cung cấp:** Khi bạn đăng ký tài khoản hoặc sử dụng Ứng dụng, chúng tôi có thể thu thập các thông tin cá nhân như:
    * Tên
    * Địa chỉ email
    * Số điện thoại
    * Hình ảnh khuôn mặt (khi bạn sử dụng tính năng nhận diện khuôn mặt)
* **Thông tin sử dụng:** Chúng tôi thu thập thông tin về cách bạn sử dụng Ứng dụng, bao gồm:
    * Các tính năng bạn sử dụng
    * Tần suất bạn sử dụng Ứng dụng
    * Thời gian bạn sử dụng Ứng dụng
    * Các loại thiết bị bạn sử dụng
* **Thông tin thiết bị:** Chúng tôi có thể thu thập thông tin về thiết bị của bạn, bao gồm:
    * Loại thiết bị
    * Hệ điều hành
    * Thông tin định danh thiết bị duy nhất
    * Địa chỉ IP

## 2. Cách chúng tôi sử dụng thông tin của bạn

Chúng tôi sử dụng thông tin của bạn cho các mục đích sau:

* **Cung cấp và cải thiện Ứng dụng:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Chúng tôi sử dụng thông tin của bạn để cung cấp, duy trì, cá nhân hóa và cải thiện Ứng dụng, cũng như để phát triển các tính năng và dịch vụ mới.
* **Liên lạc với bạn:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Chúng tôi có thể sử dụng thông tin của bạn để liên hệ với bạn về các bản cập nhật, thông báo và các thông tin khác liên quan đến Ứng dụng.
* **Nghiên cứu và phân tích:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Chúng tôi có thể sử dụng thông tin của bạn cho các mục đích nghiên cứu và phân tích để hiểu rõ hơn về cách người dùng sử dụng Ứng dụng và cải thiện trải nghiệm người dùng.
* **Tuân thủ pháp luật:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Chúng tôi có thể sử dụng và tiết lộ thông tin của bạn nếu cần thiết để tuân thủ các nghĩa vụ pháp lý, giải quyết tranh chấp và thực thi các thỏa thuận của chúng tôi.

## 3. Chia sẻ thông tin của bạn

Chúng tôi có thể chia sẻ thông tin của bạn với:

* **Các nhà cung cấp dịch vụ:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Chúng tôi có thể chia sẻ thông tin của bạn với các nhà cung cấp dịch vụ bên thứ ba, những người hỗ trợ chúng tôi trong việc cung cấp và cải thiện Ứng dụng.
* **Các cơ quan thực thi pháp luật:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Chúng tôi có thể tiết lộ thông tin của bạn cho các cơ quan thực thi pháp luật nếu chúng tôi tin rằng việc tiết lộ đó là cần thiết để tuân thủ luật pháp, bảo vệ quyền lợi của chúng tôi hoặc an toàn của người khác.

## 4. Bảo vệ thông tin của bạn

\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Chúng tôi thực hiện các biện pháp bảo mật hợp lý để bảo vệ thông tin của bạn khỏi bị truy cập, sử dụng hoặc tiết lộ trái phép. Tuy nhiên, không có phương pháp truyền tải hoặc lưu trữ nào là hoàn toàn an toàn.

## 5. Quyền của bạn

Bạn có các quyền sau đối với thông tin của mình:

* **Truy cập và chỉnh sửa:** Bạn có quyền truy cập và chỉnh sửa thông tin cá nhân của mình.
* **Xóa:** Bạn có quyền yêu cầu chúng tôi xóa thông tin cá nhân của bạn.
* **Phản đối:** Bạn có quyền phản đối việc xử lý thông tin cá nhân của bạn.

## 6. Thay đổi đối với Chính sách Bảo mật này

\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Chúng tôi có thể cập nhật Chính sách Bảo mật này theo thời gian. Chúng tôi sẽ thông báo cho bạn về bất kỳ thay đổi nào bằng cách đăng Chính sách Bảo mật mới trên Ứng dụng.

## 7. Liên hệ với chúng tôi

\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nếu bạn có bất kỳ câu hỏi nào về Chính sách Bảo mật này, vui lòng liên hệ với chúng tôi theo địa chỉ email: nt@gmail.com
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Markdown(
            data: termsAndConditionsText,
            styleSheet:
                MarkdownStyleSheet(textAlign: WrapAlignment.spaceBetween),
          ),
        ),
      ),
    );
  }
}
