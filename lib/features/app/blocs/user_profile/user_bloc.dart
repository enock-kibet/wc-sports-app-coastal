import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/data/models/user/user.dart';

// User Model


// Event to replace the entire User object
class UpdateUser extends UserEvent {
  final User user;
  UpdateUser(this.user);
}

// Bloc
abstract class UserEvent {}

class UserBloc extends Bloc<UserEvent, User?> {
  UserBloc(User? initialUser) : super(initialUser) {
    on<UpdateUser>((event, emit) {
      emit(event.user); // Replace the entire User object
    });
  }
}
