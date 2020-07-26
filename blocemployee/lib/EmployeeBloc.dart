import 'dart:async';
import 'Employee.dart';

class EmployeeBloc {
  List<Employee> _employeeList = [
    Employee(1, "Rasila", 1000000),
    Employee(2, "Chirag", 1000000),
    Employee(3, "Aky", 1000000),
    Employee(4, "Addy", 1000000),
  ];

  final _employeeListStreamController = StreamController<List<Employee>>();

  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  Stream<List<Employee>> get employeeListStream => _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink => _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement => _employeeSalaryIncrementStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecrement => _employeeSalaryDecrementStreamController.sink;

  EmployeeBloc() {
    _employeeListStreamController.add(_employeeList);

    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  _incrementSalary(Employee employee) {
    double salary = employee.salary;
    double newsal = salary * 0.2;
    _employeeList[employee.id - 1].salary = salary + newsal;

    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double newsal = salary * 0.2;
    _employeeList[employee.id - 1].salary = salary - newsal;

    employeeListSink.add(_employeeList);
  }

  void dispose() {
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeListStreamController.close();
  }

}