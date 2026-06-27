import 'package:flutter/material.dart';

class deviceScreen extends StatefulWidget {
  const deviceScreen({super.key});

  @override
  State<deviceScreen> createState() => _deviceScreenState();
}

class _deviceScreenState extends State<deviceScreen> {
  int _currentIndex = 0; 
  final PageController _pageController = PageController(initialPage: 0);

  
  final Color primaryGreen = const Color(0xFF234033);
  final Color backgroundColor = const Color(0xFFF6F6F3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      
      //AppBar 
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300, width: 0.5),
            ),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.black87, size: 20),
              onPressed: () {
                Scaffold.of(context).openDrawer(); 
              },
            ),
          ),
        ),
        title: const Text(
          'Smart Home',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: primaryGreen,
              radius: 18,
              child: const Text('RB', style: TextStyle(color: Colors.white, fontSize: 14)),
            ),
          ),
        ],
      ),

      // Drawer

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: primaryGreen),
              child: const Text('Rebecca Barbara', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),

      // PageView 

      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          
          _buildHomeTab(),
          
          // other screens can be added here
          const Center(child: Text('Statistics Screen', style: TextStyle(fontSize: 24))),
          const Center(child: Text('Calendar Screen', style: TextStyle(fontSize: 24))),
          const Center(child: Text('Settings Screen', style: TextStyle(fontSize: 24))),
        ],
      ),

      // BottomNavigationBar

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primaryGreen,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), activeIcon: Icon(Icons.bar_chart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), activeIcon: Icon(Icons.calendar_month), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: ''),
        ],
      ),
    );
  }

  // (Home)

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(), 
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // (Kitchen Card)

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://picsum.photos/100',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text('Kitchen', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: const Text('5 devices · 24°C', style: TextStyle(color: Colors.grey, fontSize: 14)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {},
            ),
          ),

          const SizedBox(height: 24),

          // 2. Devices مع زر الإضافة (+)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Devices',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 3. شبكة الأجهزة (Devices Grid)
          // استخدمنا GridView.builder مع تعطيل السكرول الخاص به عشان يشتغل مع السكرول الرئيسي للشاشة بدون مشاكل
          GridView.count(
            crossAxisCount: 2, // عنصرين في كل صف
            shrinkWrap: true, // يخليه ياخد مساحة العناصر اللي جواه بس
            physics: const NeverScrollableScrollPhysics(), // تعطيل سكرول الجريد لمنع التداخل مع السكرول الخارجي
            mainAxisSpacing: 16, //space hight
            crossAxisSpacing: 16, // space width
            childAspectRatio: 0.9, // نسبة العرض إلى الارتفاع للكارت ليصبح مربعاً تقريباً بنفس شكل الصورة
            children: [
              _buildDeviceCard('Main Light', 'On · 72%', Icons.lightbulb_outline, true),
              _buildDeviceCard('Thermostat', '22°C · Auto', Icons.thermostat_outlined, false),
              _buildDeviceCard('AC Unit', 'Off', Icons.air_outlined, false),
              _buildDeviceCard('Front Door', 'Locked', Icons.lock_outline, true),
            ],
          ),
        ],
      ),
    );
  }

  // (Device Card Widget)

  Widget _buildDeviceCard(String name, String status, IconData icon, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(

      //Active take grren color and inactive take white color

        color: isActive ? primaryGreen : Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive ? Colors.white : const Color(0xFFF0F3F1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : primaryGreen,
              size: 24,
            ),
          ),
          
          // Text Device Name and Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isActive ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                status,
                style: TextStyle(
                  fontSize: 13,
                  color: isActive ? Colors.white : Colors.grey,
                ),
              ),
            ],
          ),

          // المفتاح أو الدائرة السفلية لتأكيد الحالة زى الصورة
          // عايز افهمها 
          Align(
            alignment: Alignment.bottomRight,
            child: isActive 
              ? Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                )
              : Container(
                  width: 34,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      ),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}