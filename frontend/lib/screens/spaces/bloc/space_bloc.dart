import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/styles/snack_bar.dart';
import '../models/space.dart';
import '../space_repository.dart';

part 'space_event.dart';
part 'space_state.dart';

class SpaceBloc extends Bloc<SpaceEvent, SpaceState> {
  List<Space> spaces = [];

  SpaceBloc() : super(const SpaceInitial()) {
    on<SpaceFetch>((event, emit) async {
      emit(const SpaceLoading());
      try {
        spaces = await SpaceRepository.instance.getSpaces();
        emit(SpaceLoaded(spaces));
      } on Exception catch (e) {
        emit(SpaceFailure(e));
      }
    });
    on<SpaceCreate>((event, emit) async {
      emit(const SpaceLoading());
      try {
        await SpaceRepository.instance
            .createSpace(name: event.name, description: event.description);
        spaces = await SpaceRepository.instance.getSpaces();
        emit(SpaceLoaded(spaces));
      } on Exception catch (_) {
        emit(SpaceLoaded(spaces));
      }
    });
    on<SpaceUpdateProduct>((event, emit) async {
      try {
        await SpaceRepository.instance
            .updateProduct(spaceId: event.spaceId, productId: event.productId);
        if (event.remove) {
          showSuccessSnackBar('Product removed from space');
        } else {
          showSuccessSnackBar('Product added successfully');
        }
        emit(SpaceLoaded(spaces));
      } on Exception catch (_) {
        emit(SpaceLoaded(spaces));
      }
    });
    on<SpaceInviteUser>((event, emit) async {
      try {
        // Creating Dynamic Link
        final DynamicLinkParameters parameters = DynamicLinkParameters(
          uriPrefix: 'https://foodx.page.link',
          link: Uri.parse(
              'https://foodx.page.link?spaceId=${event.spaceId}&role=${event.role}'),
          androidParameters:
              const AndroidParameters(packageName: 'com.example.food_x'),
          iosParameters: const IOSParameters(bundleId: 'com.example.food_x'),
        );

        final dynamicLink =
            await FirebaseDynamicLinks.instance.buildShortLink(parameters);

        await SpaceRepository.instance.inviteUser(
          id: event.spaceId,
          email: event.by,
          role: event.role,
          url: dynamicLink.shortUrl.toString(),
        );

        showSuccessSnackBar('Invitation sent to ${event.by}.');
      } on Exception catch (_) {}
    });
    on<SpaceAddUser>((event, emit) async {
      emit(const SpaceLoading());
      try {
        await SpaceRepository.instance.addUser(
          spaceId: event.spaceId,
          role: event.role,
        );
        spaces = await SpaceRepository.instance.getSpaces();
        emit(SpaceLoaded(spaces));
      } on Exception catch (_) {}
    });
  }
}
