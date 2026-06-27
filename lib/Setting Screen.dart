import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  
  int _currentIndex = 3; 
  
  final PageController _pageController = PageController(initialPage: 3);

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF234033);
    const Color backgroundColor = Color(0xFFF6F6F3);

    return Scaffold(
      backgroundColor: backgroundColor,

      // 1. AppBar 
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

                // Drawer

                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: primaryGreen,
              radius: 18,
              child: const Text(
                'RB',
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),

      // 2. Drawer menu

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: primaryGreen),
              child: Text('Rebecca Barbara', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),

      // Scroll pageview with 4 screens (Home, Statistics, Calendar, Settings)

      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index; //افهم ؟؟
          });
        },
        children: [
          // شاشة 0
          const Center(child: Text('Home Screen', style: TextStyle(fontSize: 24))),
          // شاشة 1
          const Center(child: Text('Statistics Screen', style: TextStyle(fontSize: 24))),
          // شاشة 2
          const Center(child: Text('Calendar Screen', style: TextStyle(fontSize: 24))),
          
          // (Settings Screen)

          _buildSettingsTab(primaryGreen),
        ],
      ),

      // 3. Bottom Navigation Bar
      
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

  //build Settings Tab screen

  Widget _buildSettingsTab(Color themeColor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          // (Switches) controls for Dark Mode, Sound Effects, Location

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                _buildSwitchTile(Icons.dark_mode_outlined, 'Dark Mode', 'Switch appearance', false),
                const Divider(height: 1, indent: 56), 
                _buildSwitchTile(Icons.volume_up_outlined, 'Sound Effects', 'Device feedback tones', true),
                const Divider(height: 1, indent: 56),
                _buildSwitchTile(Icons.language_outlined, 'Location', 'Used for automations', true),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text('SYSTEM', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
          ),

          // details system (Arrows)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                _buildNavigationTile(Icons.phone_android_outlined, 'Connected Devices', '12 devices paired'),
                const Divider(height: 1, indent: 56),
                _buildNavigationTile(Icons.wifi, 'Wi-Fi & Network', 'HomeNet_5G'),
                const Divider(height: 1, indent: 56),
                _buildNavigationTile(Icons.help_outline, 'Help & Support', 'FAQs and contact'),
                const Divider(height: 1, indent: 56),
                _buildNavigationTile(Icons.info_outline, 'About', 'Version 2.4.1'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // (Sign Out)

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.logout, color: Colors.redAccent),
              ),
              title: const Text('Sign Out', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
              subtitle: const Text('Rebecca Barbara', style: TextStyle(color: Colors.grey, fontSize: 12)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
              onTap: () {

                // Navigate to Login screen

                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSwitchTile(IconData icon, String title, String subtitle, bool value) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: const Color(0xFFF0F3F1), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: const Color(0xFF234033)),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      trailing: Switch(
        value: value,
        focusColor: Colors.white,
        activeTrackColor: const Color(0xFF234033),
        onChanged: (newValue) {},
      ),
    );
  }

  
  Widget _buildNavigationTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: const Color(0xFFF0F3F1), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: const Color(0xFF234033)),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap: () {
        
        // عايز افهم ؟؟
        
        if (title == 'Wi-Fi & Network') {
          Navigator.pushNamed(context, '/wifi');
        }
      },
    );
  }
}