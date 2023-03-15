import 'package:easy_localization/easy_localization.dart';
import 'package:manager/core/services/message.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherServices {
  Future<void> makeCall(String phone) async {
    final Uri url = Uri.parse('tel:$phone');
    if (!(await launchUrl(url))) {
      showMsg('msg_failed_call'.tr());
    }
  }
}
