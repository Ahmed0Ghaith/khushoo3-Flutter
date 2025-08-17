
//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:khushoo3/view_model/states.dart';

class misbahaVM extends Cubit<BaseStates>
{

  @override

  misbahaVM() : super(InitialState());

  static misbahaVM get(Context)=>BlocProvider.of(Context);
   int ButtonCounter =0;
   int Counter =0;
   int Groub = 0;
  AudioPlayer? player;
void Clicked ()
{
  try {
     player =AudioPlayer();
     player!.setAsset('assets/music/click.wav');
    player!.play();
    ButtonCounter++;
    Groub=ButtonCounter~/33;
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