import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/Blocs/api_bloc.dart';
import 'package:testproject/Blocs/sign_in_bloc.dart';
import 'package:testproject/Pages/CustomerPAge/customer_detail.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  void initState() {
    BlocProvider.of<ApiBloc>(context).add(FetchApiData("1"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                BlocProvider.of<SignInBloc>(context).add(signOut());
              },
              child: const Text(
                "SignOut",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          if (state is ApiLoaded) {
            return ListView.builder(
              itemCount: state.users.data.length + (state.users.totalPages > 1 ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index != state.users.data.length) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CustomerDetail(state.users.data[index]),
                        ));
                      },
                      leading: CircleAvatar(
                        child: Image.network(state.users.data[index].avatar),
                      ),
                      title: Text(state.users.data[index].firstName),
                      subtitle: Text(state.users.data[index].lastName),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  );
                } else {
                  return TextButton(onPressed: () {}, child: const Text("more"));
                }
              },
            );
          } else if (state is ApiLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text("Error fetch data"),
            );
          }
        },
      ),
    );
  }
}
