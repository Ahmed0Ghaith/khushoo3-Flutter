import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khushoo3/view/shared/colors.dart';
import 'package:khushoo3/view/shared/styles.dart';
import 'package:khushoo3/view_model/misbaha_VM.dart';
import 'package:khushoo3/view_model/states.dart';

class misbaha extends StatelessWidget {
  misbahaVM? VM;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => misbahaVM(),
      child: BlocConsumer<misbahaVM, BaseStates>(
          listener: (context, state) {},
          builder: (context, state) {
            VM = misbahaVM.get(context);
            return Container(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${VM!.Groub}',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      child: Container(
                        color: Golden,
                        width: 80.0,
                        height: 80.0,
                        child: RawMaterialButton(
                            elevation: 0.0,
                            child: Text(
                              '${VM!.ButtonCounter}',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onPressed: () {
                              VM!.Clicked();
                            }),
                      ),
                    ),
                    Text('${VM!.Counter}',
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                  ],
                ),
              )),
            );
          }),
    );
  }
}
