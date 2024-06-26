import 'package:fe_attendance_app/features/main_feature/screens/profile/widgets/appbar_profile.dart';
import 'package:fe_attendance_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  final String termsAndConditionsText = """
## 1. Điều khoản chung

*   **Chấp thuận điều khoản:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bằng cách tải xuống, cài đặt và sử dụng Ứng dụng Nhận diện NT ("Ứng dụng"), bạn đồng ý với các điều khoản và điều kiện được nêu trong tài liệu này ("Điều khoản"). Nếu bạn không đồng ý với bất kỳ điều khoản nào, vui lòng không sử dụng Ứng dụng.
*   **Thay đổi điều khoản:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NT có quyền thay đổi Điều khoản này bất cứ lúc nào. Bất kỳ thay đổi nào sẽ được thông báo qua Ứng dụng hoặc qua email. Việc bạn tiếp tục sử dụng Ứng dụng sau khi có thông báo thay đổi sẽ được coi là chấp nhận các thay đổi đó.

## 2. Giới thiệu về ứng dụng

*   **Tính năng:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ứng dụng Nhận diện NT cung cấp các tính năng nhận diện khuôn mặt, vật thể và văn bản. Các tính năng này có thể được sử dụng cho các mục đích cá nhân và thương mại.
*   **Quyền truy cập:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Để sử dụng Ứng dụng, bạn cần cấp quyền truy cập vào camera và bộ nhớ của thiết bị. Bạn có thể quản lý các quyền này trong cài đặt thiết bị.

## 3. Quyền sở hữu trí tuệ

*   **Nội dung của NT:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tất cả nội dung trong Ứng dụng, bao gồm nhưng không giới hạn ở phần mềm, hình ảnh, logo, nhãn hiệu và văn bản, đều thuộc sở hữu của NT hoặc các nhà cấp phép của NT và được bảo vệ bởi luật sở hữu trí tuệ.
*   **Nội dung của người dùng:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bạn giữ quyền sở hữu đối với bất kỳ nội dung nào bạn tải lên hoặc tạo ra trong Ứng dụng. Tuy nhiên, bằng cách tải lên hoặc tạo ra nội dung, bạn cấp cho NT giấy phép không độc quyền, miễn phí bản quyền, có thể chuyển nhượng, có thể cấp phép phụ để sử dụng, sao chép, sửa đổi, phân phối, hiển thị công khai và thực hiện nội dung đó liên quan đến Ứng dụng.

## 4. Quyền riêng tư

*   **Thu thập dữ liệu:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NT thu thập thông tin cá nhân của bạn, bao gồm nhưng không giới hạn ở tên, địa chỉ email và số điện thoại, khi bạn đăng ký tài khoản hoặc sử dụng Ứng dụng. NT cũng thu thập thông tin về cách bạn sử dụng Ứng dụng, chẳng hạn như các tính năng bạn sử dụng và tần suất bạn sử dụng chúng.
*   **Sử dụng dữ liệu:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NT sử dụng thông tin của bạn để cung cấp, duy trì và cải thiện Ứng dụng, cũng như để liên hệ với bạn về các sản phẩm và dịch vụ của NT. NT cũng có thể chia sẻ thông tin của bạn với các bên thứ ba để hỗ trợ cung cấp Ứng dụng và cho các mục đích tiếp thị.
*   **Bảo vệ dữ liệu:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NT cam kết bảo vệ thông tin của bạn và sẽ thực hiện các biện pháp hợp lý để bảo vệ thông tin của bạn khỏi bị truy cập, sử dụng hoặc tiết lộ trái phép.

## 5. Miễn trừ trách nhiệm và giới hạn trách nhiệm

*   **Ứng dụng được cung cấp "nguyên trạng":** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NT không đảm bảo rằng Ứng dụng sẽ không có lỗi hoặc không bị gián đoạn. NT cũng không chịu trách nhiệm về bất kỳ thiệt hại nào phát sinh từ việc sử dụng Ứng dụng.
*   **Giới hạn trách nhiệm:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Trong mọi trường hợp, NT sẽ không chịu trách nhiệm về bất kỳ thiệt hại gián tiếp, ngẫu nhiên, đặc biệt, do hậu quả hoặc trừng phạt nào phát sinh từ hoặc liên quan đến việc sử dụng Ứng dụng.

## 6. Luật áp dụng và giải quyết tranh chấp

*   **Luật áp dụng:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Điều khoản này được điều chỉnh bởi và hiểu theo luật pháp Việt Nam.
*   **Giải quyết tranh chấp:** 
\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bất kỳ tranh chấp nào phát sinh từ hoặc liên quan đến Điều khoản này sẽ được giải quyết thông qua trọng tài theo quy tắc của Trung tâm Trọng tài Quốc tế Việt Nam (VIAC).

## 7. Liên hệ

\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nếu bạn có bất kỳ câu hỏi nào về Điều khoản này, vui lòng liên hệ với NT theo địa chỉ email: nt@gmail.com
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TAppBar(title: AppTexts.termsTitle,),
      ),
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
