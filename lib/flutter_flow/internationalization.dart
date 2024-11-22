import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['ar', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? arText = '',
    String? enText = '',
  }) =>
      [arText, enText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Registration_Page
  {
    'rkiitnx1': {
      'ar': 'إنشاء حساب جديد',
      'en': 'Create a new account',
    },
    'o672l8ll': {
      'ar': 'أهلاً بك في مكتب يموت للمحاماة',
      'en': 'Welcome to Yamout Law Office',
    },
    'k33eau8n': {
      'ar': 'الاسم الكامل',
      'en': 'full name',
    },
    'gexu8099': {
      'ar': 'البريد الإلكتروني',
      'en': 'e-mail',
    },
    'n1kpxn72': {
      'ar': 'رقم الهاتف',
      'en': 'phone number',
    },
    '6me0ty8o': {
      'ar': 'كلمة المرور',
      'en': 'password',
    },
    'qut4f7eg': {
      'ar': 'تأكيد كلمة المرور',
      'en': 'Confirm password',
    },
    'm4v4ml0y': {
      'ar': 'إنشاء الحساب',
      'en': 'Create account',
    },
    '412hpvnz': {
      'ar': 'أو سجل الدخول باستخدام',
      'en': 'Or log in using',
    },
    'ptarg8cz': {
      'ar': 'لديك حساب بالفعل؟',
      'en': 'Already have an account?',
    },
    'zr0vg1e3': {
      'ar': 'تسجيل الدخول',
      'en': 'Login',
    },
    '7nv0alcu': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': 'All rights reserved © 2024 Yamout Law Office',
    },
  },
  // SignIn_Page
  {
    'f63bwgwk': {
      'ar': 'يموت للمحاماة',
      'en': 'Die for Law',
    },
    'nwie6xxh': {
      'ar': 'تسجيل الدخول',
      'en': 'Login',
    },
    '6gjohxrb': {
      'ar': 'البريد الإلكتروني',
      'en': 'e-mail',
    },
    'o2bp5vyc': {
      'ar': 'كلمة المرور',
      'en': 'password',
    },
    '19tuhtar': {
      'ar': 'تسجيل الدخول',
      'en': 'Login',
    },
    'u9dv7xtt': {
      'ar': 'نسيت كلمة المرور؟',
      'en': 'Forgot your password?',
    },
    'ne3b22di': {
      'ar': 'ليس لديك حساب؟',
      'en': 'Don\'t have an account?',
    },
    'x5mu7zm2': {
      'ar': 'إنشاء حساب',
      'en': 'Create an account',
    },
    'nvivovx8': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': 'All rights reserved © 2024 Yamout Law Office',
    },
  },
  // ClientDashboard
  {
    'aao46v8z': {
      'ar': 'لوحة تحكم العميل',
      'en': 'Client Control Panel',
    },
    'l8pxx19o': {
      'ar': 'رقم القضية:',
      'en': 'Case number:',
    },
    '8xqb10kb': {
      'ar': '2024-002',
      'en': '2024-002',
    },
    '33u9rgsq': {
      'ar': 'اسم العميل:',
      'en': 'Customer Name:',
    },
    'l4wrcezi': {
      'ar': 'محمد عبدالله',
      'en': 'Mohammed Abdullah',
    },
    'z7ha0ukt': {
      'ar': 'الشخص المسؤول:',
      'en': 'Responsible person:',
    },
    'sp9bykb9': {
      'ar': 'أحمد حسن',
      'en': 'Ahmed Hassan',
    },
    'ntcf80np': {
      'ar': 'اسم المحامي:',
      'en': 'Lawyer\'s name:',
    },
    '907geqid': {
      'ar': 'فاطمة علي',
      'en': 'Fatima Ali',
    },
    '1tptfiwx': {
      'ar': 'اسم المحكمة:',
      'en': 'Court Name:',
    },
    'gf7jacnc': {
      'ar': 'محكمة القاهرة الابتدائية',
      'en': 'Cairo Court of First Instance',
    },
    'mc0fza80': {
      'ar': 'اسم القاضي:',
      'en': 'Judge\'s name:',
    },
    'wtn49ahr': {
      'ar': 'القاضي محمود سعيد',
      'en': 'Judge Mahmoud Saeed',
    },
    'f8w5xjdw': {
      'ar': 'نوع الدعوى:',
      'en': 'Type of claim:',
    },
    'lcxv7u5n': {
      'ar': 'قضية مدنية',
      'en': 'Civil case',
    },
    'e1wck3o7': {
      'ar': 'تاريخ تعيين القضية:',
      'en': 'Case appointment date:',
    },
    'u8o24pvr': {
      'ar': '15 يناير 2024',
      'en': 'January 15, 2024',
    },
    '2ev0qp34': {
      'ar': 'معلومات الاتصال',
      'en': 'Contact Information',
    },
    'y2hjqimt': {
      'ar': 'رقم الهاتف:',
      'en': 'phone number:',
    },
    'q73x4ewp': {
      'ar': '02-1234567',
      'en': '02-1234567',
    },
    'ayd63ar4': {
      'ar': 'رقم الجوال:',
      'en': 'Mobile number:',
    },
    '04odn4r4': {
      'ar': '0100-123-4567',
      'en': '0100-123-4567',
    },
    'ql6aentf': {
      'ar': 'البريد الإلكتروني:',
      'en': 'e-mail:',
    },
    'a8t6jdsw': {
      'ar': 'mohamed@example.com',
      'en': 'mohamed@example.com',
    },
    '0k7nukwu': {
      'ar': 'تاريخ الميلاد:',
      'en': 'date of birth:',
    },
    '4l0bmmlg': {
      'ar': '1 يناير 1980',
      'en': 'January 1, 1980',
    },
    'u95spb59': {
      'ar': 'ملخص القضية',
      'en': 'Case Summary',
    },
    'ks9b9n9u': {
      'ar':
          'هذه قضية مدنية تتعلق بنزاع عقاري. يدعي العميل وجود مخالفات في عقد الإيجار وعدم التزام المؤجر بشروط العقد.',
      'en':
          'This is a civil case involving a real estate dispute. The client claims that there are violations in the lease agreement and that the landlord is not complying with the terms of the agreement.',
    },
    'bp42r3w7': {
      'ar': 'تحميل المستندات',
      'en': 'Upload documents',
    },
    'a0426ucf': {
      'ar': 'مواعيد المحكمة وأحكام القاضي',
      'en': 'Court dates and judge\'s rulings',
    },
    'a2uzegc5': {
      'ar': '5 فبراير 2024',
      'en': 'February 5, 2024',
    },
    'w69yb78u': {
      'ar': 'جلسة استماع أولية',
      'en': 'preliminary hearing',
    },
    'w8c767qx': {
      'ar': '20 مارس 2024',
      'en': 'March 20, 2024',
    },
    'efqbinzp': {
      'ar': 'جلسة تقديم الأدلة',
      'en': 'Evidence presentation session',
    },
    'rspqkye9': {
      'ar': 'مصاريف الدعوى والمحامي',
      'en': 'Lawsuit and attorney expenses',
    },
    'cxb242ua': {
      'ar': 'رسوم المحكمة:',
      'en': 'Court fees:',
    },
    'u5ut7ujc': {
      'ar': '5000 جنيه',
      'en': '5000 pounds',
    },
    'qir1sdq2': {
      'ar': 'أتعاب المحامي:',
      'en': 'Attorney\'s fees:',
    },
    'wj7wz3p6': {
      'ar': '10000 جنيه',
      'en': '10000 pounds',
    },
    'vfjw9lcy': {
      'ar': 'مصاريف أخرى:',
      'en': 'Other expenses:',
    },
    '2nsgjuu5': {
      'ar': '2000 جنيه',
      'en': '2000 pounds',
    },
    'dnozw2dl': {
      'ar': 'إضافة دعوى جديدة',
      'en': 'Add a new claim',
    },
  },
  // LawFirmInformationalPage
  {
    'j15cqk7e': {
      'ar': 'مكتب يموت للمحاماة',
      'en': 'Dies Law Office',
    },
    'ktv0xu27': {
      'ar': 'مرحبًا بكم في مكتب يموت للمحاماة',
      'en': 'Welcome to Yamout Law Office',
    },
    '14hm39qx': {
      'ar': 'نقدم خدمات قانونية متميزة لعملائنا منذ أكثر من 20 عامًا',
      'en':
          'We have been providing outstanding legal services to our clients for over 20 years.',
    },
    'bktbh00t': {
      'ar': 'المزيد من المعلومات',
      'en': 'More information',
    },
    'kvyfh7g2': {
      'ar': 'خدماتنا القانونية',
      'en': 'Our Legal Services',
    },
    'z4m74k9b': {
      'ar': 'القانون المدني',
      'en': 'Civil law',
    },
    't2olxuq9': {
      'ar': 'القانون الجنائي',
      'en': 'Criminal law',
    },
    'n2kex1pe': {
      'ar': 'قانون الأسرة',
      'en': 'Family Law',
    },
    'vye15rhz': {
      'ar': 'القانون التجاري',
      'en': 'Commercial Law',
    },
    '5cx35bz1': {
      'ar': 'تعيين محامي',
      'en': 'Appoint a lawyer',
    },
    'n0js1wvm': {
      'ar': 'فريقنا القانوني',
      'en': 'Our Legal Team',
    },
    '57j0nfhu': {
      'ar': 'أحمد يموت',
      'en': 'Ahmed dies',
    },
    'apvm0fc1': {
      'ar': 'سارة خالد',
      'en': 'Sarah Khaled',
    },
    'yt6wibsx': {
      'ar': 'محمد علي',
      'en': 'Muhammad Ali',
    },
    'mbiw0sxk': {
      'ar': 'عرض جميع المحامين',
      'en': 'View all lawyers',
    },
    '8839bexa': {
      'ar': 'طلب استشارة',
      'en': 'Request a consultation',
    },
    '3vfg643u': {
      'ar': 'حجز موعد',
      'en': 'Book an appointment',
    },
    'ctaw1w71': {
      'ar': 'التسجيل الآن',
      'en': 'Register now',
    },
    'rbm5h0zm': {
      'ar': 'تواصل معنا',
      'en': 'Contact us',
    },
    'zz3820ey': {
      'ar': 'هاتف: +966 12 345 6789',
      'en': 'Phone: +966 12 345 6789',
    },
    '1abifzey': {
      'ar': 'البريد الإلكتروني: info@yamoutlaw.com',
      'en': 'Email: info@yamoutlaw.com',
    },
    'xclvipp9': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': 'All rights reserved © 2024 Yamout Law Office',
    },
  },
  // LawyerDashboard
  {
    'icfjedh9': {
      'ar': 'مكتب يموت للمحاماة',
      'en': 'Dies Law Office',
    },
    '7pvvef4g': {
      'ar': 'لوحة التحكم',
      'en': 'Control panel',
    },
    'vrgls602': {
      'ar': 'قضايا العملاء',
      'en': 'Customer issues',
    },
    'ufylecko': {
      'ar': 'مفكرة المحامي',
      'en': 'Lawyer\'s notebook',
    },
    '8e43jcq3': {
      'ar': 'إضافة موعد',
      'en': 'Add an appointment',
    },
    '4y7ajvb1': {
      'ar': 'تقويم المدفوعات',
      'en': 'Payment Calendar',
    },
    'ae1b45n3': {
      'ar': 'تقويم مواعيد القضايا',
      'en': 'Case Calendar',
    },
    'n32ope0g': {
      'ar': 'إضافة قضية جديدة',
      'en': 'Add a new case',
    },
    'xlcxj2du': {
      'ar': 'إحصائيات سريعة',
      'en': 'Quick stats',
    },
    'm6ku8ff7': {
      'ar': 'القضايا النشطة',
      'en': 'Active Issues',
    },
    '2n57na74': {
      'ar': '28',
      'en': '28',
    },
    'zgms4wdi': {
      'ar': 'المواعيد هذا الأسبوع',
      'en': 'Appointments this week',
    },
    'kdt7lyaw': {
      'ar': '12',
      'en': '12',
    },
    'y79fqv58': {
      'ar': 'المدفوعات المستحقة',
      'en': 'Payments Due',
    },
    'cytrnae5': {
      'ar': '٧٥,٠٠٠ ريال',
      'en': '75,000 riyals',
    },
  },
  // SingleLawyerPage
  {
    'hx4gc1mw': {
      'ar': 'د. فاطمة الزهراء',
      'en': 'Dr. Fatima Al Zahra',
    },
    'am28bbmu': {
      'ar': 'شريك رئيسي',
      'en': 'Senior Partner',
    },
    'akk5yewd': {
      'ar': 'نبذة مختصرة',
      'en': 'Brief summary',
    },
    '1ey7lklo': {
      'ar':
          'د. فاطمة الزهراء محامية بارزة مع أكثر من 15 عامًا من الخبرة في مجال قانون الشركات والملكية الفكرية. تتميز بنهجها الاستراتيجي في حل النزاعات القانونية المعقدة وتقديم استشارات قانونية عالية الجودة للشركات المحلية والدولية.',
      'en':
          'Dr. Fatima Al Zahraa is a prominent lawyer with over 15 years of experience in corporate and intellectual property law. She is distinguished by her strategic approach to resolving complex legal disputes and providing high-quality legal advice to local and international companies.',
    },
    'cr7uvbaq': {
      'ar': 'المؤهلات',
      'en': 'Qualifications',
    },
    '0l2792up': {
      'ar': 'دكتوراه في القانون - جامعة القاهرة',
      'en': 'PhD in Law - Cairo University',
    },
    'i31f16wl': {
      'ar': 'ماجستير في قانون الأعمال الدولي - جامعة هارفارد',
      'en': 'LLM in International Business Law - Harvard University',
    },
    'j50s0v5h': {
      'ar': 'عضو نقابة المحامين المصرية',
      'en': 'Member of the Egyptian Bar Association',
    },
    '3nr29byx': {
      'ar': 'محكم معتمد - مركز القاهرة الإقليمي للتحكيم التجاري الدولي',
      'en':
          'Certified Arbitrator - Cairo Regional Centre for International Commercial Arbitration',
    },
    'u2tpi7en': {
      'ar': 'معلومات الاتصال',
      'en': 'Contact Information',
    },
    'm76cddcz': {
      'ar': 'البريد الإلكتروني:',
      'en': 'e-mail:',
    },
    'qlx4cc0z': {
      'ar': 'fatima@lawfirm.com',
      'en': 'fatima@lawfirm.com',
    },
    'zg4ayat3': {
      'ar': 'رقم الهاتف:',
      'en': 'phone number:',
    },
    'e7ru2gxr': {
      'ar': '+20 2 1234 5678',
      'en': '+20 2 1234 5678',
    },
    'mlz4ijvu': {
      'ar': 'المكتب:',
      'en': 'Office:',
    },
    '3xpttdlt': {
      'ar': 'القاهرة، مصر',
      'en': 'Cairo, Egypt',
    },
    'ehx2wp3j': {
      'ar': 'جدولة استشارة',
      'en': 'Schedule a consultation',
    },
    '5aun0ogu': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': 'All rights reserved © 2024 Yamout Law Office',
    },
  },
  // LawyerNotebook
  {
    '4xwg6do7': {
      'ar': 'دفتر المحامي',
      'en': 'Lawyer\'s notebook',
    },
    '58ojbgi3': {
      'ar': 'الأربعاء، 4 يونيو 2024',
      'en': 'Wednesday, June 4, 2024',
    },
    '5n69sa9z': {
      'ar': 'قضية الشركة أ ضد الشركة ب',
      'en': 'Company A vs Company B case',
    },
    's9bhghrw': {
      'ar': 'جلسة استماع',
      'en': 'Hearing session',
    },
    'uj3kdzf9': {
      'ar': '10:00 ص',
      'en': '10:00 AM',
    },
    'bfqi3cx1': {
      'ar': 'استشارة قانونية - السيد محمد',
      'en': 'Legal Consultation - Mr. Mohammed',
    },
    'tor5rbs8': {
      'ar': 'اجتماع',
      'en': 'meeting',
    },
    'oenrpoe5': {
      'ar': '2:00 م',
      'en': '2:00 PM',
    },
    'awbopveb': {
      'ar': 'مراجعة عقد - شركة ج',
      'en': 'Contract Review - Company J',
    },
    'qkbyyn4z': {
      'ar': 'مهمة',
      'en': 'a task',
    },
    'i7jmr97l': {
      'ar': '4:30 م',
      'en': '4:30 PM',
    },
    'dtoergz0': {
      'ar': 'المواعيد القادمة',
      'en': 'Upcoming appointments',
    },
    'i3zn6sgf': {
      'ar': 'اجتماع مع العميل - السيدة فاطمة',
      'en': 'Meeting with the client - Ms. Fatima',
    },
    'yqjgou8w': {
      'ar': 'الخميس، 5 يونيو 2024',
      'en': 'Thursday, June 5, 2024',
    },
    'ex12bd5t': {
      'ar': '11:00 ص',
      'en': '11:00 AM',
    },
    'e0qx700i': {
      'ar': 'تحضير مذكرة قانونية - قضية د',
      'en': 'Preparing a legal memorandum - Case D',
    },
    'wlu7q0eg': {
      'ar': 'الجمعة، 6 يونيو 2024',
      'en': 'Friday, June 6, 2024',
    },
    'szjpgz00': {
      'ar': 'طوال اليوم',
      'en': 'All day long',
    },
    'ftk69bum': {
      'ar': 'جلسة محكمة - قضية هـ',
      'en': 'Court Session - Case H',
    },
    'g2ab4d21': {
      'ar': 'الإثنين، 9 يونيو 2024',
      'en': 'Monday, June 9, 2024',
    },
    'k1qssccp': {
      'ar': '9:00 ص',
      'en': '9:00 AM',
    },
    'nd2pwj44': {
      'ar': 'إضافة موعد جديد',
      'en': 'Add new appointment',
    },
  },
  // CaseDetailsPageLawyerView
  {
    'eel6um7l': {
      'ar': 'تفاصيل القضية',
      'en': 'Case details',
    },
    'l630fc35': {
      'ar': 'رقم القضية:',
      'en': 'Case number:',
    },
    '0fu5tfum': {
      'ar': '2024-003',
      'en': '2024-003',
    },
    '3d3ba3jj': {
      'ar': 'اسم العميل:',
      'en': 'Customer Name:',
    },
    '9o4bu4vn': {
      'ar': 'سارة محمود',
      'en': 'Sarah Mahmoud',
    },
    'mmy7i572': {
      'ar': 'الشخص المسؤول:',
      'en': 'Responsible person:',
    },
    'h797g0km': {
      'ar': 'خالد عبد الرحمن',
      'en': 'Khaled Abdul Rahman',
    },
    'vuoe5kbh': {
      'ar': 'اسم المحامي:',
      'en': 'Lawyer\'s name:',
    },
    'y8tti84q': {
      'ar': 'ليلى حسن',
      'en': 'Laila Hassan',
    },
    'mlr07cx5': {
      'ar': 'اسم المحكمة:',
      'en': 'Court Name:',
    },
    'k9xzhotq': {
      'ar': 'محكمة الإسكندرية الابتدائية',
      'en': 'Alexandria Primary Court',
    },
    '0jfngli5': {
      'ar': 'اسم القاضي:',
      'en': 'Judge\'s name:',
    },
    'j30gt6ex': {
      'ar': 'القاضي أحمد فؤاد',
      'en': 'Judge Ahmed Fouad',
    },
    'd5zi0ghg': {
      'ar': 'نوع الدعوى:',
      'en': 'Type of claim:',
    },
    'qishnmgu': {
      'ar': 'قضية تجارية',
      'en': 'Business case',
    },
    'z2y9nag1': {
      'ar': 'تاريخ تعيين القضية:',
      'en': 'Case appointment date:',
    },
    'rk6cj4ev': {
      'ar': '10 فبراير 2024',
      'en': 'February 10, 2024',
    },
    'uln1z5x2': {
      'ar': 'معلومات الاتصال',
      'en': 'Contact Information',
    },
    'sfe77050': {
      'ar': 'رقم الهاتف:',
      'en': 'phone number:',
    },
    'h9cr375y': {
      'ar': '03-9876543',
      'en': '03-9876543',
    },
    'jqff97f1': {
      'ar': 'رقم الجوال:',
      'en': 'Mobile number:',
    },
    'n3rymhxf': {
      'ar': '0122-987-6543',
      'en': '0122-987-6543',
    },
    'ukjkkrp3': {
      'ar': 'البريد الإلكتروني:',
      'en': 'e-mail:',
    },
    '8zwr7ich': {
      'ar': 'sara@example.com',
      'en': 'sara@example.com',
    },
    '4k2i8ft1': {
      'ar': 'تاريخ الميلاد:',
      'en': 'date of birth:',
    },
    'qseyx2en': {
      'ar': '15 مارس 1985',
      'en': 'March 15, 1985',
    },
    '251k6kcx': {
      'ar': 'ملخص القضية',
      'en': 'Case Summary',
    },
    'iwxd9g59': {
      'ar':
          'هذه قضية تجارية تتعلق بنزاع حول عقد توريد بضائع. تدعي الموكلة أن الطرف الآخر أخل بشروط العقد مما تسبب في خسائر مادية كبيرة لشركتها.',
      'en':
          'This is a commercial case involving a dispute over a contract for the supply of goods. The client claims that the other party breached the terms of the contract, causing her company significant financial losses.',
    },
    'qv3js79r': {
      'ar': 'تحميل المستندات',
      'en': 'Upload documents',
    },
    'i6xxaawp': {
      'ar': 'رفع مستند جديد',
      'en': 'Upload a new document',
    },
    've2xb2ta': {
      'ar': 'مواعيد المحكمة وأحكام القاضي',
      'en': 'Court dates and judge\'s rulings',
    },
    'y3iktxd9': {
      'ar': '1 مارس 2024',
      'en': 'March 1, 2024',
    },
    '1a489qva': {
      'ar': 'جلسة استماع أولية',
      'en': 'preliminary hearing',
    },
    'idvourj7': {
      'ar': '15 أبريل 2024',
      'en': 'April 15, 2024',
    },
    'sefxq44c': {
      'ar': 'جلسة تقديم الأدلة',
      'en': 'Evidence presentation session',
    },
    'gxur3kcv': {
      'ar': '10 مايو 2024',
      'en': 'May 10, 2024',
    },
    'ndrh4erf': {
      'ar': 'جلسة استماع للشهود',
      'en': 'Witness hearing',
    },
    'w1b9h3uz': {
      'ar': 'إضافة موعد جديد',
      'en': 'Add new appointment',
    },
    'kdt0mftn': {
      'ar': 'مصاريف الدعوى والمحامي',
      'en': 'Lawsuit and attorney expenses',
    },
    'i5q3ae6f': {
      'ar': 'رسوم المحكمة:',
      'en': 'Court fees:',
    },
    'xnvwk5rb': {
      'ar': '7500 جنيه',
      'en': '7500 pounds',
    },
    'lzksj85w': {
      'ar': 'أتعاب المحامي:',
      'en': 'Attorney\'s fees:',
    },
    'przxhcge': {
      'ar': '15000 جنيه',
      'en': '15000 pounds',
    },
    '2n465eif': {
      'ar': 'مصاريف أخرى:',
      'en': 'Other expenses:',
    },
    'vfwll1ec': {
      'ar': '3000 جنيه',
      'en': '3000 pounds',
    },
    '3bf3gboc': {
      'ar': 'إجمالي المصاريف:',
      'en': 'Total expenses:',
    },
    'nnsfx334': {
      'ar': '25500 جنيه',
      'en': '25500 pounds',
    },
    'xkyadis3': {
      'ar': 'تحديث معلومات القضية',
      'en': 'Update case information',
    },
  },
  // LawyerPaymentsView
  {
    'yxhq9kfo': {
      'ar': 'إدارة المدفوعات',
      'en': 'Payment Management',
    },
    'um7xtg55': {
      'ar': 'التقويم المالي',
      'en': 'Financial Calendar',
    },
    'opz2knlm': {
      'ar': 'تفاصيل المدفوعات',
      'en': 'Payment details',
    },
    'hhosjvgl': {
      'ar': 'قضية رقم ٢٠٢٤-٠٠٥',
      'en': 'Case No. 2024-005',
    },
    '49qf8zlk': {
      'ar': 'شركة الفا للتجارة',
      'en': 'Alpha Trading Company',
    },
    '93gijtk0': {
      'ar': '١٠,٠٠٠ ريال',
      'en': '10,000 riyals',
    },
    'rpmho49l': {
      'ar': '٤ فبراير ٢٠٢٤',
      'en': 'February 4, 2024',
    },
    '2kmx6h8e': {
      'ar': 'قضية رقم ٢٠٢٤-٠٠٣',
      'en': 'Case No. 2024-003',
    },
    '3wdp175z': {
      'ar': 'محمد عبدالله',
      'en': 'Mohammed Abdullah',
    },
    '6ri90cfw': {
      'ar': '٥,٠٠٠ ريال',
      'en': '5,000 riyals',
    },
    'v9q93goi': {
      'ar': '١٠ فبراير ٢٠٢٤',
      'en': 'February 10, 2024',
    },
    'jxfx1xem': {
      'ar': 'المصروفات',
      'en': 'Expenses',
    },
    'l39j7vqo': {
      'ar': 'إجمالي المصروفات',
      'en': 'Total expenses',
    },
    'e8wexac0': {
      'ar': '٣,٥٠٠ ريال',
      'en': '3,500 riyals',
    },
    'u51wykt5': {
      'ar': 'يناير',
      'en': 'January',
    },
    'k8oed03o': {
      'ar': 'فبراير',
      'en': 'February',
    },
    'n50og8wk': {
      'ar': 'مارس',
      'en': 'March',
    },
    'n84bnm8k': {
      'ar': 'أبريل',
      'en': 'April',
    },
    'j4tvgsch': {
      'ar': 'مايو',
      'en': 'May',
    },
    'p4tx6mht': {
      'ar': 'إضافة مدفوعات جديدة',
      'en': 'Add new payments',
    },
  },
  // NotificationPage
  {
    'pbb3c34t': {
      'ar': 'إعدادات الإشعارات',
      'en': 'Notification settings',
    },
    's7nb3gxq': {
      'ar': 'إشعارات العملاء',
      'en': 'Customer Notifications',
    },
    'vv0r1ceh': {
      'ar': 'واتساب',
      'en': 'WhatsApp',
    },
    'jrb1s5ps': {
      'ar': 'البريد الإلكتروني',
      'en': 'e-mail',
    },
    '9fu9jhj1': {
      'ar': 'إشعارات الدفع',
      'en': 'Push Notifications',
    },
    'ndp1o2md': {
      'ar': 'إضافة إلى التقويم',
      'en': 'Add to calendar',
    },
    '6ldvto97': {
      'ar': 'تقويم أندرويد',
      'en': 'Android Calendar',
    },
    'huinsg8w': {
      'ar': 'تقويم آيفون',
      'en': 'iPhone Calendar',
    },
    'hemmnp4p': {
      'ar': 'إرسال رسائل جماعية',
      'en': 'Send bulk messages',
    },
    '8fb1hi2m': {
      'ar': 'عنوان الرسالة',
      'en': 'Message Title',
    },
    'hkqo11gv': {
      'ar': 'نص الرسالة',
      'en': 'Message text',
    },
    'shuw5qg5': {
      'ar': 'إرفاق ملف',
      'en': 'Attach file',
    },
    'z39t12zk': {
      'ar': 'إرسال للعملاء',
      'en': 'Send to customers',
    },
    'w0lh8fqe': {
      'ar': 'إعدادات متقدمة',
      'en': 'Advanced Settings',
    },
    'wfre7nax': {
      'ar': 'تفعيل الإشعارات الصوتية',
      'en': 'Enable sound notifications',
    },
    'snwkth2u': {
      'ar': 'عرض معاينة الرسائل',
      'en': 'Show message preview',
    },
    'fpk09x0h': {
      'ar': 'حفظ التغييرات',
      'en': 'Save changes',
    },
    'b5vp83gc': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': 'All rights reserved © 2024 Yamout Law Office',
    },
  },
  // AdminDashboard
  {
    'l1rwdxns': {
      'ar': 'لوحة التحكم',
      'en': 'Control panel',
    },
    'zk26af9o': {
      'ar': 'نظرة عامة',
      'en': 'Overview',
    },
    'nwu3ndtz': {
      'ar': 'القضايا النشطة',
      'en': 'Active Issues',
    },
    'mfxeuuzm': {
      'ar': '78',
      'en': '78',
    },
    'bgucml3w': {
      'ar': 'العملاء',
      'en': 'Clients',
    },
    'x3xmacj8': {
      'ar': '156',
      'en': '156',
    },
    'b4kozdd5': {
      'ar': 'المحامون',
      'en': 'Lawyers',
    },
    'mhc67m84': {
      'ar': '12',
      'en': '12',
    },
    'mqv8yqyy': {
      'ar': 'الوصول السريع',
      'en': 'Quick access',
    },
    '4zrzawzo': {
      'ar': 'إدارة المستخدمين',
      'en': 'User management',
    },
    '9fntvjbe': {
      'ar': 'إدارة القضايا',
      'en': 'Case Management',
    },
    'q40u7quo': {
      'ar': 'جدول المواعيد',
      'en': 'schedule',
    },
    'oczs9zir': {
      'ar': 'حالة القضايا',
      'en': 'Case status',
    },
    'yfxk2kv2': {
      'ar': 'قيد النظر',
      'en': 'Under consideration',
    },
    'y50fcxh2': {
      'ar': '32',
      'en': '32',
    },
    'zd7r7cjt': {
      'ar': 'جارية',
      'en': 'ongoing',
    },
    'yqzpdwld': {
      'ar': '41',
      'en': '41',
    },
    'p0sbtnfa': {
      'ar': 'مغلقة',
      'en': 'Closed',
    },
    'i5vnbdka': {
      'ar': '5',
      'en': '5',
    },
    'zdbtl7sh': {
      'ar': 'المواعيد القادمة',
      'en': 'Upcoming appointments',
    },
    'phqg5fjw': {
      'ar': 'جلسة محكمة - قضية رقم 2024/001',
      'en': 'Court Session - Case No. 2024/001',
    },
    'oh1pvcly': {
      'ar': '15 مايو 2024',
      'en': 'May 15, 2024',
    },
    'dcpxz34y': {
      'ar': 'قريب',
      'en': 'close',
    },
    '9u1r1eom': {
      'ar': 'اجتماع مع العميل - شركة الفا',
      'en': 'Meeting with the client - Alpha Company',
    },
    'hoidflez': {
      'ar': '20 مايو 2024',
      'en': 'May 20, 2024',
    },
    'xvcsn1dh': {
      'ar': 'قادم',
      'en': 'coming',
    },
    'rnk1irmh': {
      'ar': 'ملخص المدفوعات',
      'en': 'Payment Summary',
    },
    'ifre7mvs': {
      'ar': 'إجمالي الدخل',
      'en': 'Total income',
    },
    'bnkhpw4r': {
      'ar': '500,000 د.إ',
      'en': '500,000 AED',
    },
    'evaj4vs1': {
      'ar': 'مستحقات',
      'en': 'Dues',
    },
    'cmmkj2z3': {
      'ar': '75,000 د.إ',
      'en': '75,000 AED',
    },
    'ty7ttq2z': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': 'All rights reserved © 2024 Yamout Law Office',
    },
  },
  // UserManagement
  {
    'm03m63tl': {
      'ar': 'إدارة المستخدمين',
      'en': 'User management',
    },
    'ih6n1lfu': {
      'ar': 'إدارة العملاء والمحامين والموظفين',
      'en': 'Client, Lawyer and Staff Management',
    },
    'mb8q5kv6': {
      'ar': 'إدارة العملاء',
      'en': 'Customer Management',
    },
    'go7fscxg': {
      'ar': 'بحث عن عميل',
      'en': 'Search for a client',
    },
    '03buyls6': {
      'ar': 'أحمد محمد',
      'en': 'Ahmed Mohammed',
    },
    'ugdbb4gt': {
      'ar': 'ahmed@example.com',
      'en': 'ahmed@example.com',
    },
    '6w0ai8iv': {
      'ar': 'تعديل',
      'en': 'amendment',
    },
    'raee0rvf': {
      'ar': 'تفعيل',
      'en': 'activation',
    },
    '9mpe7nqb': {
      'ar': ' تعيين كلمة المرور',
      'en': 'Set password',
    },
    'k86d2xxv': {
      'ar': 'فاطمة علي',
      'en': 'Fatima Ali',
    },
    'y7t1ikiq': {
      'ar': 'fatima@example.com',
      'en': 'fatima@example.com',
    },
    '2ok7bqcv': {
      'ar': 'تعديل',
      'en': 'amendment',
    },
    'q0ba4kl1': {
      'ar': 'تعطيل',
      'en': 'Disable',
    },
    '4f1jfrbo': {
      'ar': ' تعيين كلمة المرور',
      'en': 'Set password',
    },
    'cflv3i3q': {
      'ar': 'إدارة المحامين',
      'en': 'Lawyers Management',
    },
    'nwyc05t8': {
      'ar': 'بحث عن محامي',
      'en': 'Search for a lawyer',
    },
    '4ol2pumt': {
      'ar': 'محمد خالد',
      'en': 'Mohamed Khaled',
    },
    '1e74dyh0': {
      'ar': 'القانون التجاري',
      'en': 'Commercial Law',
    },
    'm74fkpgf': {
      'ar': 'تعديل الملف',
      'en': 'Edit file',
    },
    'y3ha4pxj': {
      'ar': 'تعيين قضية',
      'en': 'Assign a case',
    },
    '5gokmzrv': {
      'ar': 'سارة أحمد',
      'en': 'Sarah Ahmed',
    },
    'frqa49hc': {
      'ar': 'قانون الأسرة',
      'en': 'Family Law',
    },
    'sag8anmc': {
      'ar': 'تعديل الملف',
      'en': 'Edit file',
    },
    '2padia88': {
      'ar': 'تعيين قضية',
      'en': 'Assign a case',
    },
    'vvk04mll': {
      'ar': 'إضافة محامي جديد',
      'en': 'Add a new lawyer',
    },
    'tguwndwv': {
      'ar': 'إدارة الموظفين',
      'en': 'Staff Management',
    },
    '0tg5nbbz': {
      'ar': 'بحث عن موظف',
      'en': 'Search for an employee',
    },
    'cmx1d6fy': {
      'ar': 'ليلى عمر',
      'en': 'Laila Omar',
    },
    'q2pigy65': {
      'ar': 'سكرتيرة',
      'en': 'secretary',
    },
    '66503d1w': {
      'ar': 'تعديل الصلاحيات',
      'en': 'Modify permissions',
    },
    'uz7v6xy0': {
      'ar': 'تعديل الملف',
      'en': 'Edit file',
    },
    'xlt7zdyl': {
      'ar': 'كريم حسن',
      'en': 'Karim Hassan',
    },
    'oif60du8': {
      'ar': 'محاسب',
      'en': 'accountant',
    },
    'tph2gil8': {
      'ar': 'تعديل الصلاحيات',
      'en': 'Modify permissions',
    },
    '9sl9c0r2': {
      'ar': 'تعديل الملف',
      'en': 'Edit file',
    },
    '5ft5td8o': {
      'ar': 'إضافة موظف جديد',
      'en': 'Add a new employee',
    },
    'tdk20v38': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': 'All rights reserved © 2024 Yamout Law Office',
    },
  },
  // CaseManagement
  {
    'qgynb3xe': {
      'ar': 'إدارة القضايا',
      'en': 'Case Management',
    },
    'dr3d4bz0': {
      'ar': 'تتبع وإدارة جميع القضايا',
      'en': 'Track and manage all issues',
    },
    '6a9xj18a': {
      'ar': 'تصفية القضايا',
      'en': 'Clearing cases',
    },
    '0210r8zh': {
      'ar': 'نشطة',
      'en': 'Active',
    },
    'xlym36p8': {
      'ar': 'مؤرشفة',
      'en': 'Archived',
    },
    '3hscfd24': {
      'ar': 'العميل',
      'en': 'Client',
    },
    'os7x5znm': {
      'ar': 'المحامي',
      'en': 'Lawyer',
    },
    'pxtl0arp': {
      'ar': 'نوع القضية',
      'en': 'Case type',
    },
    '47k8khxt': {
      'ar': 'القضايا النشطة',
      'en': 'Active Issues',
    },
    '1mh1577n': {
      'ar': 'قضية رقم 2024-001',
      'en': 'Case No. 2024-001',
    },
    '04la1fcn': {
      'ar': 'نشطة',
      'en': 'Active',
    },
    'f3f9io6h': {
      'ar': 'العميل: شركة الأمل للتجارة',
      'en': 'Client: Al Amal Trading Company',
    },
    'yvj8h1e6': {
      'ar': 'المحامي: أحمد محمود',
      'en': 'Lawyer: Ahmed Mahmoud',
    },
    'o7yjux26': {
      'ar': 'نوع القضية: نزاع تجاري',
      'en': 'Case Type: Commercial Dispute',
    },
    't7esaftm': {
      'ar': 'تعديل',
      'en': 'amendment',
    },
    'cdgtua4g': {
      'ar': 'المستندات',
      'en': 'Documents',
    },
    'qmep3wzc': {
      'ar': 'التقدم',
      'en': 'Progress',
    },
    'u71lmxjf': {
      'ar': 'قضية رقم 2024-002',
      'en': 'Case No. 2024-002',
    },
    'aibppqbj': {
      'ar': 'قيد المراجعة',
      'en': 'Under review',
    },
    'ofo16mr8': {
      'ar': 'العميل: محمد علي',
      'en': 'Client: Mohamed Ali',
    },
    'fk52qw70': {
      'ar': 'المحامي: سارة حسن',
      'en': 'Lawyer: Sarah Hassan',
    },
    'fzr8bgtl': {
      'ar': 'نوع القضية: قضية عمالية',
      'en': 'Case Type: Labor Case',
    },
    'nj6n91s9': {
      'ar': 'تعديل',
      'en': 'amendment',
    },
    'ovy3rya4': {
      'ar': 'المستندات',
      'en': 'Documents',
    },
    '0xjrwydp': {
      'ar': 'التقدم',
      'en': 'Progress',
    },
    '1ynhnxy6': {
      'ar': 'المواعيد القادمة',
      'en': 'Upcoming appointments',
    },
    'o8u6sgeo': {
      'ar': 'جلسة محكمة - قضية رقم 2024-001',
      'en': 'Court Session - Case No. 2024-001',
    },
    'o0kmbo5b': {
      'ar': '20 مايو، 2024 - 9:00 ص',
      'en': 'May 20, 2024 - 9:00 AM',
    },
    'cjowz95f': {
      'ar': 'اجتماع مع العميل - قضية رقم 2024-002',
      'en': 'Meeting with Client - Case No. 2024-002',
    },
    'ep3c7hx6': {
      'ar': '22 مايو، 2024 - 11:00 ص',
      'en': 'May 22, 2024 - 11:00 AM',
    },
    '4sdr2bua': {
      'ar': 'إضافة قضية جديدة',
      'en': 'Add a new case',
    },
    'n7pzu8ff': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': 'All rights reserved © 2024 Yamout Law Office',
    },
  },
  // DocumentManagement
  {
    'zgme7559': {
      'ar': 'إدارة الوثائق',
      'en': 'Document management',
    },
    '47ys62em': {
      'ar': 'مستودع الوثائق',
      'en': 'Document repository',
    },
    's9mhwdeh': {
      'ar': 'بحث في الوثائق...',
      'en': 'Search documents...',
    },
    '2d0gdjze': {
      'ar': 'عقود',
      'en': 'Contracts',
    },
    'aqrst7pz': {
      'ar': 'مذكرات قانونية',
      'en': 'Legal Notes',
    },
    'dyw3yeag': {
      'ar': 'قضايا',
      'en': 'Issues',
    },
    'hui8jwfy': {
      'ar': 'وثائق إدارية',
      'en': 'Administrative documents',
    },
    'njagems8': {
      'ar': 'عقد توظيف - شركة الفا',
      'en': 'Employment Contract - Alpha Company',
    },
    'p3vjtj4t': {
      'ar': 'تم الرفع بواسطة: أحمد محمد',
      'en': 'Uploaded by: Ahmed Mohamed',
    },
    '9l89qc99': {
      'ar': 'مذكرة دفاع - قضية رقم 123',
      'en': 'Defense Memorandum - Case No. 123',
    },
    'nqjniqye': {
      'ar': 'تم الرفع بواسطة: فاطمة علي',
      'en': 'Uploaded by: Fatima Ali',
    },
    'fg93i5a1': {
      'ar': 'لائحة دعوى - قضية رقم 456',
      'en': 'Lawsuit - Case No. 456',
    },
    'ult5bezo': {
      'ar': 'تم الرفع بواسطة: خالد عمر',
      'en': 'Uploaded by: Khaled Omar',
    },
    '4yawnobn': {
      'ar': 'إحصائيات الوثائق',
      'en': 'Document Statistics',
    },
    'yoftivxu': {
      'ar': 'إجمالي الوثائق',
      'en': 'Total documents',
    },
    'l7j7yw4d': {
      'ar': '1,234',
      'en': '1,234',
    },
    '541fyy2q': {
      'ar': 'بانتظار المراجعة',
      'en': 'Waiting for review',
    },
    '38omyr3j': {
      'ar': '28',
      'en': '28',
    },
    'ibru28pc': {
      'ar': 'تمت الموافقة',
      'en': 'Approved',
    },
    'm2zfmgl8': {
      'ar': '1,156',
      'en': '1,156',
    },
    'lc207e1f': {
      'ar': 'رفع وثيقة جديدة',
      'en': 'Upload new document',
    },
  },
  // NotificationsCommunicationSettings
  {
    'vv45hz3l': {
      'ar': 'إعدادات التواصل',
      'en': 'Communication settings',
    },
    'b5r7qhw5': {
      'ar': 'إدارة قوالب الإشعارات وتخصيص التنبيهات',
      'en': 'Manage notification templates and customize alerts',
    },
    '9zjbgchl': {
      'ar': 'قوالب الإشعارات',
      'en': 'Notification templates',
    },
    'm8cfyjzw': {
      'ar': 'واتساب',
      'en': 'WhatsApp',
    },
    'b2mtda0w': {
      'ar': 'تكوين قالب رسائل واتساب',
      'en': 'Create a WhatsApp message template',
    },
    'v3n3hqj8': {
      'ar': 'البريد الإلكتروني',
      'en': 'e-mail',
    },
    '33ewyt6p': {
      'ar': 'تخصيص قوالب البريد الإلكتروني',
      'en': 'Customize email templates',
    },
    'd9mztkv7': {
      'ar': 'إشعارات الدفع',
      'en': 'Push Notifications',
    },
    '96zzr9o4': {
      'ar': 'إعداد إشعارات التطبيق',
      'en': 'Set up app notifications',
    },
    'tmfq1fpv': {
      'ar': 'إعدادات التنبيهات العامة',
      'en': 'General Notification Settings',
    },
    'r3e8ur8z': {
      'ar': 'تنبيهات الجلسات',
      'en': 'Session Alerts',
    },
    'svb693we': {
      'ar': 'تذكيرات المواعيد',
      'en': 'Appointment Reminders',
    },
    'n9814cgt': {
      'ar': 'تحديثات القضايا',
      'en': 'Case Updates',
    },
    '35vwe65p': {
      'ar': 'الرسائل الجماعية',
      'en': 'Bulk messages',
    },
    'bptv3h1m': {
      'ar': 'عنوان الرسالة',
      'en': 'Message Title',
    },
    'dk7px73t': {
      'ar': 'نص الرسالة',
      'en': 'Message text',
    },
    'iw26cv7a': {
      'ar': 'إضافة مرفقات',
      'en': 'Add attachments',
    },
    'd2lhe91b': {
      'ar': 'إرسال',
      'en': 'send',
    },
    'gwsjvsl2': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': 'All rights reserved © 2024 Yamout Law Office',
    },
  },
  // AppointmentCalendarManagement
  {
    '8gqhkv71': {
      'ar': 'إدارة التقويم',
      'en': 'Calendar management',
    },
    'axnbd0si': {
      'ar': 'جدولة وإدارة المواعيد',
      'en': 'Scheduling and managing appointments',
    },
    'wdijtrvo': {
      'ar': 'التقويم',
      'en': 'Calendar',
    },
    'qb7mq81k': {
      'ar': 'المواعيد القادمة',
      'en': 'Upcoming appointments',
    },
    'sktwos8u': {
      'ar': 'إضافة موعد',
      'en': 'Add an appointment',
    },
    '8xd6t9h9': {
      'ar': 'اجتماع مع العميل أحمد',
      'en': 'Meeting with client Ahmed',
    },
    'xr5b8xh1': {
      'ar': '15 يونيو 2024 - 10:00 ص',
      'en': 'June 15, 2024 - 10:00 AM',
    },
    '9v5c6855': {
      'ar': 'جلسة محكمة - قضية رقم 123',
      'en': 'Court Session - Case No. 123',
    },
    'qv5tu5on': {
      'ar': '20 يونيو 2024 - 11:30 ص',
      'en': 'June 20, 2024 - 11:30 AM',
    },
    'x19agrio': {
      'ar': 'مزامنة التقويم',
      'en': 'Calendar sync',
    },
    '9egk5ky5': {
      'ar': 'مزامنة مع Google Calendar',
      'en': 'Sync with Google Calendar',
    },
    'vrld5sls': {
      'ar': 'مزامنة مع Outlook',
      'en': 'Sync with Outlook',
    },
    'wogpnzbg': {
      'ar': 'التذكيرات',
      'en': 'Reminders',
    },
    'uls8qez5': {
      'ar': 'تذكير قبل الموعد بـ',
      'en': 'Reminder before appointment',
    },
    '97fkf8c0': {
      'ar': '30 دقيقة',
      'en': '30 minutes',
    },
    'jmom7xc1': {
      'ar': 'حفظ الإعدادات',
      'en': 'Save settings',
    },
    'r3idjp8p': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': 'All rights reserved © 2024 Yamout Law Office',
    },
  },
  // PaymentandFinancialOverview
  {
    'sb893b8o': {
      'ar': 'النظرة المالية',
      'en': 'Financial outlook',
    },
    'voorwj8m': {
      'ar': 'ملخص مالي',
      'en': 'Financial Summary',
    },
    'dyknlw1b': {
      'ar': 'إجمالي الإيرادات',
      'en': 'Total Revenue',
    },
    'nr9fg9an': {
      'ar': '١٥٠,٠٠٠ ريال',
      'en': '150,000 riyals',
    },
    '35aakrsq': {
      'ar': 'إجمالي المصروفات',
      'en': 'Total expenses',
    },
    'atsourao': {
      'ar': '٧٥,٠٠٠ ريال',
      'en': '75,000 riyals',
    },
    'mgp2uw46': {
      'ar': 'جدول المدفوعات',
      'en': 'Payment schedule',
    },
    '0fdwuvvt': {
      'ar': 'العميل',
      'en': 'Client',
    },
    'v0ie371h': {
      'ar': 'المبلغ',
      'en': 'Amount',
    },
    '3zmsjj6l': {
      'ar': 'تاريخ الاستحقاق',
      'en': 'due date',
    },
    'bdzwurdv': {
      'ar': 'أحمد محمد',
      'en': 'Ahmed Mohammed',
    },
    'f5fzvv9d': {
      'ar': '٥,٠٠٠ ريال',
      'en': '5,000 riyals',
    },
    'tn2vs6xh': {
      'ar': '٢٠٢٤/٠٥/١٥',
      'en': '05/15/2024',
    },
    '36itrp14': {
      'ar': 'فاطمة علي',
      'en': 'Fatima Ali',
    },
    '4zkbxcue': {
      'ar': '٧,٥٠٠ ريال',
      'en': '7,500 riyals',
    },
    '84p430xx': {
      'ar': '٢٠٢٤/٠٥/٢٠',
      'en': '05/20/2024',
    },
    'xpy0o14m': {
      'ar': 'عرض الكل',
      'en': 'Show all',
    },
    'f8zp5vrv': {
      'ar': 'مصروفات القضايا والمحامين',
      'en': 'Case and lawyer expenses',
    },
    'z9xkmnsc': {
      'ar': 'القضية/المحامي',
      'en': 'Case/Lawyer',
    },
    'qvlxhumb': {
      'ar': 'المبلغ',
      'en': 'Amount',
    },
    '5xo5zauq': {
      'ar': 'قضية رقم ٢٣٤',
      'en': 'Case No. 234',
    },
    'r4ykicpm': {
      'ar': '٣,٠٠٠ ريال',
      'en': '3,000 riyals',
    },
    'nhtc0jgq': {
      'ar': 'المحامي خالد',
      'en': 'Lawyer Khaled',
    },
    'o2i8pt5g': {
      'ar': '٥,٥٠٠ ريال',
      'en': '5,500 riyals',
    },
    'ohftactb': {
      'ar': 'إضافة مصروف',
      'en': 'Add expense',
    },
    'fcdlx1za': {
      'ar': 'التقارير المالية',
      'en': 'Financial reports',
    },
    't1oijo25': {
      'ar': 'تقرير شهري',
      'en': 'Monthly report',
    },
    'g83d5sof': {
      'ar': 'يناير ٢٠٢٤',
      'en': 'January 2024',
    },
    '1tiy1u80': {
      'ar': 'تحميل',
      'en': 'download',
    },
    '5w5l18hq': {
      'ar': 'تقرير ربع سنوي',
      'en': 'Quarterly Report',
    },
    'ang21ayo': {
      'ar': 'الربع الأول ٢٠٢٤',
      'en': 'Q1 2024',
    },
    'hp9jdbhj': {
      'ar': 'تحميل',
      'en': 'download',
    },
    'mtmlxvt4': {
      'ar': 'إنشاء تقرير مخصص',
      'en': 'Create a custom report',
    },
    'oq7k2aer': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': 'All rights reserved © 2024 Yamout Law Office',
    },
  },
  // ReportsandAnalytics
  {
    'pgksdy4s': {
      'ar': 'التقارير والتحليلات',
      'en': 'Reports and Analysis',
    },
    'tm0lvi8n': {
      'ar': 'إدارة وتحليل بيانات المكتب',
      'en': 'Office data management and analysis',
    },
    '71uu3l5k': {
      'ar': 'إنشاء تقرير مخصص',
      'en': 'Create a custom report',
    },
    'yo6jjpqh': {
      'ar': 'نوع التقرير',
      'en': 'Report Type',
    },
    'qbkhkub8': {
      'ar': 'اختر نوع التقرير',
      'en': 'Select report type',
    },
    'ik81q200': {
      'ar': 'الفترة الزمنية',
      'en': 'Time period',
    },
    '7ur0t9xi': {
      'ar': 'حدد الفترة',
      'en': 'Specify the period',
    },
    '3kto2h91': {
      'ar': 'إنشاء التقرير',
      'en': 'Create report',
    },
    '30slmzfb': {
      'ar': 'نظرة عامة على النشاط',
      'en': 'Activity Overview',
    },
    'eq6p9umq': {
      'ar': 'القضايا النشطة',
      'en': 'Active Issues',
    },
    '1z9pwm9g': {
      'ar': '78',
      'en': '78',
    },
    'u3rgjmhr': {
      'ar': 'المحامون النشطون',
      'en': 'Active Lawyers',
    },
    '8vwiwont': {
      'ar': '12',
      'en': '12',
    },
    'tl1lx6lg': {
      'ar': 'العملاء الجدد',
      'en': 'New clients',
    },
    'xd5k7cdb': {
      'ar': '23',
      'en': '23',
    },
    '7mkh53jh': {
      'ar': 'تحليل الإشعارات والتفاعل',
      'en': 'Notification and engagement analysis',
    },
    'vfdxz7mz': {
      'ar': 'معدل فتح الإشعارات',
      'en': 'Notification open rate',
    },
    'a7v57gln': {
      'ar': '68%',
      'en': '68%',
    },
    '626euwvp': {
      'ar': 'معدل الاستجابة',
      'en': 'Response rate',
    },
    'ghbfu1oj': {
      'ar': '92%',
      'en': '92%',
    },
    'ds7bjsbz': {
      'ar': 'رسم بياني لتفاعل المستخدمين',
      'en': 'User interaction chart',
    },
    'msdrpr7n': {
      'ar': 'التقدم المالي',
      'en': 'Financial progress',
    },
    'idkaste2': {
      'ar': 'رسم بياني للإيرادات والمصروفات',
      'en': 'Revenue and Expense Chart',
    },
    'nxwr2oo4': {
      'ar': 'إجمالي الإيرادات',
      'en': 'Total Revenue',
    },
    '9qief6y7': {
      'ar': '1,250,000 ر.س',
      'en': '1,250,000 SAR',
    },
    'ffm1iy7r': {
      'ar': 'إجمالي المصروفات',
      'en': 'Total expenses',
    },
    'qqlb6o2z': {
      'ar': '850,000 ر.س',
      'en': '850,000 SAR',
    },
    'p165tf5p': {
      'ar': 'أداء المحامين',
      'en': 'Lawyers\' performance',
    },
    '522lqr9x': {
      'ar': 'رسم بياني لعبء العمل وإنجاز القضايا',
      'en': 'Workload and Case Completion Chart',
    },
    'ejpxejce': {
      'ar': 'عرض التفاصيل',
      'en': 'Show details',
    },
    'ki580q93': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': 'All rights reserved © 2024 Yamout Law Office',
    },
  },
  // SystemSettings
  {
    'usnn8a3b': {
      'ar': 'إعدادات النظام',
      'en': 'System Settings',
    },
    'tjidncwr': {
      'ar': 'إدارة الأدوار والصلاحيات',
      'en': 'Role and Permission Management',
    },
    'qkihd3d0': {
      'ar': 'تكوين الأدوار',
      'en': 'Role formation',
    },
    'kiact0id': {
      'ar': 'تعيين مستويات الوصول',
      'en': 'Set access levels',
    },
    '3knv4mzb': {
      'ar': 'إضافة دور جديد',
      'en': 'Add new role',
    },
    'l933tg3u': {
      'ar': 'إدارة القوالب القانونية',
      'en': 'Legal Template Management',
    },
    'zycfjf7k': {
      'ar': 'قوالب العقود',
      'en': 'Contract templates',
    },
    'dicusckh': {
      'ar': 'قوالب الدعاوى',
      'en': 'lawsuit templates',
    },
    'klsn6y52': {
      'ar': 'قوالب الاستشارات',
      'en': 'Consulting templates',
    },
    '6luk0o00': {
      'ar': 'إضافة قالب جديد',
      'en': 'Add new template',
    },
    'tqq7qo6s': {
      'ar': 'سياسات البيانات والخصوصية',
      'en': 'Data and Privacy Policies',
    },
    '23dcjpdl': {
      'ar': 'سياسة الخصوصية',
      'en': 'privacy policy',
    },
    'qhp5a7ip': {
      'ar': 'شروط الاستخدام',
      'en': 'terms of use',
    },
    'atxoycn7': {
      'ar': 'سياسة الاحتفاظ بالبيانات',
      'en': 'Data Retention Policy',
    },
    'gnc52bs6': {
      'ar': 'تحديث السياسات',
      'en': 'Policy Update',
    },
    'n3unx4rh': {
      'ar': 'النسخ الاحتياطي والتصدير',
      'en': 'Backup and Export',
    },
    'm3om4t00': {
      'ar': 'إنشاء نسخة احتياطية',
      'en': 'Create a backup',
    },
    'sc5fbg93': {
      'ar': 'استعادة من نسخة احتياطية',
      'en': 'Restore from backup',
    },
    'j7raphzo': {
      'ar': 'تصدير البيانات',
      'en': 'Export data',
    },
    'rxu85xzg': {
      'ar': 'جدولة النسخ الاحتياطي التلقائي',
      'en': 'Schedule automatic backup',
    },
    's8gmhv8b': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': 'All rights reserved © 2024 Yamout Law Office',
    },
  },
  // FeedbackandSupport
  {
    'jkvozdl8': {
      'ar': 'لوحة التحكم',
      'en': 'Control panel',
    },
    'jw67lj95': {
      'ar': 'ملاحظات العملاء والمحامين',
      'en': 'Client and Lawyer Feedback',
    },
    'o7vfsdaf': {
      'ar': 'أحمد محمد',
      'en': 'Ahmed Mohammed',
    },
    'gxpsd9u0': {
      'ar': 'خدمة ممتازة وسريعة',
      'en': 'Excellent and fast service',
    },
    'h3709m8x': {
      'ar': 'عميل',
      'en': 'client',
    },
    '7z7qsfog': {
      'ar': 'سارة أحمد',
      'en': 'Sarah Ahmed',
    },
    'w74gon3c': {
      'ar': 'تجربة إيجابية مع المكتب',
      'en': 'Positive experience with the office',
    },
    'iu9px7o4': {
      'ar': 'محامي',
      'en': 'lawyer',
    },
    'ek4hg54d': {
      'ar': 'تذاكر الدعم',
      'en': 'Support Tickets',
    },
    'rcvqpfrn': {
      'ar': 'مشكلة في تسجيل الدخول',
      'en': 'Problem logging in',
    },
    'ooorrffb': {
      'ar': 'لم أتمكن من تسجيل الدخول...',
      'en': 'I couldn\'t log in...',
    },
    'xm7zznzs': {
      'ar': 'الرد',
      'en': 'Reply',
    },
    'mr9hfa6i': {
      'ar': 'استفسار عن الخدمات',
      'en': 'Inquiry about services',
    },
    'xfxk8rgc': {
      'ar': 'هل يمكنكم توضيح الخدمات...',
      'en': 'Can you please explain the services...',
    },
    'v11munvz': {
      'ar': 'الرد',
      'en': 'Reply',
    },
    'cfwj2qb1': {
      'ar': 'الأسئلة الشائعة والأدلة',
      'en': 'FAQs & Guides',
    },
    'jpzrwdkh': {
      'ar': 'الأسئلة الشائعة',
      'en': 'Frequently Asked Questions',
    },
    'kffim7ri': {
      'ar': 'دليل المستخدم',
      'en': 'User Manual',
    },
    'lyt7o89b': {
      'ar': 'إضافة محتوى جديد',
      'en': 'Add new content',
    },
  },
  // Miscellaneous
  {
    'k1leozod': {
      'ar':
          'The app needs access to your photo library to allow you to upload important documents or images related to your cases. Your privacy and data security are our top priorities.',
      'en':
          'The app needs access to your photo library to allow you to upload important documents or images related to your cases. Your privacy and data security are our top priorities.',
    },
    'cirb7ekk': {
      'ar':
          'We would like to send you notifications about important updates, reminders, and alerts related to your cases. This ensures you stay informed in real-time.',
      'en':
          'We would like to send you notifications about important updates, reminders, and alerts related to your cases. This ensures you stay informed in real-time.',
    },
    '2lmi231r': {
      'ar':
          'We request access to your location to provide you with relevant legal services and updates based on your current whereabouts. This feature will enhance your experience with location-specific information.',
      'en':
          'We request access to your location to provide you with relevant legal services and updates based on your current whereabouts. This feature will enhance your experience with location-specific information.',
    },
    's19rv7ct': {
      'ar':
          'The app requires access to your camera to allow you to take photos of documents and evidence directly from your device for case submissions. Your privacy is important to us.',
      'en':
          'The app requires access to your camera to allow you to take photos of documents and evidence directly from your device for case submissions. Your privacy is important to us.',
    },
    'qj743fsf': {
      'ar':
          'We would like to use your biometric data (fingerprint/face recognition) to securely log you into the app. This allows for a faster and safer user experience.',
      'en':
          'We would like to use your biometric data (fingerprint/face recognition) to securely log you into the app. This allows for a faster and safer user experience.',
    },
    '4vadcpg7': {
      'ar':
          'We request access to your calendar to schedule important events, court dates, and reminders related to your cases. This will help you keep track of key dates easily.',
      'en':
          'We request access to your calendar to schedule important events, court dates, and reminders related to your cases. This will help you keep track of key dates easily.',
    },
    'qvowow4c': {
      'ar':
          'We request access to your microphone to facilitate online calls and communication with your lawyer. This feature will enhance your ability to discuss your case in real-time and ensure a smoother experience.',
      'en':
          'We request access to your microphone to facilitate online calls and communication with your lawyer. This feature will enhance your ability to discuss your case in real-time and ensure a smoother experience.',
    },
    'xzuhzagf': {
      'ar':
          'We would like to access your contacts to enable easy sharing of important information with your legal team and facilitate communication. This will help you stay connected and ensure that we can reach you when necessary.',
      'en':
          'We would like to access your contacts to enable easy sharing of important information with your legal team and communication. This will help you stay connected and ensure that we can reach you when necessary.',
    },
    'zpado2df': {
      'ar': '',
      'en': '',
    },
    'amv6cka2': {
      'ar': '',
      'en': '',
    },
    'mlqbhq1t': {
      'ar': '',
      'en': '',
    },
    '3860tpft': {
      'ar': '',
      'en': '',
    },
    'e6c2gmgx': {
      'ar': '',
      'en': '',
    },
    '9rzihx04': {
      'ar': '',
      'en': '',
    },
    'ycg45p51': {
      'ar': '',
      'en': '',
    },
    'sz9pg2vw': {
      'ar': '',
      'en': '',
    },
    'c2wmqjqj': {
      'ar': '',
      'en': '',
    },
    'fc4bnjn2': {
      'ar': '',
      'en': '',
    },
    '8qej6g3a': {
      'ar': '',
      'en': '',
    },
    'skzjm6q7': {
      'ar': '',
      'en': '',
    },
    '8olhmt12': {
      'ar': '',
      'en': '',
    },
    '78a42n1h': {
      'ar': '',
      'en': '',
    },
    'ddark0ss': {
      'ar': '',
      'en': '',
    },
    'tbekm4ty': {
      'ar': '',
      'en': '',
    },
    'lzen0xbj': {
      'ar': '',
      'en': '',
    },
    'h6y5otz8': {
      'ar': '',
      'en': '',
    },
    'vuniqelp': {
      'ar': '',
      'en': '',
    },
    '41sqr51v': {
      'ar': '',
      'en': '',
    },
    '6waprfkt': {
      'ar': '',
      'en': '',
    },
    'phf8zfax': {
      'ar': '',
      'en': '',
    },
    'mfzvuzin': {
      'ar': '',
      'en': '',
    },
    'lkcmx9sb': {
      'ar': '',
      'en': '',
    },
    'x4jhs7cc': {
      'ar': '',
      'en': '',
    },
  },
].reduce((a, b) => a..addAll(b));
