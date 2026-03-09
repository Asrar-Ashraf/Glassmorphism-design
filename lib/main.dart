import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_practice_overall/tabarpractic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Glass Morphism Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const MyHomePage(title: 'Premium Glass UI'),
      ),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  // Live Glass Configuration
  double _blurIntensity = 20.0;
  double _opacity = 0.15;
  double _glassThickness = 1.0;
  bool _enableBackgroundDistortion = true;
  bool _enableGlassBorder = true;
  Color _tintColor = Colors.blue;

  // Background Images
  int _selectedBackground = 0;
  static final List<String> backgroundImages = [
    'https://picsum.photos/1200/800?random=1',
    'https://picsum.photos/1200/800?random=2',
    'https://picsum.photos/1200/800?random=3',
    'https://picsum.photos/1200/800?random=4',
    'https://picsum.photos/1200/800?random=5',
    'https://picsum.photos/1200/800?random=6',
    'https://picsum.photos/1200/800?random=7',
  ];

  final List<String> _backgroundNames = [
    'Nature 1',
    'Nature 2',
    'Nature 3',
    'Nature 4',
    'Nature 5',
    'Nature 6',
    'Nature 7',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: _selectedBackground < backgroundImages.length
              ? DecorationImage(
                  image: NetworkImage(backgroundImages[_selectedBackground]),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.darken,
                  ),
                )
              : null,
          gradient: _selectedBackground >= backgroundImages.length
              ? const RadialGradient(
                  center: Alignment.topLeft,
                  radius: 2.0,
                  colors: [
                    Color(0xFF4FC3F7),
                    Color(0xFF29B6F6),
                    Color(0xFF0288D1),
                    Color(0xFF1976D2),
                    Color(0xFF303F9F),
                    Color(0xFF512DA8),
                    Color(0xFF7B1FA2),
                    Color(0xFFAD1457),
                    Color(0xFFE91E63),
                    Color(0xFFFF5722),
                  ],
                  stops: [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 1.0],
                )
              : null,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 🔥 PREMIUM GLASS APP BAR
              Container(
                margin: EdgeInsets.all(16),
                height: 70,
                child: GlassMorphismContainer(
                  width: double.infinity,
                  height: 70,
                  borderRadius: BorderRadius.circular(35),
                  blurIntensity: _blurIntensity / 50,
                  opacity: _opacity,
                  enableGlassBorder: _enableGlassBorder,
                  tintColor: _tintColor.withOpacity(0.3),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'Premium Glass UI ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GlassMorphismButton(
                          onPressed: _showSettingsDialog,
                          style: GlassMorphismButtonStyle(
                            backgroundColor: Colors.transparent,
                          ),
                          child: Icon(Icons.settings, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildLiveConfigPanel(),
                      SizedBox(height: 24),
                      _buildGlassButtonsRow(),
                      SizedBox(height: 24),
                      _buildHeroCards(),
                      SizedBox(height: 24),
                      _buildPremiumTabBar(),
                      SizedBox(height: 24),
                      _buildInteractiveGlass(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLiveConfigPanel() {
    return GlassMorphismContainer(
      height: 560,
      padding: EdgeInsets.all(20),
      blurIntensity: _blurIntensity / 50,
      opacity: _opacity + 0.1,

      glassThickness: _glassThickness,
      enableBackgroundDistortion: _enableBackgroundDistortion,
      enableGlassBorder: _enableGlassBorder,
      tintColor: Colors.orange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🎛️ Live Glass Controls',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),

          // Sliders
          _buildSlider(
            'Blur: ${_blurIntensity.toStringAsFixed(0)}',
            _blurIntensity,
            0,
            50,
            (v) => setState(() => _blurIntensity = v),
          ),
          _buildSlider(
            'Opacity: ${_opacity.toStringAsFixed(2)}',
            _opacity,
            0,
            0.5,
            (v) => setState(() => _opacity = v),
          ),
          _buildSlider(
            'Thickness: ${_glassThickness.toStringAsFixed(1)}',
            _glassThickness,
            0.1,
            3,
            (v) => setState(() => _glassThickness = v),
          ),

          SizedBox(height: 20),

          // Toggles
          SwitchListTile(
            title: Text(
              'Background Distortion',
              style: TextStyle(color: Colors.white),
            ),
            value: _enableBackgroundDistortion,
            onChanged: (v) => setState(() => _enableBackgroundDistortion = v),
            activeColor: Colors.white,
          ),
          SwitchListTile(
            title: Text('Glass Border', style: TextStyle(color: Colors.white)),
            value: _enableGlassBorder,
            onChanged: (v) => setState(() => _enableGlassBorder = v),
            activeColor: Colors.white,
          ),

          // Background Selector
          Text(
            'Background:',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: backgroundImages.length + 1,
              itemBuilder: (context, i) {
                final isGradient = i == backgroundImages.length;
                final isSelected = _selectedBackground == i;
                return GestureDetector(
                  onTap: () => setState(() => _selectedBackground = i),
                  child: Container(
                    width: 80,
                    height: 60,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? Border.all(color: Colors.white, width: 3)
                          : Border.all(color: Colors.white24, width: 1),
                      image: !isGradient
                          ? DecorationImage(
                              image: NetworkImage(backgroundImages[i]),
                              fit: BoxFit.cover,
                            )
                          : null,
                      gradient: isGradient
                          ? LinearGradient(colors: [Colors.blue, Colors.purple])
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    double min,
    double max,
    Function(double) onChange,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white)),
        Slider(
          value: value,
          min: min,
          max: max,
          activeColor: Colors.white,
          inactiveColor: Colors.white24,
          onChanged: onChange,
        ),
      ],
    );
  }

  Widget _buildGlassButtonsRow() {
    return GlassMorphismContainer(
      height: 150,
      padding: EdgeInsets.all(16),
      blurIntensity: _blurIntensity / 50,
      opacity: _opacity,
      tintColor: Colors.purple,
      child: Column(
        children: [
          Text(
            'Glass Buttons',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GlassMorphismButton(
                onPressed: () => _showSnackBar('Primary Button!'),
                child: Text('Primary'),
              ),
              GlassMorphismButton(
                onPressed: () => _showSnackBar('Secondary Button!'),
                child: Text('Secondary'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCards() {
    return Column(
      children: [
        Text(
          '🏆 Premium Cards',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: GlassMorphismContainer(
                height: 140,
                padding: EdgeInsets.all(20),
                blurIntensity: _blurIntensity / 50,
                opacity: _opacity,
                tintColor: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.analytics, size: 40, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      'Analytics',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: GlassMorphismContainer(
                height: 140,
                padding: EdgeInsets.all(20),
                blurIntensity: _blurIntensity / 50,
                opacity: _opacity,
                tintColor: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.speed, size: 40, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      'Performance',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPremiumTabBar() {
    return GlassMorphismContainer(
      height: 360,
      padding: EdgeInsets.all(16),
      blurIntensity: _blurIntensity / 50,
      opacity: _opacity + 0.1,
      tintColor: Colors.indigo,
      child: Column(
        children: [
          Text(
            '📱 Glass TabBar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white60,
                  tabs: [
                    Tab(icon: Icon(Icons.home), text: "Home"),
                    Tab(icon: Icon(Icons.explore), text: "Explore"),
                    Tab(icon: Icon(Icons.person), text: "Profile"),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 160,
                  child: TabBarView(
                    children: [
                      _buildTabContent('Home', Icons.home, Colors.red),
                      _buildTabContent('Explore', Icons.explore, Colors.amber),
                      _buildTabContent('Profile', Icons.person, Colors.blue),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(String title, IconData icon, Color color) {
    return GlassMorphismContainer(
      padding: EdgeInsets.all(20),
      blurIntensity: _blurIntensity / 100,
      opacity: _opacity,
      tintColor: color.withOpacity(0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveGlass() {
    return Column(
      children: [
        Text(
          '🎯 Interactive',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlassMorphismButton(
              onPressed: _showBottomSheet,
              child: Text('Bottom Sheet'),
            ),
            SizedBox(width: 12),
            GlassMorphismButton(
              onPressed: _showBottomSheet,
              child: Text('Dialog Box'),
            ),
          ],
        ),
      ],
    );
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _showBottomSheet() {
    GlassMorphismBottomSheet.show(
      context: context,
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Premium Glass Sheet ✨',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Live glassmorphism controls working!',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GlassMorphismButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                ),
                GlassMorphismButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showSnackBar('Action Complete!');
                  },
                  style: GlassMorphismButtonStyle(
                    backgroundColor: Colors.green,
                  ),
                  child: Text('Done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    GlassMorphismDialog.show(
      context: context,
      title: Text('Glass Dialog ✨', style: TextStyle(color: Colors.white)),
      content: Text(
        'Premium glassmorphism UI demo!',
        style: TextStyle(color: Colors.white70),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        GlassMorphismButton(
          onPressed: () {
            Navigator.pop(context);
            _showSnackBar('Confirmed!');
          },
          child: Text('OK'),
        ),
      ],
    );
  }

  void _showSettingsDialog() {
    GlassMorphismAlertDialog.show(
      context: context,
      title: 'Glass Settings ✨',
      content: 'All live controls working perfectly!',
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
      ],
    );
  }
}
