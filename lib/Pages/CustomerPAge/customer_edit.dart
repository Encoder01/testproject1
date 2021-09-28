import 'package:flutter/material.dart';
import 'package:testproject/Models/user_model.dart';

class CustomerEdit extends StatefulWidget {
  const CustomerEdit(this.customer, {Key? key}) : super(key: key);
  final Datum customer;
  @override
  _CustomerEditState createState() => _CustomerEditState(this.customer);
}

class _CustomerEditState extends State<CustomerEdit> {
  final Datum customer;
  _CustomerEditState(this.customer);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Edit"),
      ),
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Image.network(customer.avatar),
              radius: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Name ",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.redAccent),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    hintText: customer.firstName + " " + customer.lastName),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Email ",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.redAccent),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    hintText: customer.email),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2F),
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {},
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
