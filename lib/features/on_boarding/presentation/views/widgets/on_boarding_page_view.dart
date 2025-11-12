import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_colors.dart';
import 'package:myapp/core/utils/app_images.dart';
import 'package:myapp/core/utils/app_text_styles.dart';
import 'package:myapp/features/on_boarding/presentation/views/widgets/page_view_item.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      
      controller: pageController,
      children: [
        PageViewItem(
          image: Assets.imagesPageViewItem1Image,
          backgroundImage: Assets.imagesPageViewItem1Background,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("مرحبًا بك في", style: TextStyles.bold23),
              Text(" Store", style: TextStyles.bold23.copyWith(color: AppColors.secondaryColor)),
              Text("Fruit", style: TextStyles.bold23.copyWith(color: AppColors.primaryColor)),
            ],
          ),
          subtitle:
              "اكتشف تجربة تسوق فريدة مع FruitHUB. استكشف مجموعتنا الواسعة من الفواكه الطازجة الممتازة واحصل على أفضل العروض والجودة العالية.",
          isvisible:
              true,
        ),
        
        PageViewItem(
          image: Assets.imagesPageViewItem2Image,
          backgroundImage: Assets.imagesPageViewItem2Background,
          title: Text(
            'ابحث وتسوق',
            style: TextStyle(
              color: Color(0XFF0C0D0D),
              fontSize: 23,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          subtitle:
              "نقدم لك أفضل الفواكه المختارة بعناية. اطلع على التفاصيل والصور والتقييمات لتتأكد من اختيار الفاكهة المثالية",
          isvisible:
             false,
        ),
      ],
    );
  }
}
