import 'package:flutter/material.dart';
import 'Employee.dart';
import 'EmployeeBloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    _employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee App'),
      ),
      body: Container(
        child: StreamBuilder<List<Employee>>(
          stream: _employeeBloc.employeeListStream,
          builder: (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return Card(
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Text("${snapshot.data[i].id}.", style: TextStyle(
                          fontSize: 20
                        ), ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${snapshot.data[i].name}.", style: TextStyle(
                                fontSize: 18
                              ),
                             ),
                             Text("₹ ${snapshot.data[i].salary}", style: TextStyle(
                                fontSize: 16
                              ),
                            ), 
                          ],
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.thumb_up),
                          color: Colors.green,
                          onPressed: () {
                            _employeeBloc.employeeSalaryIncrement.add(snapshot.data[i]);
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.thumb_down),
                          color: Colors.red,
                          onPressed: () {
                            _employeeBloc.employeeSalaryDecrement.add(snapshot.data[i]);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}