import 'package:flutter/material.dart';

class SmartScreen extends StatefulWidget {
  const SmartScreen({super.key});

  @override
  State<SmartScreen> createState() => _SmartScreenState();
}

class _SmartScreenState extends State<SmartScreen> {
  int _currentIndex = 0;

  
  final Color _bgBackgroundColor = const Color(0xFFF4F4F0);
  final Color _darkGreen = const Color(0xFF223C32); 
  final Color _switchBgOff = const Color(0xFFE5E5E0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          children: [
            // (Kitchen)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?w=150', 
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: const Text(
                            'Preview',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Kitchen',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '5 devices • 24°C',
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey.shade400),
                ],
              ),
            ),
            
            const SizedBox(height: 32),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Devices',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _darkGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ],
            ),
            
            const SizedBox(height: 20),

            
            SizedBox(
              height: 360, 
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.95,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildDeviceCard(
                    title: 'Main Light',
                    subtitle: 'On • 72%',
                    icon: Icons.lightbulb_outline,
                    isActive: true,
                  ),
                  _buildDeviceCard(
                    title: 'Thermostat',
                    subtitle: '22°C • Auto',
                    icon: Icons.thermostat,
                    isActive: false,
                  ),
                  _buildDeviceCard(
                    title: 'AC Unit',
                    subtitle: 'Off',
                    icon: Icons.air,
                    isActive: false,
                  ),
                  _buildDeviceCard(
                    title: 'Front Door',
                    subtitle: 'Locked',
                    icon: Icons.lock_outline,
                    isActive: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavItem(Icons.home_outlined, 0),
            _buildBottomNavItem(Icons.bar_chart_outlined, 1),
            _buildBottomNavItem(Icons.calendar_today_outlined, 2),
            _buildBottomNavItem(Icons.settings_outlined, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isActive,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? _darkGreen : Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isActive ? Colors.white : const Color(0xFFF0F0EC),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : Colors.black,
              size: 22,
            ),
          ),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isActive ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: isActive ? Colors.white: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              
              Container(
                width: 40,
                height: 24,
                padding: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isActive ? Colors.white : _switchBgOff,
                ),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        if (!isActive)
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 26,
            color: isSelected ? _darkGreen : Colors.grey.shade400,
          ),
          const SizedBox(height: 6),
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? _darkGreen : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}