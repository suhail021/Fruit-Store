import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google/constants.dart';
import 'package:google/core/models/book_model/book_model.dart';
import 'package:google/core/utils/app_router.dart';
import 'package:google/core/utils/styles.dart';
import 'package:google/features/home/presentation/views/widgets/book_rating.dart';

class SearchViewItem extends StatelessWidget {
  const SearchViewItem({super.key, required this.book});
final BookModel book;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.kBookDetailsView, extra: book);
      },
      child: SizedBox(
        height: 115,

        child: Row(
          children: [
            SizedBox(width: 20),
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: AspectRatio(
                // 3 this is the width a nd the 4 is the height
                aspectRatio: 3 / 4,
                child: CachedNetworkImage(
                  imageUrl: book.volumeInfo.imageLinks?.thumbnail ?? '',
                  fit: BoxFit.fill,
                  // placeholder: (context, url) => const CircularProgressIndicator(padding: EdgeInsets.symmetric(horizontal: 45,vertical: 80),color: Colors.white,strokeWidth: 2,),
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ),
            SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    // width: MediaQuery.of(context).size.width * .5,
                    child: Text(
                      book.volumeInfo.title!,

                      style: Styles.textStyle20.copyWith(
                        fontFamily: kGtSectraFine,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    book.volumeInfo.authors?[0] ?? "no name",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.textStyle14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Free",
                        style: Styles.textStyle20.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      BookRating(),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}