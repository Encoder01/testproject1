import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testproject/Models/user_model.dart';
import 'package:testproject/Pages/CustomerPAge/customer_edit.dart';

class CustomerDetail extends StatefulWidget {
  final Datum customer;
  const CustomerDetail(this.customer, {Key? key}) : super(key: key);

  @override
  _CustomerDetailState createState() => _CustomerDetailState(this.customer);
}

class _CustomerDetailState extends State<CustomerDetail> {
  final Datum customer;
  _CustomerDetailState(this.customer);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Detail"),
      ),
      body: Center(
        child: SizedBox(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.network(
                customer.avatar,
                width: 75,
                height: 75,
              ),
              Text("Name:" + customer.firstName + " " + customer.lastName),
              Text("Email:" + customer.email),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerEdit(customer),
                        ));
                  },
                  child: const Text("Edit"))
            ],
          ),
        ),
      ),
    );
  }
}
