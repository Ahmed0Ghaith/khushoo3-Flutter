
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khushoo3/view_model/states.dart';
import 'package:url_launcher/url_launcher.dart';

class communication extends Cubit<BaseStates>
{
  communication() :super (InitialState());
  static communication get(context) => BlocProvider.of(context);

  // FaceBook
  void openFacebook() async{
    String ProtocolUrl = "fb://user/AhmedGhaithFB";
    String fallbackUrl = "https://www.facebook.com/AhmedGhaithFB";
    try {
      bool launched = await launch(ProtocolUrl, forceSafariVC: false);
      print("launching..."+ProtocolUrl);
      if (!launched) {

        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {

      await launch(fallbackUrl, forceSafariVC: false);
    }
  }

  // whatsapp
  void openYoutube() async{
    String ProtocolUrl = "'youtube://www.youtube.com/c/AhmedGhaith";
    String fallbackUrl = "https://www.youtube.com/c/AhmedGhaith";
    try {
      bool launched = await launch(ProtocolUrl, forceSafariVC: false);
      print("launching..."+ProtocolUrl);
      if (!launched) {

        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {

      await launch(fallbackUrl, forceSafariVC: false);
    }
  }

  // Youtube
  void  openWhatsapp() async{
    String ProtocolUrl = "whatsapp://send?phone=+2001159392938";
    String fallbackUrl = "https://web.whatsapp.com/send?phone=+2001032821611";
    try {
      bool launched = await launch(ProtocolUrl, forceSafariVC: false);
      print("launching..."+ProtocolUrl);
      if (!launched) {

        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {

      await launch(fallbackUrl, forceSafariVC: false);
    }
  }

  // Email
  void openEmail() async{
    String ProtocolUrl = "mailto:<devghaith@outlook.com>";
    String fallbackUrl = "https://www.facebook.com/AhmedGhaithFB";
    try {
      bool launched = await launch(ProtocolUrl, forceSafariVC: false);
      print("launching..."+ProtocolUrl);
      if (!launched) {

        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {

      await launch(fallbackUrl, forceSafariVC: false);
    }
  }

}

