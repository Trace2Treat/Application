import 'package:flutter/material.dart';

class Administrator extends StatefulWidget {
  const Administrator({Key? key}) : super(key: key);

  @override
  State<Administrator> createState() => _AdministratorState();
}

class _AdministratorState extends State<Administrator> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Trace2Treat Admin Dashboard'),
        ),
        body: Row(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      title: Text('Dashboard'),
                      leading: Icon(Icons.dashboard),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage()));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Data Pengguna'),
                      leading: Icon(Icons.people),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => UserDataPage()));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Data Driver'),
                      leading: Icon(Icons.drive_eta),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => DriverDataPage()));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Transaksi'),
                      leading: Icon(Icons.receipt),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionPage()));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Setting'),
                      leading: Icon(Icons.settings),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()));
                      },
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(
              width: 1,
              color: Colors.grey,
            ),
            Expanded(
              child: Container(
                color: Colors.grey[200],
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: Center(
                          child: Text('Content Pane'),
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      color: Colors.grey[300],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(Icons.save),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.print),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.logout),
                            onPressed: () {
                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}