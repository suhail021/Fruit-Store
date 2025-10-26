import 'package:google/core/utils/Function/custom_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchcustomeurl(context, String? url) async {
  if (url != null) {
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }else{
    customeSnakBar(context,  "Can not launch $url");
  }
}
}

