import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sqflitedeneme/helper/database_helper.dart';
import 'package:sqflitedeneme/input_field.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gdz Proje',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _startDate = DateFormat("hh:mm:a").format(DateTime.now());
  DateTime selectedDate = DateTime.now();
  List<Map> found = [
    {
      "field1": "",
      "field2": "                      I LOVE MİUUL",
      "field3": "",
      "field4": ""
    },
  ];

  List<String> ilces = [
    'KONAK',
    'BUCA',
    'DİKİLİ',
    'ÇEŞME',
    'KEMALPAŞA',
    'MENEMEN',
    'TORBALI',
    'KARABAĞLAR',
    'BORNOVA',
    'ÇİĞLİ',
    'BERGAMA',
    'MENDERES',
    'BAYRAKLI',
    'FOÇA',
    'ÖDEMİŞ',
    'KARABURUN',
    'KARŞIYAKA',
    'URLA',
    'TİRE',
    'SEFERİHİSAR',
    'KIRKAĞAÇ',
    'AKHİSAR',
    'NARLIDERE',
    'BAYINDIR',
    'KINIK',
    'GÜZELBAHÇE',
    'SELÇUK',
    'ALİAĞA',
    'BALÇOVA',
    'GAZİEMİR' 'ALAŞEHİR',
    'TURGUTLU',
    'ŞEHZADELER',
    'YUNUSEMRE',
    'SARIGÖL',
    'SOMA',
    'SELENDİ',
    'SARUHANLI',
    'GÖRDES',
    'BEYDAĞ',
    'KULA',
    'KİRAZ',
    'SALİHLİ',
    'DEMİRCİ',
    'KÖPRÜBAŞI',
    'GÖLMARMARA',
    'AHMETLİ'
  ];
  String _selectedIlce = "KARŞIYAKA";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/gdz.png",
          height: 20,
        ),
        backgroundColor: Color.fromARGB(255, 0, 38, 255),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyInputField(
                title: "Date",
                hint: DateFormat.yMd().format(selectedDate),
                widget: IconButton(
                  icon: Icon(Icons.calendar_today_outlined),
                  onPressed: () {
                    _pickDateFromUser(context);
                  },
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                "Village",
                style:
                    GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                    items: ilces
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    value: _selectedIlce,
                    onChanged: (value) {
                      setState(() {
                        _selectedIlce = value as String;
                      });
                    },
                    buttonHeight: 60,
                    buttonWidth: 400,
                    itemHeight: 60,
                    dropdownMaxHeight: 400,
                    searchController: textEditingController,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'Search for an item...',
                          hintStyle: const TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return (item.value
                          .toString()
                          .toLowerCase()
                          .contains(searchValue));
                    },
                    //This to clear the search value when you close the menu
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        textEditingController.clear();
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                margin: EdgeInsets.only(left: 120),
                child: TextButton(
                  onPressed: () {
                    _getplaceshereitcanbeproblem();
                  },
                  child: Text(
                    "Predict",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 0, 102, 255)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.grey))),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(20))),
                ),
              ),
              Container(
                height: 430,
                child: _myListView(),
              )
            ],
          ),
        ),
      ),
    );
  }

  _myListView() {
    return ListView.builder(
      itemCount: found.length,
      itemBuilder: (context, index) {
        return Expanded(
          child: Container(
              padding: EdgeInsets.all(11),
              margin: EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  Text(found[index]["field1"]),
                  SizedBox(
                    width: 35,
                  ),
                  Text(found[index]["field2"]),
                  SizedBox(
                    width: 35,
                  ),
                  Text(found[index]["field3"]),
                  SizedBox(
                    width: 35,
                  ),
                  Text(found[index]["field4"]),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                  color: Colors.amber)),
        );
      },
    );
  }

  _getplaceshereitcanbeproblem() async {
    print(selectedDate.toString().substring(0, 10));
    var xf = await DatabaseHelper()
        .istenenial(_selectedIlce, selectedDate.toString().substring(0, 10));
    found = xf;
    setState(() {});
  }

  _pickDateFromUser(BuildContext context) async {
    DateTime? _userDateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2050));
    if (_userDateTime != null) {
      setState(() {
        selectedDate = _userDateTime;
      });

      print("selected date   $selectedDate");
    }
  }
}
