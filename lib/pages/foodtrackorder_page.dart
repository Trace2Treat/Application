import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../theme/app_colors.dart';

class TrackOrderPage extends StatefulWidget {
  const TrackOrderPage({Key? key}) : super(key: key);

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Order'),
        centerTitle: true,
      ),
      body: DraggableScrollableSheet(
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0.0, -5.0),
                  ),
                ],
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 26),
                child: ListView(
                controller: scrollController,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/makanan.png',
                          width: 80.0,
                          height: 80.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cheese Burger',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Ordered at 16 Jan, 10:00pm',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '20 Min',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            'Estimated delivery time',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey
                            ),
                          ),
                        ],
                      ),
                  SizedBox(height: 50),
                  TimelineTile(
                    alignment: TimelineAlign.start,
                    lineXY: 0.3,
                    indicatorStyle: IndicatorStyle(
                      iconStyle: IconStyle(
                        color: Colors.white,
                        iconData: Icons.done,
                      ),
                      width: 20,
                      color: AppColors.secondary,
                      indicatorXY: 0.3,
                    ),
                    endChild: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Your order has been received',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 14
                        ),
                      ),
                    ),
                  ),
                  TimelineTile(
                    alignment: TimelineAlign.start,
                    lineXY: 0.3,
                    indicatorStyle: IndicatorStyle(
                      iconStyle: IconStyle(
                        color: Colors.white,
                        iconData: Icons.circle_outlined,
                      ),
                      width: 20,
                      color: AppColors.secondary,
                      indicatorXY: 0.3,
                    ),
                    endChild: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'The restaurant is preparing your food',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14
                        ),
                      ),
                    ),
                  ),
                  TimelineTile(
                    alignment: TimelineAlign.start,
                    lineXY: 0.3,
                    indicatorStyle: IndicatorStyle(
                      iconStyle: IconStyle(
                        color: Colors.white,
                        iconData: Icons.done,
                      ),
                      width: 20,
                      color: Colors.grey,
                      indicatorXY: 0.3,
                    ),
                    endChild: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Your order has been picked up for delivery',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14
                        ),
                      ),
                    ),
                  ),
                  TimelineTile(
                    alignment: TimelineAlign.start,
                    lineXY: 0.3,
                    indicatorStyle: IndicatorStyle(
                      iconStyle: IconStyle(
                        color: Colors.white,
                        iconData: Icons.done,
                      ),
                      width: 20,
                      color: Colors.grey,
                      indicatorXY: 0.3,
                    ),
                    endChild: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Order arriving soon!',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColors.secondary,
                                backgroundImage:
                                    AssetImage('assets/avatar.jpg'),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Abang'),
                          Text('Driver'),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          // Call driver
                        },
                        icon: Icon(Icons.phone, color: AppColors.secondary),
                      ),
                      IconButton(
                        onPressed: () {
                          // Chat with driver
                        },
                        icon: Icon(Icons.chat, color: AppColors.secondary),
                      ),
                    ],
                  ),
                ],
              ),
              )
            );
          },
        ),
    );
  }
}