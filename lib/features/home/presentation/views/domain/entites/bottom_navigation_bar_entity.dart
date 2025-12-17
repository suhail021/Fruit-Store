import 'package:myapp/core/utils/app_images.dart';

class BottomNavigationBarEntity {
  final String activeImage, inActiveImage;

  BottomNavigationBarEntity({
    required this.activeImage,
    required this.inActiveImage,
  });
}

List<BottomNavigationBarEntity> get bottomNavigationBarItems => [
  BottomNavigationBarEntity(
    activeImage: Assets.imagesVuesaxBoldUser,
    inActiveImage: Assets.imagesVuesaxOutlineUser,
  ),
  BottomNavigationBarEntity(
    activeImage: Assets.imagesVuesaxBoldShoppingCart,
    inActiveImage: Assets.imagesVuesaxOutlineShoppingCart,
  ),
  BottomNavigationBarEntity(
    activeImage: Assets.imagesVuesaxBoldSIconDark,
    inActiveImage: Assets.imagesVuesaxOutlineSIconLight,
  ),
  BottomNavigationBarEntity(
    activeImage: Assets.imagesVuesaxBoldShoppingCart,
    inActiveImage: Assets.imagesVuesaxOutlineShoppingCart,
  ),
  BottomNavigationBarEntity(
    activeImage: Assets.imagesVuesaxBoldShoppingCart,
    inActiveImage: Assets.imagesVuesaxOutlineShoppingCart,
  ),
];
