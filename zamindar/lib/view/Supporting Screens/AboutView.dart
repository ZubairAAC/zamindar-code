import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class AboutZamindar extends StatefulWidget {
  AboutZamindar({Key? key}) : super(key: key);

  @override
  _AboutZamindarState createState() => _AboutZamindarState();
}

class _AboutZamindarState extends State<AboutZamindar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: theme.accentColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 70, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Text(
                "Zamindar",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: theme.accentColor,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Agricultural value chains are broken in most developing countries. The world needs to produce 60% more food by 2050 but in Pakistan, Farmers waste 50 % of Agri Produce just because of disrupted supply chain model and lack of resources & mentorship. These inefficiencies lead to high rates of farmer poverty. 75% of the world's poor are farmers.",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "zamindar is one of the fastest-growing start-ups in the Agri Tech sector and one of the very few companies providing end-to-end solutions and services to the farming community in Pakistan",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "We connect farmers directly with businesses. On one end, we help farmers get better prices and ensure consistent demand and on other ends, we help businesses source fresh Agri products at competitive prices directly from farmers. We do this effectively at lower cost, better speed and larger scale using an integrated supply chain powered by technology, data science, infrastructure and logistics network.",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "We are building AI-enabled technologies to revolutionize supply chain and production efficiency in the farm sector. We are pioneers in solving one of the toughest supply chain problems of the world by leveraging innovative technology. ",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "We eliminated intermediaries by taking control of the Supply Chain by using technology and analytics. We built reliable, cost-effective, and high-speed logistics and infrastructure to solve for inefficiencies and reduce food wastage in the Supply Chain. On one end, farmers get better prices and consistent demand, and on the other end, businesses receive fresh produce at competitive prices that are delivered to their doorstep. Our high-quality and hygienically handled fresh produce ensures healthy food to consumers",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
