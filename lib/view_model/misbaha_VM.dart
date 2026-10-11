
//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:khushoo3/view_model/states.dart';
import 'package:khushoo3/gen/assets.gen.dart';

class misbahaVM extends Cubit<BaseStates>
{
  misbahaVM() : super(InitialState());

  static misbahaVM get(Context)=>BlocProvider.of(Context);
   int ButtonCounter =0;
   int Counter =0;
   int Group = 0;
  AudioPlayer? player;
void Clicked ()
{
  try {
     player =AudioPlayer();
     player!.setAsset(Assets.music.click);
    player!.play();
    ButtonCounter++;
    Group =ButtonCounter~/33;
    Counter++;
    if (Counter==33)
      Counter=0;
    emit(misbahaClicked());
  //  final player = AudioCache();
  //  player.play('click.wav');
  }catch (ex)
  {

  }
 /* final player = AudioCache();
  player.play('assets/music/click.wav');
 */
}


}