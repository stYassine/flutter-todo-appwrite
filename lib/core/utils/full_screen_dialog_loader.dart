import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo_bloc_appwrite/core/theme/app_color.dart';

class FullScreenDialogLoader {
  static bool _isDialogOpen = false;

  static void show(BuildContext context){
    if(!_isDialogOpen){
      _isDialogOpen = true;
      WidgetsBinding.instance.addPostFrameCallback((_){
        if(context.mounted){
          showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: AppColors.transparentColor, 
            builder: (BuildContext context){
              return const PopScope(
                canPop: false,
                child: Center(
                  child: SpinKitCircle(
                    color: AppColors.appColor,
                    size: 80
                  ),
                )
              );
            }
          ).then((_) {
            _isDialogOpen = false;
          });
        }
      });

    }
  }

  static void cancel(BuildContext context){
    if(_isDialogOpen){
      Navigator.of(context, rootNavigator: true).pop();
      _isDialogOpen = false;
    }
  }

  static bool isDialogOpen(){
    return _isDialogOpen;
  }

}
