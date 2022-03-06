import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/application/profile/bloc/profileb_bloc.dart';
import 'package:learn_bloc/domain/user/model/user_response.dart';
import 'package:learn_bloc/utils/debug_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfilebBloc()..add(const ProfilebEvent.getAllUser()),
      child: BlocConsumer<ProfilebBloc, ProfilebState>(
        listener: (context, state) {
          state.maybeMap(
              orElse: () {},
              isSuccess: (value) {
                DebugUtil().logDebug(value.userResponse.toJson().toString(),
                    logName: 'All User Data');
              },
              isLoading: (value) {
                DebugUtil()
                    .logDebug("Loading", logName: 'Getting All User Data');
              });
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: const Text("All User"),
            ),
            body: Builder(
              builder: (context) {
                return state.maybeMap(
                    orElse: () => buildError(context),
                    isLoading: (value) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                    isError: (value) => buildError(context),
                    isSuccess: (value) =>
                        listUserBody(value.userResponse.data!));
              },
            ),
          );
        },
      ),
    );
  }

  Center buildError(BuildContext context) {
    return Center(
      child: TextButton.icon(
          onPressed: () {
            context.read<ProfilebBloc>().add(const ProfilebEvent.getAllUser());
          },
          icon: const Icon(Icons.repeat),
          label: const Text("Refresh")),
    );
  }

  ListView listUserBody(List<Data> listUser) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: listUser.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(listUser[i].avatar!),
            ),
            title: Text("${listUser[i].firstName!} ${listUser[i].lastName!}"),
            subtitle: Text(listUser[i].email!),
          );
        });
  }
}
