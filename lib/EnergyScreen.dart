import 'package:flutter/material.dart';

void main() {
  runApp(const EnergyScreen());
}

class EnergyScreen extends StatelessWidget {
  const EnergyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AnalyticsScreen(),
    );
  }
}

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            child: const Icon(Icons.menu, size: 20),
          ),
        ),
        title: const Text(
          'Analytics',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF3C6255),
              radius: 18,
              child: const Text(
                'RB',
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This week',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 4),
            const Text(
              'Energy Usage',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Serif',
              ),
            ),
            const SizedBox(height: 24),

            // 1. الـ Container  (Energy Usage Card)
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: const Color(0xFF2D4A3E),
                borderRadius: BorderRadius.circular(32.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total this month',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '48.2 kWh',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.arrow_downward, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text(
                          '12% vs last month',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // رسمة الأعمدة البيانية المصغرة بالأسفل
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildChartBar(height: 20),
                      _buildChartBar(height: 35),
                      _buildChartBar(height: 25),
                      _buildChartBar(height: 42),
                      _buildChartBar(height: 30),
                      _buildChartBar(height: 20),
                      _buildChartBar(height: 48),
                      _buildChartBar(height: 35),
                      _buildChartBar(height: 28),
                      _buildChartBar(height: 40),
                      _buildChartBar(height: 45, isHighlighted: true),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Text(
              'Daily Breakdown',
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),


            _buildDailyRow('Mon', 0.5, '5.2 kWh'),
            _buildDailyRow('Tue', 0.7, '6.8 kWh'),
            _buildDailyRow('Wed', 0.75, '7.1 kWh'),
            _buildDailyRow('Thu', 0.45, '4.9 kWh'),
            _buildDailyRow('Fri', 0.65, '6.3 kWh'),
          ],
        ),
      ),


      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: 1,
          selectedItemColor: const Color(0xFF2D4A3E),
          unselectedItemColor: Colors.black26,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: ''),
          ],
        ),
      ),
    );
  }


  Widget _buildChartBar({required double height, bool isHighlighted = false}) {
    return Container(
      width: 18,
      height: height,
      decoration: BoxDecoration(
        color: isHighlighted ? Colors.white : Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }


  Widget _buildDailyRow(String day, double progress, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(day, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.black.withOpacity(0.05),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4A7A68)),
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(value, style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}