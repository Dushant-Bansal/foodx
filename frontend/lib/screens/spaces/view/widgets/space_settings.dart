import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/screens/spaces/bloc/space_bloc.dart';
import 'package:food_x/screens/spaces/models/invited_users.dart';
import 'package:food_x/screens/spaces/models/space.dart';
import 'package:food_x/screens/spaces/space_repository.dart';
import 'package:food_x/styles/palette.dart';
import 'package:food_x/styles/text_style.dart';
import 'package:food_x/utilities/extensions.dart';
import 'package:food_x/widgets/field.dart';
import 'package:food_x/widgets/loader.dart';

const List<String> roles = <String>['collaborator', 'viewer'];

class SpaceSettings extends StatefulWidget {
  const SpaceSettings({super.key, required this.space});

  final Space space;

  @override
  State<SpaceSettings> createState() => _SpaceSettingsState();
}

class _SpaceSettingsState extends State<SpaceSettings> {
  TextEditingController email = TextEditingController();
  TextEditingController role = TextEditingController(text: roles.first);

  late Future<List<InvitedUsers>> getInvitedUsers;

  @override
  void initState() {
    getInvitedUsers = SpaceRepository.instance.getInvitedUsers(widget.space.id);
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    role.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SpaceBloc, SpaceState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 0,
          title: Text(
            widget.space.name,
            style: kPoppinsBoldWhiteSmall.copyWith(color: Palette.black),
          ),
          centerTitle: false,
          bottom: _buildInvite(),
        ),
        body: FutureBuilder<List<InvitedUsers>>(
          future: getInvitedUsers,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            if (snapshot.hasData) {
              return RefreshIndicator(
                color: Palette.darkGreen,
                onRefresh: () async {
                  getInvitedUsers =
                      SpaceRepository.instance.getInvitedUsers(widget.space.id);
                  setState(() {});
                },
                child: ListView(
                  children: List.generate(
                    snapshot.data!.length,
                    (index) => ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Palette.lightGreen,
                        radius: 24,
                        child: Text(
                          snapshot.data![index].by.characters.first
                              .toUpperCase(),
                          style: kPoppinsLightWhiteLarge,
                        ),
                      ),
                      title: Text(
                        snapshot.data![index].by,
                        style: kPoppinsLightBold,
                      ),
                      subtitle: Text(
                        describeEnum(snapshot.data![index].role).capitalize(),
                        style: kPoppinsLightBold,
                      ),
                      trailing: Text(
                        describeEnum(snapshot.data![index].status).capitalize(),
                        style: kPoppinsLightBold,
                      ),
                    ),
                  ),
                ),
              );
            }
            return const Center(child: Loader());
          },
        ),
      ),
    );
  }

  PreferredSize _buildInvite() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(150),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          children: [
            TextInputField(
              controller: email,
              hintText: 'Invite users via Email',
              iconData: Icons.person_add_alt_1_outlined,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  DropdownMenu<String>(
                    initialSelection: roles.first,
                    trailingIcon: Icon(Icons.arrow_drop_down_circle_outlined,
                        color: Palette.darkGreen, size: 32.0),
                    dropdownMenuEntries: roles
                        .map<DropdownMenuEntry<String>>(
                          (value) => DropdownMenuEntry<String>(
                            value: value,
                            label: value.capitalize(),
                          ),
                        )
                        .toList(),
                    onSelected: (value) {
                      if (value != null) {
                        role.text = value;
                      }
                    },
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Palette.blue,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (email.text.isNotEmpty &&
                              RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email.text)) {
                            context.read<SpaceBloc>().add(SpaceInviteUser(
                                widget.space.id, email.text, role.text));
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Send Invite', style: kPoppinsWhite),
                            const Icon(Icons.arrow_circle_right_outlined,
                                color: Colors.white, size: 32.0)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
