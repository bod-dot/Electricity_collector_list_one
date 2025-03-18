import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/check_permissions_controller.dart';
import '../../controllers/login_controller.dart';


part 'login_state.dart';

class LoginCubitCubit extends Cubit<LoginState> {
  LoginCubitCubit() : super(LoginInitial());

void loginCub({required int areaId,required int phoneNumber,required String passwrod})
  async{
  emit(LoginLoding());
  try{

    bool isLogin=  await LoginContrloller().loginMeth(phoneNumber: phoneNumber, passwrod: passwrod);
    if(!isLogin)
    {
     checkPermissionsCubit(areaId: areaId);

    }
    else 
    {
      emit(LoginWrongPasswrodOrPhone());
    }
 

  }catch(e)
  {
    
    emit(LoginFauild(error: e.toString()));
  }

}
  


void checkPermissionsCubit({required int areaId})
async{
 SharedPreferences shared = await SharedPreferences.getInstance();
     String employeeID= shared.getString('EmployeeID')!;
      shared.setInt("areaId", areaId);
       int checkPermissions=await CheckPermissions().checkPermissionsMeth(areaId: areaId, employeeID: employeeID);

       if(checkPermissions==1)
       {
     emit(LoginSuccess());
       }
       else
       {
        emit(LoginNoPermissoion());
       }
}


}

