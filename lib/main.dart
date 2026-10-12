
import 'package:flutter/material.dart';

void main() {
  runApp(const NathrApp());
}

const Color bg = Color(0xFF0B1017);
const Color panel = Color(0xFF151E29);
const Color accent = Color(0xFF21D6A1);
const Color muted = Color(0xFF8D9AAA);
const Color blue = Color(0xFF58A6FF);
const Color orange = Color(0xFFFFBD69);

class NathrApp extends StatelessWidget {
  const NathrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'نذر | NATHR',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(
          primary: accent,
          surface: panel,
        ),
        useMaterial3: true,
        fontFamily: 'sans-serif',
      ),
      home: const NathrHome(),
    );
  }
}

class NathrHome extends StatefulWidget {
  const NathrHome({super.key});

  @override
  State<NathrHome> createState() => _NathrHomeState();
}

class _NathrHomeState extends State<NathrHome> {
  int selected = 0;

  final List<NavItem> items = const [
    NavItem('الرئيسية', Icons.dashboard_rounded),
    NavItem('الاختبار الأمني', Icons.radar_rounded),
    NavItem('الحماية والتحليل', Icons.shield_rounded),
    NavItem('التدخل والاستعادة', Icons.health_and_safety_rounded),
    NavItem('الأجهزة', Icons.devices_rounded),
    NavItem('المهام', Icons.assignment_rounded),
    NavItem('الثغرات', Icons.bug_report_rounded),
    NavItem('السجلات', Icons.receipt_long_rounded),
    NavItem('الإعدادات', Icons.settings_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg,
        titleSpacing: 18,
        title: const Row(
          children: [
            Icon(Icons.security_rounded, color: accent, size: 29),
            SizedBox(width: 10),
            Text(
              'نَذْر | NATHR',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'الإشعارات',
            onPressed: () => showMessage('لا توجد إشعارات جديدة'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: Drawer(
        backgroundColor: panel,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                color: bg,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.security_rounded, color: accent, size: 42),
                    SizedBox(height: 12),
                    Text(
                      'نَذْر | NATHR',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'منصة الأمن والتحليل والاستعادة',
                      style: TextStyle(color: muted, fontSize: 12),
                    ),
                  ],
                ),
              ),
              for (int i = 0; i < items.length; i++)
                ListTile(
                  leading: Icon(
                    items[i].icon,
                    color: selected == i ? accent : muted,
                  ),
                  title: Text(
                    items[i].title,
                    style: TextStyle(
                      color: selected == i ? accent : Colors.white,
                    ),
                  ),
                  selected: selected == i,
                  onTap: () {
                    setState(() => selected = i);
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: selected,
          children: [
            DashboardPage(onOpen: (i) => setState(() => selected = i)),
            const TestingPage(),
            const ProtectionPage(),
            const RecoveryPage(),
            const DevicesPage(),
            const JobsPage(),
            const VulnerabilitiesPage(),
            const LogsPage(),
            const SettingsPage(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: panel,
        indicatorColor: accent.withOpacity(0.16),
        selectedIndex: selected > 3 ? 0 : selected,
        onDestinationSelected: (i) {
          setState(() => selected = i);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded, color: accent),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(Icons.radar),
            label: 'الاختبار',
          ),
          NavigationDestination(
            icon: Icon(Icons.shield_outlined),
            label: 'الحماية',
          ),
          NavigationDestination(
            icon: Icon(Icons.health_and_safety_outlined),
            label: 'الاستعادة',
          ),
        ],
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class NavItem {
  final String title;
  final IconData icon;

  const NavItem(this.title, this.icon);
}

class DashboardPage extends StatelessWidget {
  final ValueChanged<int> onOpen;

  const DashboardPage({super.key, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF173B39), Color(0xFF152330)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: accent.withOpacity(0.3)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مركز القيادة الأمنية',
                style: TextStyle(color: muted, fontSize: 13),
              ),
              SizedBox(height: 10),
              Text(
                'مرحبًا بك في نَذْر',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'إدارة الاختبارات والحماية واستعادة الأنظمة من مكان واحد.',
                style: TextStyle(color: Colors.white70, height: 1.6),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.circle, color: accent, size: 10),
                  SizedBox(width: 7),
                  Text(
                    'الواجهة المحلية جاهزة',
                    style: TextStyle(color: accent, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const SectionTitle('نظرة عامة'),
        const SizedBox(height: 12),
        const Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'الأجهزة',
                value: '0',
                icon: Icons.devices_rounded,
                color: blue,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: StatCard(
                title: 'المهام',
                value: '0',
                icon: Icons.assignment_rounded,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'الثغرات',
                value: '0',
                icon: Icons.bug_report_rounded,
                color: orange,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: StatCard(
                title: 'التنبيهات',
                value: '0',
                icon: Icons.notifications_active_rounded,
                color: Color(0xFFFF7777),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionTitle('الأنظمة الرئيسية'),
        const SizedBox(height: 12),
        FeatureCard(
          icon: Icons.radar_rounded,
          color: blue,
          title: 'الاختبار الأمني المتقدم',
          description: 'فحوص مصرح بها وتحليل الخدمات والمخاطر.',
          onTap: () => onOpen(1),
        ),
        FeatureCard(
          icon: Icons.shield_rounded,
          color: accent,
          title: 'الحماية والتحليل',
          description: 'الأدلة الرقمية ومراقبة الأصول وسجلات التدقيق.',
          onTap: () => onOpen(2),
        ),
        FeatureCard(
          icon: Icons.health_and_safety_rounded,
          color: orange,
          title: 'التدخل والاستعادة المتقدمة',
          description: 'التحقيق في الحوادث وخطط استعادة الوصول.',
          onTap: () => onOpen(3),
        ),
        const SizedBox(height: 24),
        const SectionTitle('حالة المنصة'),
        const SizedBox(height: 10),
        const InfoRow(
          icon: Icons.storage_rounded,
          title: 'قاعدة البيانات',
          subtitle: 'لم يتم ربط قاعدة البيانات بعد',
          color: muted,
        ),
        const InfoRow(
          icon: Icons.cloud_off_rounded,
          title: 'الخادم المركزي',
          subtitle: 'غير متصل — لم تتم تهيئته بعد',
          color: orange,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      icon: Icons.radar_rounded,
      title: 'الاختبار الأمني المتقدم',
      description: 'إدارة الفحوص المصرح بها ومراجعة نتائجها.',
      color: blue,
      features: const [
        'إدارة نطاقات الاختبار المصرح بها',
        'فحص المنافذ والخدمات ضمن النطاق المحدد',
        'تحليل إعدادات TLS والشهادات',
        'تقييم إعدادات أمان تطبيقات الويب',
        'مطابقة النتائج مع بيانات CVE',
        'مختبر محاكاة آمن للسيناريوهات الهجومية',
      ],
    );
  }
}

class ProtectionPage extends StatelessWidget {
  const ProtectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      icon: Icons.shield_rounded,
      title: 'الحماية والتحليل',
      description: 'متابعة الأصول وتحليل الأدلة وتقييم المخاطر.',
      color: accent,
      features: const [
        'جرد الأجهزة والخدمات المصرح بها',
        'تصنيف الأدلة الرقمية',
        'حساب بصمة SHA-256 للملفات',
        'تحليل مؤشرات الاختراق',
        'إدارة المخاطر والتوصيات العلاجية',
        'سجل تدقيق للإجراءات الأمنية',
      ],
    );
  }
}

class RecoveryPage extends StatelessWidget {
  const RecoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      icon: Icons.health_and_safety_rounded,
      title: 'التدخل والاستعادة المتقدمة',
      description: 'إدارة الاستجابة للحوادث واستعادة الأنظمة المتضررة.',
      color: orange,
      features: const [
        'تسجيل القضية وإثبات التفويض',
        'جمع أدلة الحادث وحفظها',
        'تقييم خيارات استعادة الوصول',
        'إدارة إجراءات الطوارئ الموثقة',
        'استعادة النسخ الاحتياطية الموثوقة',
        'التحقق من سلامة النظام بعد الاستعادة',
      ],
    );
  }
}

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionPage(
      icon: Icons.devices_rounded,
      title: 'إدارة الأجهزة',
      description: 'سيكون هنا سجل الأجهزة والأصول المعتمدة.',
      color: blue,
      features: [
        'إضافة أصل يدويًا',
        'تسجيل اسم الجهاز وعنوانه',
        'حالة الاتصال وآخر ظهور',
        'تحديد نطاق التفويض',
      ],
    );
  }
}

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionPage(
      icon: Icons.assignment_rounded,
      title: 'المهام',
      description: 'إدارة مهام الفحص والاستجابة ومتابعة حالتها.',
      color: accent,
      features: [
        'إنشاء مهمة',
        'عرض حالة المهمة',
        'تاريخ الإنشاء والتحديث',
        'ربط النتائج بسجل التدقيق',
      ],
    );
  }
}

class VulnerabilitiesPage extends StatelessWidget {
  const VulnerabilitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionPage(
      icon: Icons.bug_report_rounded,
      title: 'الثغرات الأمنية',
      description: 'تجميع النتائج وفرزها حسب الخطورة.',
      color: orange,
      features: [
        'معرّف CVE',
        'درجة الخطورة',
        'الأصول المتأثرة',
        'حالة المعالجة',
        'توصيات الإصلاح',
      ],
    );
  }
}

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionPage(
      icon: Icons.receipt_long_rounded,
      title: 'السجلات والتقارير',
      description: 'مراجعة الأنشطة والنتائج الموثقة.',
      color: blue,
      features: [
        'سجل أحداث المنصة',
        'سجل تغييرات الإعدادات',
        'تاريخ مهام الفحص',
        'تقارير الحوادث والاستعادة',
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionPage(
      icon: Icons.settings_rounded,
      title: 'الإعدادات',
      description: 'إعدادات المنصة والتخزين والاتصال.',
      color: muted,
      features: [
        'إعدادات التخزين المحلي',
        'إعداد الخادم المركزي لاحقًا',
        'إدارة الصلاحيات',
        'إعدادات السجلات والتقارير',
      ],
    );
  }
}

class SectionPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final List<String> features;

  const SectionPage({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: panel,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withOpacity(0.35)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 38),
              const SizedBox(height: 14),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(color: muted, height: 1.6),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const SectionTitle('الوظائف المخططة'),
        const SizedBox(height: 10),
        for (final feature in features)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: panel,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline, color: color),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    feature,
                    style: const TextStyle(height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: panel,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'هذه الوظائف معروضة ضمن مخطط البناء. سيتم تفعيل كل وظيفة وربطها بالبيانات والخدمات في مراحل التطوير التالية.',
            style: TextStyle(color: muted, height: 1.6, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 13),
          Text(
            value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(color: muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: panel,
      margin: const EdgeInsets.only(bottom: 11),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.13),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Text(
            description,
            style: const TextStyle(color: muted, height: 1.5),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
        onTap: onTap,
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: muted, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}