
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_app/data/models/user/user.dart';

class AppPreferences {

  SharedPreferencesAsync get asyncPrefs => SharedPreferencesAsync();

  /// Store data whether the app is running for the first time
  Future<void> storeFirstTimeRun(bool isFirstTime)async {
    await asyncPrefs.setBool("firstTimeRun", isFirstTime);
  }

  /// Get data whether the app is running for the first time
  Future<bool> getFirstTimeRun()async{
    return await asyncPrefs.getBool("firstTimeRun")??true;
  }

  /// Store User data in shared preferences
  Future<void> storeUserData(User user) async{
    await asyncPrefs.setStringList(
        "USERDATA", [user.name,user.email,user.picture??"",user.emailVerified.toString()]);
  }

  /// Get User data from shared preferences
  Future<User?> getUserData() async{
    final userData=await asyncPrefs.getStringList("USERDATA");
    User? user;
    try{
      user = User(name:userData![0],email:userData![1],picture:userData?[2],emailVerified:(userData?[3]=="true"));
    }catch(_){
      user = null;
    }
    return user;
  }

  ///Remove user from shared preferences
  Future<void> removeUser() async {
    await asyncPrefs.remove("USERDATA");
    // await asyncPrefs.remove("USER");
  }
}
