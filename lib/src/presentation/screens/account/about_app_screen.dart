import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthify/src/constants/assets.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.defaultWhite,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          context.aboutApp,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.defaultWhite,
            fontWeight: FontWeight.w500,
            fontFamily: "Alexandria",
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: DefaultAppText(
          text: """
تعتبر شركة صحتك تهمنا للخدمات الطبيه والتى تحمل شهادة تأسيس من رئيس هيئة الأستثمار رقم 274 ك بتاريخ 2/2/2023 هي الأولي من نوعها التى تقوم بتوفير أول وأقوي بديل مجاني وإلكترونى للتأمين الصحي في مصر والذي يشمل خصومات مجانية علي كافة الخدمات الطبية المتاحة بدون أي اشتراكات او رسوم ادارية  وتوفر صحتك تهمنا أكبر منصة مجانية شاملة تجمع بين مختلف أنواع المؤسسات الطبيه ( المستشفيات – العيادات – المراكز الطبية التخصصية – الصيدليات – مراكز الأشعة – مراكز التحاليل – مراكز البصريات والمستلزمات الطبيه ) وذلك لتحقيق رسالتها وهى الأرتقاء بمنظومة الرعاية الصحية في مصر دون تحميل أي أعباء إضافية علي المرضي.
ويمكن للمؤسسات الطبية بمختلف انواعها أن توفر تجربة رعاية صحية سهلة وبدون عقبات بفضل برنامج ادارة المؤسسات الطبية من صحتك تهمنا.
تعمل صحتك تهمنا حالياً بمدينة الأسكندرية وقريبا في باقي محافظات مصر. نطمح لتقديم تأمين صحي مجاني لكل عائلة في مصر.

                """,
          textAlign: TextAlign.start,
          lineHeight: 1.5,
        ),
      ),
    );
  }
}
