
import '../../../generated/l10n.dart';

List<String> userType = [
  S.current.PleaseChoose,
  S.current.customer,
  S.current.serviceProvider,
];
List<String> serviceType = [
  S.current.PleaseChoose,
  S.current.plumber,
  S.current.mechanical,
];
List<String> cities = [
  S.current.PleaseChoose,
  S.current.Hebron,
  S.current.bethlahem,
  S.current.nablus,
  S.current.ramallah,
];

// Future<List> fetchservices() async {
//     //print("inside getX");

//     final response = await get(Uri.parse('http://10.0.2.2:5000/service'));
//     //print("inside getX2");
//     List resbody = jsonDecode(response.body);
//     //print(resbody);
//     return resbody;
//   }



