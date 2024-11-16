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
      'en': '',
    },
    'o672l8ll': {
      'ar': 'أهلاً بك في مكتب يموت للمحاماة',
      'en': '',
    },
    'k33eau8n': {
      'ar': 'الاسم الكامل',
      'en': '',
    },
    'gexu8099': {
      'ar': 'البريد الإلكتروني',
      'en': '',
    },
    'n1kpxn72': {
      'ar': 'رقم الهاتف',
      'en': '',
    },
    '6me0ty8o': {
      'ar': 'كلمة المرور',
      'en': '',
    },
    'm4v4ml0y': {
      'ar': 'إنشاء الحساب',
      'en': '',
    },
    '412hpvnz': {
      'ar': 'أو سجل الدخول باستخدام',
      'en': '',
    },
    'ptarg8cz': {
      'ar': 'لديك حساب بالفعل؟',
      'en': '',
    },
    'zr0vg1e3': {
      'ar': 'تسجيل الدخول',
      'en': '',
    },
    '7nv0alcu': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': '',
    },
  },
  // SignIn_Page
  {
    'f63bwgwk': {
      'ar': 'يموت للمحاماة',
      'en': '',
    },
    'nwie6xxh': {
      'ar': 'تسجيل الدخول',
      'en': '',
    },
    '6gjohxrb': {
      'ar': 'البريد الإلكتروني',
      'en': '',
    },
    'o2bp5vyc': {
      'ar': 'كلمة المرور',
      'en': '',
    },
    '19tuhtar': {
      'ar': 'تسجيل الدخول',
      'en': '',
    },
    'u9dv7xtt': {
      'ar': 'نسيت كلمة المرور؟',
      'en': '',
    },
    'ne3b22di': {
      'ar': 'ليس لديك حساب؟',
      'en': '',
    },
    'x5mu7zm2': {
      'ar': 'إنشاء حساب',
      'en': '',
    },
    'nvivovx8': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': '',
    },
  },
  // ClientDashboard
  {
    'aao46v8z': {
      'ar': 'لوحة تحكم العميل',
      'en': '',
    },
    'l8pxx19o': {
      'ar': 'رقم القضية:',
      'en': '',
    },
    '8xqb10kb': {
      'ar': '2024-002',
      'en': '',
    },
    '33u9rgsq': {
      'ar': 'اسم العميل:',
      'en': '',
    },
    'l4wrcezi': {
      'ar': 'محمد عبدالله',
      'en': '',
    },
    'z7ha0ukt': {
      'ar': 'الشخص المسؤول:',
      'en': '',
    },
    'sp9bykb9': {
      'ar': 'أحمد حسن',
      'en': '',
    },
    'ntcf80np': {
      'ar': 'اسم المحامي:',
      'en': '',
    },
    '907geqid': {
      'ar': 'فاطمة علي',
      'en': '',
    },
    '1tptfiwx': {
      'ar': 'اسم المحكمة:',
      'en': '',
    },
    'gf7jacnc': {
      'ar': 'محكمة القاهرة الابتدائية',
      'en': '',
    },
    'mc0fza80': {
      'ar': 'اسم القاضي:',
      'en': '',
    },
    'wtn49ahr': {
      'ar': 'القاضي محمود سعيد',
      'en': '',
    },
    'f8w5xjdw': {
      'ar': 'نوع الدعوى:',
      'en': '',
    },
    'lcxv7u5n': {
      'ar': 'قضية مدنية',
      'en': '',
    },
    'e1wck3o7': {
      'ar': 'تاريخ تعيين القضية:',
      'en': '',
    },
    'u8o24pvr': {
      'ar': '15 يناير 2024',
      'en': '',
    },
    '2ev0qp34': {
      'ar': 'معلومات الاتصال',
      'en': '',
    },
    'y2hjqimt': {
      'ar': 'رقم الهاتف:',
      'en': '',
    },
    'q73x4ewp': {
      'ar': '02-1234567',
      'en': '',
    },
    'ayd63ar4': {
      'ar': 'رقم الجوال:',
      'en': '',
    },
    '04odn4r4': {
      'ar': '0100-123-4567',
      'en': '',
    },
    'ql6aentf': {
      'ar': 'البريد الإلكتروني:',
      'en': '',
    },
    'a8t6jdsw': {
      'ar': 'mohamed@example.com',
      'en': '',
    },
    '0k7nukwu': {
      'ar': 'تاريخ الميلاد:',
      'en': '',
    },
    '4l0bmmlg': {
      'ar': '1 يناير 1980',
      'en': '',
    },
    'u95spb59': {
      'ar': 'ملخص القضية',
      'en': '',
    },
    'ks9b9n9u': {
      'ar':
          'هذه قضية مدنية تتعلق بنزاع عقاري. يدعي العميل وجود مخالفات في عقد الإيجار وعدم التزام المؤجر بشروط العقد.',
      'en': '',
    },
    'bp42r3w7': {
      'ar': 'تحميل المستندات',
      'en': '',
    },
    'a0426ucf': {
      'ar': 'مواعيد المحكمة وأحكام القاضي',
      'en': '',
    },
    'a2uzegc5': {
      'ar': '5 فبراير 2024',
      'en': '',
    },
    'w69yb78u': {
      'ar': 'جلسة استماع أولية',
      'en': '',
    },
    'w8c767qx': {
      'ar': '20 مارس 2024',
      'en': '',
    },
    'efqbinzp': {
      'ar': 'جلسة تقديم الأدلة',
      'en': '',
    },
    'rspqkye9': {
      'ar': 'مصاريف الدعوى والمحامي',
      'en': '',
    },
    'cxb242ua': {
      'ar': 'رسوم المحكمة:',
      'en': '',
    },
    'u5ut7ujc': {
      'ar': '5000 جنيه',
      'en': '',
    },
    'qir1sdq2': {
      'ar': 'أتعاب المحامي:',
      'en': '',
    },
    'wj7wz3p6': {
      'ar': '10000 جنيه',
      'en': '',
    },
    'vfjw9lcy': {
      'ar': 'مصاريف أخرى:',
      'en': '',
    },
    '2nsgjuu5': {
      'ar': '2000 جنيه',
      'en': '',
    },
    'dnozw2dl': {
      'ar': 'إضافة دعوى جديدة',
      'en': '',
    },
  },
  // LawFirmInformationalPage
  {
    'j15cqk7e': {
      'ar': 'مكتب يموت للمحاماة',
      'en': '',
    },
    'ktv0xu27': {
      'ar': 'مرحبًا بكم في مكتب يموت للمحاماة',
      'en': '',
    },
    '14hm39qx': {
      'ar': 'نقدم خدمات قانونية متميزة لعملائنا منذ أكثر من 20 عامًا',
      'en': '',
    },
    'bktbh00t': {
      'ar': 'المزيد من المعلومات',
      'en': '',
    },
    'kvyfh7g2': {
      'ar': 'خدماتنا القانونية',
      'en': '',
    },
    'z4m74k9b': {
      'ar': 'القانون المدني',
      'en': '',
    },
    't2olxuq9': {
      'ar': 'القانون الجنائي',
      'en': '',
    },
    'n2kex1pe': {
      'ar': 'قانون الأسرة',
      'en': '',
    },
    'vye15rhz': {
      'ar': 'القانون التجاري',
      'en': '',
    },
    '5cx35bz1': {
      'ar': 'تعيين محامي',
      'en': '',
    },
    'n0js1wvm': {
      'ar': 'فريقنا القانوني',
      'en': '',
    },
    '57j0nfhu': {
      'ar': 'أحمد يموت',
      'en': '',
    },
    'apvm0fc1': {
      'ar': 'سارة خالد',
      'en': '',
    },
    'yt6wibsx': {
      'ar': 'محمد علي',
      'en': '',
    },
    'mbiw0sxk': {
      'ar': 'عرض جميع المحامين',
      'en': '',
    },
    '8839bexa': {
      'ar': 'طلب استشارة',
      'en': '',
    },
    '3vfg643u': {
      'ar': 'حجز موعد',
      'en': '',
    },
    'ctaw1w71': {
      'ar': 'التسجيل الآن',
      'en': '',
    },
    'rbm5h0zm': {
      'ar': 'تواصل معنا',
      'en': '',
    },
    'zz3820ey': {
      'ar': 'هاتف: +966 12 345 6789',
      'en': '',
    },
    '1abifzey': {
      'ar': 'البريد الإلكتروني: info@yamoutlaw.com',
      'en': '',
    },
    'xclvipp9': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': '',
    },
  },
  // LawyerDashboard
  {
    'icfjedh9': {
      'ar': 'مكتب يموت للمحاماة',
      'en': '',
    },
    '7pvvef4g': {
      'ar': 'لوحة التحكم',
      'en': '',
    },
    'vrgls602': {
      'ar': 'قضايا العملاء',
      'en': '',
    },
    'ufylecko': {
      'ar': 'مفكرة المحامي',
      'en': '',
    },
    '8e43jcq3': {
      'ar': 'إضافة موعد',
      'en': '',
    },
    '4y7ajvb1': {
      'ar': 'تقويم المدفوعات',
      'en': '',
    },
    'ae1b45n3': {
      'ar': 'تقويم مواعيد القضايا',
      'en': '',
    },
    'n32ope0g': {
      'ar': 'إضافة قضية جديدة',
      'en': '',
    },
    'xlcxj2du': {
      'ar': 'إحصائيات سريعة',
      'en': '',
    },
    'm6ku8ff7': {
      'ar': 'القضايا النشطة',
      'en': '',
    },
    '2n57na74': {
      'ar': '28',
      'en': '',
    },
    'zgms4wdi': {
      'ar': 'المواعيد هذا الأسبوع',
      'en': '',
    },
    'kdt7lyaw': {
      'ar': '12',
      'en': '',
    },
    'y79fqv58': {
      'ar': 'المدفوعات المستحقة',
      'en': '',
    },
    'cytrnae5': {
      'ar': '٧٥,٠٠٠ ريال',
      'en': '',
    },
  },
  // SingleLawyerPage
  {
    'hx4gc1mw': {
      'ar': 'د. فاطمة الزهراء',
      'en': '',
    },
    'am28bbmu': {
      'ar': 'شريك رئيسي',
      'en': '',
    },
    'akk5yewd': {
      'ar': 'نبذة مختصرة',
      'en': '',
    },
    '1ey7lklo': {
      'ar':
          'د. فاطمة الزهراء محامية بارزة مع أكثر من 15 عامًا من الخبرة في مجال قانون الشركات والملكية الفكرية. تتميز بنهجها الاستراتيجي في حل النزاعات القانونية المعقدة وتقديم استشارات قانونية عالية الجودة للشركات المحلية والدولية.',
      'en': '',
    },
    'cr7uvbaq': {
      'ar': 'المؤهلات',
      'en': '',
    },
    '0l2792up': {
      'ar': 'دكتوراه في القانون - جامعة القاهرة',
      'en': '',
    },
    'i31f16wl': {
      'ar': 'ماجستير في قانون الأعمال الدولي - جامعة هارفارد',
      'en': '',
    },
    'j50s0v5h': {
      'ar': 'عضو نقابة المحامين المصرية',
      'en': '',
    },
    '3nr29byx': {
      'ar': 'محكم معتمد - مركز القاهرة الإقليمي للتحكيم التجاري الدولي',
      'en': '',
    },
    'u2tpi7en': {
      'ar': 'معلومات الاتصال',
      'en': '',
    },
    'm76cddcz': {
      'ar': 'البريد الإلكتروني:',
      'en': '',
    },
    'qlx4cc0z': {
      'ar': 'fatima@lawfirm.com',
      'en': '',
    },
    'zg4ayat3': {
      'ar': 'رقم الهاتف:',
      'en': '',
    },
    'e7ru2gxr': {
      'ar': '+20 2 1234 5678',
      'en': '',
    },
    'mlz4ijvu': {
      'ar': 'المكتب:',
      'en': '',
    },
    '3xpttdlt': {
      'ar': 'القاهرة، مصر',
      'en': '',
    },
    'ehx2wp3j': {
      'ar': 'جدولة استشارة',
      'en': '',
    },
    '5aun0ogu': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': '',
    },
  },
  // LawyerNotebook
  {
    '4xwg6do7': {
      'ar': 'دفتر المحامي',
      'en': '',
    },
    '58ojbgi3': {
      'ar': 'الأربعاء، 4 يونيو 2024',
      'en': '',
    },
    '5n69sa9z': {
      'ar': 'قضية الشركة أ ضد الشركة ب',
      'en': '',
    },
    's9bhghrw': {
      'ar': 'جلسة استماع',
      'en': '',
    },
    'uj3kdzf9': {
      'ar': '10:00 ص',
      'en': '',
    },
    'bfqi3cx1': {
      'ar': 'استشارة قانونية - السيد محمد',
      'en': '',
    },
    'tor5rbs8': {
      'ar': 'اجتماع',
      'en': '',
    },
    'oenrpoe5': {
      'ar': '2:00 م',
      'en': '',
    },
    'awbopveb': {
      'ar': 'مراجعة عقد - شركة ج',
      'en': '',
    },
    'qkbyyn4z': {
      'ar': 'مهمة',
      'en': '',
    },
    'i7jmr97l': {
      'ar': '4:30 م',
      'en': '',
    },
    'dtoergz0': {
      'ar': 'المواعيد القادمة',
      'en': '',
    },
    'i3zn6sgf': {
      'ar': 'اجتماع مع العميل - السيدة فاطمة',
      'en': '',
    },
    'yqjgou8w': {
      'ar': 'الخميس، 5 يونيو 2024',
      'en': '',
    },
    'ex12bd5t': {
      'ar': '11:00 ص',
      'en': '',
    },
    'e0qx700i': {
      'ar': 'تحضير مذكرة قانونية - قضية د',
      'en': '',
    },
    'wlu7q0eg': {
      'ar': 'الجمعة، 6 يونيو 2024',
      'en': '',
    },
    'szjpgz00': {
      'ar': 'طوال اليوم',
      'en': '',
    },
    'ftk69bum': {
      'ar': 'جلسة محكمة - قضية هـ',
      'en': '',
    },
    'g2ab4d21': {
      'ar': 'الإثنين، 9 يونيو 2024',
      'en': '',
    },
    'k1qssccp': {
      'ar': '9:00 ص',
      'en': '',
    },
    'nd2pwj44': {
      'ar': 'إضافة موعد جديد',
      'en': '',
    },
  },
  // CaseDetailsPageLawyerView
  {
    'eel6um7l': {
      'ar': 'تفاصيل القضية',
      'en': '',
    },
    'l630fc35': {
      'ar': 'رقم القضية:',
      'en': '',
    },
    '0fu5tfum': {
      'ar': '2024-003',
      'en': '',
    },
    '3d3ba3jj': {
      'ar': 'اسم العميل:',
      'en': '',
    },
    '9o4bu4vn': {
      'ar': 'سارة محمود',
      'en': '',
    },
    'mmy7i572': {
      'ar': 'الشخص المسؤول:',
      'en': '',
    },
    'h797g0km': {
      'ar': 'خالد عبد الرحمن',
      'en': '',
    },
    'vuoe5kbh': {
      'ar': 'اسم المحامي:',
      'en': '',
    },
    'y8tti84q': {
      'ar': 'ليلى حسن',
      'en': '',
    },
    'mlr07cx5': {
      'ar': 'اسم المحكمة:',
      'en': '',
    },
    'k9xzhotq': {
      'ar': 'محكمة الإسكندرية الابتدائية',
      'en': '',
    },
    '0jfngli5': {
      'ar': 'اسم القاضي:',
      'en': '',
    },
    'j30gt6ex': {
      'ar': 'القاضي أحمد فؤاد',
      'en': '',
    },
    'd5zi0ghg': {
      'ar': 'نوع الدعوى:',
      'en': '',
    },
    'qishnmgu': {
      'ar': 'قضية تجارية',
      'en': '',
    },
    'z2y9nag1': {
      'ar': 'تاريخ تعيين القضية:',
      'en': '',
    },
    'rk6cj4ev': {
      'ar': '10 فبراير 2024',
      'en': '',
    },
    'uln1z5x2': {
      'ar': 'معلومات الاتصال',
      'en': '',
    },
    'sfe77050': {
      'ar': 'رقم الهاتف:',
      'en': '',
    },
    'h9cr375y': {
      'ar': '03-9876543',
      'en': '',
    },
    'jqff97f1': {
      'ar': 'رقم الجوال:',
      'en': '',
    },
    'n3rymhxf': {
      'ar': '0122-987-6543',
      'en': '',
    },
    'ukjkkrp3': {
      'ar': 'البريد الإلكتروني:',
      'en': '',
    },
    '8zwr7ich': {
      'ar': 'sara@example.com',
      'en': '',
    },
    '4k2i8ft1': {
      'ar': 'تاريخ الميلاد:',
      'en': '',
    },
    'qseyx2en': {
      'ar': '15 مارس 1985',
      'en': '',
    },
    '251k6kcx': {
      'ar': 'ملخص القضية',
      'en': '',
    },
    'iwxd9g59': {
      'ar':
          'هذه قضية تجارية تتعلق بنزاع حول عقد توريد بضائع. تدعي الموكلة أن الطرف الآخر أخل بشروط العقد مما تسبب في خسائر مادية كبيرة لشركتها.',
      'en': '',
    },
    'qv3js79r': {
      'ar': 'تحميل المستندات',
      'en': '',
    },
    'i6xxaawp': {
      'ar': 'رفع مستند جديد',
      'en': '',
    },
    've2xb2ta': {
      'ar': 'مواعيد المحكمة وأحكام القاضي',
      'en': '',
    },
    'y3iktxd9': {
      'ar': '1 مارس 2024',
      'en': '',
    },
    '1a489qva': {
      'ar': 'جلسة استماع أولية',
      'en': '',
    },
    'idvourj7': {
      'ar': '15 أبريل 2024',
      'en': '',
    },
    'sefxq44c': {
      'ar': 'جلسة تقديم الأدلة',
      'en': '',
    },
    'gxur3kcv': {
      'ar': '10 مايو 2024',
      'en': '',
    },
    'ndrh4erf': {
      'ar': 'جلسة استماع للشهود',
      'en': '',
    },
    'w1b9h3uz': {
      'ar': 'إضافة موعد جديد',
      'en': '',
    },
    'kdt0mftn': {
      'ar': 'مصاريف الدعوى والمحامي',
      'en': '',
    },
    'i5q3ae6f': {
      'ar': 'رسوم المحكمة:',
      'en': '',
    },
    'xnvwk5rb': {
      'ar': '7500 جنيه',
      'en': '',
    },
    'lzksj85w': {
      'ar': 'أتعاب المحامي:',
      'en': '',
    },
    'przxhcge': {
      'ar': '15000 جنيه',
      'en': '',
    },
    '2n465eif': {
      'ar': 'مصاريف أخرى:',
      'en': '',
    },
    'vfwll1ec': {
      'ar': '3000 جنيه',
      'en': '',
    },
    '3bf3gboc': {
      'ar': 'إجمالي المصاريف:',
      'en': '',
    },
    'nnsfx334': {
      'ar': '25500 جنيه',
      'en': '',
    },
    'xkyadis3': {
      'ar': 'تحديث معلومات القضية',
      'en': '',
    },
  },
  // LawyerPaymentsView
  {
    'yxhq9kfo': {
      'ar': 'إدارة المدفوعات',
      'en': '',
    },
    'um7xtg55': {
      'ar': 'التقويم المالي',
      'en': '',
    },
    'opz2knlm': {
      'ar': 'تفاصيل المدفوعات',
      'en': '',
    },
    'hhosjvgl': {
      'ar': 'قضية رقم ٢٠٢٤-٠٠٥',
      'en': '',
    },
    '49qf8zlk': {
      'ar': 'شركة الفا للتجارة',
      'en': '',
    },
    '93gijtk0': {
      'ar': '١٠,٠٠٠ ريال',
      'en': '',
    },
    'rpmho49l': {
      'ar': '٤ فبراير ٢٠٢٤',
      'en': '',
    },
    '2kmx6h8e': {
      'ar': 'قضية رقم ٢٠٢٤-٠٠٣',
      'en': '',
    },
    '3wdp175z': {
      'ar': 'محمد عبدالله',
      'en': '',
    },
    '6ri90cfw': {
      'ar': '٥,٠٠٠ ريال',
      'en': '',
    },
    'v9q93goi': {
      'ar': '١٠ فبراير ٢٠٢٤',
      'en': '',
    },
    'jxfx1xem': {
      'ar': 'المصروفات',
      'en': '',
    },
    'l39j7vqo': {
      'ar': 'إجمالي المصروفات',
      'en': '',
    },
    'e8wexac0': {
      'ar': '٣,٥٠٠ ريال',
      'en': '',
    },
    'u51wykt5': {
      'ar': 'يناير',
      'en': '',
    },
    'k8oed03o': {
      'ar': 'فبراير',
      'en': '',
    },
    'n50og8wk': {
      'ar': 'مارس',
      'en': '',
    },
    'n84bnm8k': {
      'ar': 'أبريل',
      'en': '',
    },
    'j4tvgsch': {
      'ar': 'مايو',
      'en': '',
    },
    'p4tx6mht': {
      'ar': 'إضافة مدفوعات جديدة',
      'en': '',
    },
  },
  // NotificationPage
  {
    'pbb3c34t': {
      'ar': 'إعدادات الإشعارات',
      'en': '',
    },
    's7nb3gxq': {
      'ar': 'إشعارات العملاء',
      'en': '',
    },
    'vv0r1ceh': {
      'ar': 'واتساب',
      'en': '',
    },
    'jrb1s5ps': {
      'ar': 'البريد الإلكتروني',
      'en': '',
    },
    '9fu9jhj1': {
      'ar': 'إشعارات الدفع',
      'en': '',
    },
    'ndp1o2md': {
      'ar': 'إضافة إلى التقويم',
      'en': '',
    },
    '6ldvto97': {
      'ar': 'تقويم أندرويد',
      'en': '',
    },
    'huinsg8w': {
      'ar': 'تقويم آيفون',
      'en': '',
    },
    'hemmnp4p': {
      'ar': 'إرسال رسائل جماعية',
      'en': '',
    },
    '8fb1hi2m': {
      'ar': 'عنوان الرسالة',
      'en': '',
    },
    'hkqo11gv': {
      'ar': 'نص الرسالة',
      'en': '',
    },
    'shuw5qg5': {
      'ar': 'إرفاق ملف',
      'en': '',
    },
    'z39t12zk': {
      'ar': 'إرسال للعملاء',
      'en': '',
    },
    'w0lh8fqe': {
      'ar': 'إعدادات متقدمة',
      'en': '',
    },
    'wfre7nax': {
      'ar': 'تفعيل الإشعارات الصوتية',
      'en': '',
    },
    'snwkth2u': {
      'ar': 'عرض معاينة الرسائل',
      'en': '',
    },
    'fpk09x0h': {
      'ar': 'حفظ التغييرات',
      'en': '',
    },
    'b5vp83gc': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': '',
    },
  },
  // AdminDashboard
  {
    'l1rwdxns': {
      'ar': 'لوحة التحكم',
      'en': '',
    },
    'zk26af9o': {
      'ar': 'نظرة عامة',
      'en': '',
    },
    'nwu3ndtz': {
      'ar': 'القضايا النشطة',
      'en': '',
    },
    'mfxeuuzm': {
      'ar': '78',
      'en': '',
    },
    'bgucml3w': {
      'ar': 'العملاء',
      'en': '',
    },
    'x3xmacj8': {
      'ar': '156',
      'en': '',
    },
    'b4kozdd5': {
      'ar': 'المحامون',
      'en': '',
    },
    'mhc67m84': {
      'ar': '12',
      'en': '',
    },
    'mqv8yqyy': {
      'ar': 'الوصول السريع',
      'en': '',
    },
    '4zrzawzo': {
      'ar': 'إدارة المستخدمين',
      'en': '',
    },
    '9fntvjbe': {
      'ar': 'إدارة القضايا',
      'en': '',
    },
    'q40u7quo': {
      'ar': 'جدول المواعيد',
      'en': '',
    },
    'oczs9zir': {
      'ar': 'حالة القضايا',
      'en': '',
    },
    'yfxk2kv2': {
      'ar': 'قيد النظر',
      'en': '',
    },
    'y50fcxh2': {
      'ar': '32',
      'en': '',
    },
    'zd7r7cjt': {
      'ar': 'جارية',
      'en': '',
    },
    'yqzpdwld': {
      'ar': '41',
      'en': '',
    },
    'p0sbtnfa': {
      'ar': 'مغلقة',
      'en': '',
    },
    'i5vnbdka': {
      'ar': '5',
      'en': '',
    },
    'zdbtl7sh': {
      'ar': 'المواعيد القادمة',
      'en': '',
    },
    'phqg5fjw': {
      'ar': 'جلسة محكمة - قضية رقم 2024/001',
      'en': '',
    },
    'oh1pvcly': {
      'ar': '15 مايو 2024',
      'en': '',
    },
    'dcpxz34y': {
      'ar': 'قريب',
      'en': '',
    },
    '9u1r1eom': {
      'ar': 'اجتماع مع العميل - شركة الفا',
      'en': '',
    },
    'hoidflez': {
      'ar': '20 مايو 2024',
      'en': '',
    },
    'xvcsn1dh': {
      'ar': 'قادم',
      'en': '',
    },
    'rnk1irmh': {
      'ar': 'ملخص المدفوعات',
      'en': '',
    },
    'ifre7mvs': {
      'ar': 'إجمالي الدخل',
      'en': '',
    },
    'bnkhpw4r': {
      'ar': '500,000 د.إ',
      'en': '',
    },
    'evaj4vs1': {
      'ar': 'مستحقات',
      'en': '',
    },
    'cmmkj2z3': {
      'ar': '75,000 د.إ',
      'en': '',
    },
    'ty7ttq2z': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': '',
    },
  },
  // UserManagement
  {
    'm03m63tl': {
      'ar': 'إدارة المستخدمين',
      'en': '',
    },
    'ih6n1lfu': {
      'ar': 'إدارة العملاء والمحامين والموظفين',
      'en': '',
    },
    'mb8q5kv6': {
      'ar': 'إدارة العملاء',
      'en': '',
    },
    'go7fscxg': {
      'ar': 'بحث عن عميل',
      'en': '',
    },
    '03buyls6': {
      'ar': 'أحمد محمد',
      'en': '',
    },
    'ugdbb4gt': {
      'ar': 'ahmed@example.com',
      'en': '',
    },
    '6w0ai8iv': {
      'ar': 'تعديل',
      'en': '',
    },
    'raee0rvf': {
      'ar': 'تفعيل',
      'en': '',
    },
    '9mpe7nqb': {
      'ar': ' تعيين كلمة المرور',
      'en': '',
    },
    'k86d2xxv': {
      'ar': 'فاطمة علي',
      'en': '',
    },
    'y7t1ikiq': {
      'ar': 'fatima@example.com',
      'en': '',
    },
    '2ok7bqcv': {
      'ar': 'تعديل',
      'en': '',
    },
    'q0ba4kl1': {
      'ar': 'تعطيل',
      'en': '',
    },
    '4f1jfrbo': {
      'ar': ' تعيين كلمة المرور',
      'en': '',
    },
    'cflv3i3q': {
      'ar': 'إدارة المحامين',
      'en': '',
    },
    'nwyc05t8': {
      'ar': 'بحث عن محامي',
      'en': '',
    },
    '4ol2pumt': {
      'ar': 'محمد خالد',
      'en': '',
    },
    '1e74dyh0': {
      'ar': 'القانون التجاري',
      'en': '',
    },
    'm74fkpgf': {
      'ar': 'تعديل الملف',
      'en': '',
    },
    'y3ha4pxj': {
      'ar': 'تعيين قضية',
      'en': '',
    },
    '5gokmzrv': {
      'ar': 'سارة أحمد',
      'en': '',
    },
    'frqa49hc': {
      'ar': 'قانون الأسرة',
      'en': '',
    },
    'sag8anmc': {
      'ar': 'تعديل الملف',
      'en': '',
    },
    '2padia88': {
      'ar': 'تعيين قضية',
      'en': '',
    },
    'vvk04mll': {
      'ar': 'إضافة محامي جديد',
      'en': '',
    },
    'tguwndwv': {
      'ar': 'إدارة الموظفين',
      'en': '',
    },
    '0tg5nbbz': {
      'ar': 'بحث عن موظف',
      'en': '',
    },
    'cmx1d6fy': {
      'ar': 'ليلى عمر',
      'en': '',
    },
    'q2pigy65': {
      'ar': 'سكرتيرة',
      'en': '',
    },
    '66503d1w': {
      'ar': 'تعديل الصلاحيات',
      'en': '',
    },
    'uz7v6xy0': {
      'ar': 'تعديل الملف',
      'en': '',
    },
    'xlt7zdyl': {
      'ar': 'كريم حسن',
      'en': '',
    },
    'oif60du8': {
      'ar': 'محاسب',
      'en': '',
    },
    'tph2gil8': {
      'ar': 'تعديل الصلاحيات',
      'en': '',
    },
    '9sl9c0r2': {
      'ar': 'تعديل الملف',
      'en': '',
    },
    '5ft5td8o': {
      'ar': 'إضافة موظف جديد',
      'en': '',
    },
    'tdk20v38': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': '',
    },
  },
  // CaseManagement
  {
    'qgynb3xe': {
      'ar': 'إدارة القضايا',
      'en': '',
    },
    'dr3d4bz0': {
      'ar': 'تتبع وإدارة جميع القضايا',
      'en': '',
    },
    '6a9xj18a': {
      'ar': 'تصفية القضايا',
      'en': '',
    },
    '0210r8zh': {
      'ar': 'نشطة',
      'en': '',
    },
    'xlym36p8': {
      'ar': 'مؤرشفة',
      'en': '',
    },
    '3hscfd24': {
      'ar': 'العميل',
      'en': '',
    },
    'os7x5znm': {
      'ar': 'المحامي',
      'en': '',
    },
    'pxtl0arp': {
      'ar': 'نوع القضية',
      'en': '',
    },
    '47k8khxt': {
      'ar': 'القضايا النشطة',
      'en': '',
    },
    '1mh1577n': {
      'ar': 'قضية رقم 2024-001',
      'en': '',
    },
    '04la1fcn': {
      'ar': 'نشطة',
      'en': '',
    },
    'f3f9io6h': {
      'ar': 'العميل: شركة الأمل للتجارة',
      'en': '',
    },
    'yvj8h1e6': {
      'ar': 'المحامي: أحمد محمود',
      'en': '',
    },
    'o7yjux26': {
      'ar': 'نوع القضية: نزاع تجاري',
      'en': '',
    },
    't7esaftm': {
      'ar': 'تعديل',
      'en': '',
    },
    'cdgtua4g': {
      'ar': 'المستندات',
      'en': '',
    },
    'qmep3wzc': {
      'ar': 'التقدم',
      'en': '',
    },
    'u71lmxjf': {
      'ar': 'قضية رقم 2024-002',
      'en': '',
    },
    'aibppqbj': {
      'ar': 'قيد المراجعة',
      'en': '',
    },
    'ofo16mr8': {
      'ar': 'العميل: محمد علي',
      'en': '',
    },
    'fk52qw70': {
      'ar': 'المحامي: سارة حسن',
      'en': '',
    },
    'fzr8bgtl': {
      'ar': 'نوع القضية: قضية عمالية',
      'en': '',
    },
    'nj6n91s9': {
      'ar': 'تعديل',
      'en': '',
    },
    'ovy3rya4': {
      'ar': 'المستندات',
      'en': '',
    },
    '0xjrwydp': {
      'ar': 'التقدم',
      'en': '',
    },
    '1ynhnxy6': {
      'ar': 'المواعيد القادمة',
      'en': '',
    },
    'o8u6sgeo': {
      'ar': 'جلسة محكمة - قضية رقم 2024-001',
      'en': '',
    },
    'o0kmbo5b': {
      'ar': '20 مايو، 2024 - 9:00 ص',
      'en': '',
    },
    'cjowz95f': {
      'ar': 'اجتماع مع العميل - قضية رقم 2024-002',
      'en': '',
    },
    'ep3c7hx6': {
      'ar': '22 مايو، 2024 - 11:00 ص',
      'en': '',
    },
    '4sdr2bua': {
      'ar': 'إضافة قضية جديدة',
      'en': '',
    },
    'n7pzu8ff': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': '',
    },
  },
  // DocumentManagement
  {
    'zgme7559': {
      'ar': 'إدارة الوثائق',
      'en': '',
    },
    '47ys62em': {
      'ar': 'مستودع الوثائق',
      'en': '',
    },
    's9mhwdeh': {
      'ar': 'بحث في الوثائق...',
      'en': '',
    },
    '2d0gdjze': {
      'ar': 'عقود',
      'en': '',
    },
    'aqrst7pz': {
      'ar': 'مذكرات قانونية',
      'en': '',
    },
    'dyw3yeag': {
      'ar': 'قضايا',
      'en': '',
    },
    'hui8jwfy': {
      'ar': 'وثائق إدارية',
      'en': '',
    },
    'njagems8': {
      'ar': 'عقد توظيف - شركة الفا',
      'en': '',
    },
    'p3vjtj4t': {
      'ar': 'تم الرفع بواسطة: أحمد محمد',
      'en': '',
    },
    '9l89qc99': {
      'ar': 'مذكرة دفاع - قضية رقم 123',
      'en': '',
    },
    'nqjniqye': {
      'ar': 'تم الرفع بواسطة: فاطمة علي',
      'en': '',
    },
    'fg93i5a1': {
      'ar': 'لائحة دعوى - قضية رقم 456',
      'en': '',
    },
    'ult5bezo': {
      'ar': 'تم الرفع بواسطة: خالد عمر',
      'en': '',
    },
    '4yawnobn': {
      'ar': 'إحصائيات الوثائق',
      'en': '',
    },
    'yoftivxu': {
      'ar': 'إجمالي الوثائق',
      'en': '',
    },
    'l7j7yw4d': {
      'ar': '1,234',
      'en': '',
    },
    '541fyy2q': {
      'ar': 'بانتظار المراجعة',
      'en': '',
    },
    '38omyr3j': {
      'ar': '28',
      'en': '',
    },
    'ibru28pc': {
      'ar': 'تمت الموافقة',
      'en': '',
    },
    'm2zfmgl8': {
      'ar': '1,156',
      'en': '',
    },
    'lc207e1f': {
      'ar': 'رفع وثيقة جديدة',
      'en': '',
    },
  },
  // NotificationsCommunicationSettings
  {
    'vv45hz3l': {
      'ar': 'إعدادات التواصل',
      'en': '',
    },
    'b5r7qhw5': {
      'ar': 'إدارة قوالب الإشعارات وتخصيص التنبيهات',
      'en': '',
    },
    '9zjbgchl': {
      'ar': 'قوالب الإشعارات',
      'en': '',
    },
    'm8cfyjzw': {
      'ar': 'واتساب',
      'en': '',
    },
    'b2mtda0w': {
      'ar': 'تكوين قالب رسائل واتساب',
      'en': '',
    },
    'v3n3hqj8': {
      'ar': 'البريد الإلكتروني',
      'en': '',
    },
    '33ewyt6p': {
      'ar': 'تخصيص قوالب البريد الإلكتروني',
      'en': '',
    },
    'd9mztkv7': {
      'ar': 'إشعارات الدفع',
      'en': '',
    },
    '96zzr9o4': {
      'ar': 'إعداد إشعارات التطبيق',
      'en': '',
    },
    'tmfq1fpv': {
      'ar': 'إعدادات التنبيهات العامة',
      'en': '',
    },
    'r3e8ur8z': {
      'ar': 'تنبيهات الجلسات',
      'en': '',
    },
    'svb693we': {
      'ar': 'تذكيرات المواعيد',
      'en': '',
    },
    'n9814cgt': {
      'ar': 'تحديثات القضايا',
      'en': '',
    },
    '35vwe65p': {
      'ar': 'الرسائل الجماعية',
      'en': '',
    },
    'bptv3h1m': {
      'ar': 'عنوان الرسالة',
      'en': '',
    },
    'dk7px73t': {
      'ar': 'نص الرسالة',
      'en': '',
    },
    'iw26cv7a': {
      'ar': 'إضافة مرفقات',
      'en': '',
    },
    'd2lhe91b': {
      'ar': 'إرسال',
      'en': '',
    },
    'gwsjvsl2': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': '',
    },
  },
  // AppointmentCalendarManagement
  {
    '8gqhkv71': {
      'ar': 'إدارة التقويم',
      'en': '',
    },
    'axnbd0si': {
      'ar': 'جدولة وإدارة المواعيد',
      'en': '',
    },
    'wdijtrvo': {
      'ar': 'التقويم',
      'en': '',
    },
    'qb7mq81k': {
      'ar': 'المواعيد القادمة',
      'en': '',
    },
    'sktwos8u': {
      'ar': 'إضافة موعد',
      'en': '',
    },
    '8xd6t9h9': {
      'ar': 'اجتماع مع العميل أحمد',
      'en': '',
    },
    'xr5b8xh1': {
      'ar': '15 يونيو 2024 - 10:00 ص',
      'en': '',
    },
    '9v5c6855': {
      'ar': 'جلسة محكمة - قضية رقم 123',
      'en': '',
    },
    'qv5tu5on': {
      'ar': '20 يونيو 2024 - 11:30 ص',
      'en': '',
    },
    'x19agrio': {
      'ar': 'مزامنة التقويم',
      'en': '',
    },
    '9egk5ky5': {
      'ar': 'مزامنة مع Google Calendar',
      'en': '',
    },
    'vrld5sls': {
      'ar': 'مزامنة مع Outlook',
      'en': '',
    },
    'wogpnzbg': {
      'ar': 'التذكيرات',
      'en': '',
    },
    'uls8qez5': {
      'ar': 'تذكير قبل الموعد بـ',
      'en': '',
    },
    '97fkf8c0': {
      'ar': '30 دقيقة',
      'en': '',
    },
    'jmom7xc1': {
      'ar': 'حفظ الإعدادات',
      'en': '',
    },
    'r3idjp8p': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': '',
    },
  },
  // PaymentandFinancialOverview
  {
    'sb893b8o': {
      'ar': 'النظرة المالية',
      'en': '',
    },
    'voorwj8m': {
      'ar': 'ملخص مالي',
      'en': '',
    },
    'dyknlw1b': {
      'ar': 'إجمالي الإيرادات',
      'en': '',
    },
    'nr9fg9an': {
      'ar': '١٥٠,٠٠٠ ريال',
      'en': '',
    },
    '35aakrsq': {
      'ar': 'إجمالي المصروفات',
      'en': '',
    },
    'atsourao': {
      'ar': '٧٥,٠٠٠ ريال',
      'en': '',
    },
    'mgp2uw46': {
      'ar': 'جدول المدفوعات',
      'en': '',
    },
    '0fdwuvvt': {
      'ar': 'العميل',
      'en': '',
    },
    'v0ie371h': {
      'ar': 'المبلغ',
      'en': '',
    },
    '3zmsjj6l': {
      'ar': 'تاريخ الاستحقاق',
      'en': '',
    },
    'bdzwurdv': {
      'ar': 'أحمد محمد',
      'en': '',
    },
    'f5fzvv9d': {
      'ar': '٥,٠٠٠ ريال',
      'en': '',
    },
    'tn2vs6xh': {
      'ar': '٢٠٢٤/٠٥/١٥',
      'en': '',
    },
    '36itrp14': {
      'ar': 'فاطمة علي',
      'en': '',
    },
    '4zkbxcue': {
      'ar': '٧,٥٠٠ ريال',
      'en': '',
    },
    '84p430xx': {
      'ar': '٢٠٢٤/٠٥/٢٠',
      'en': '',
    },
    'xpy0o14m': {
      'ar': 'عرض الكل',
      'en': '',
    },
    'f8zp5vrv': {
      'ar': 'مصروفات القضايا والمحامين',
      'en': '',
    },
    'z9xkmnsc': {
      'ar': 'القضية/المحامي',
      'en': '',
    },
    'qvlxhumb': {
      'ar': 'المبلغ',
      'en': '',
    },
    '5xo5zauq': {
      'ar': 'قضية رقم ٢٣٤',
      'en': '',
    },
    'r4ykicpm': {
      'ar': '٣,٠٠٠ ريال',
      'en': '',
    },
    'nhtc0jgq': {
      'ar': 'المحامي خالد',
      'en': '',
    },
    'o2i8pt5g': {
      'ar': '٥,٥٠٠ ريال',
      'en': '',
    },
    'ohftactb': {
      'ar': 'إضافة مصروف',
      'en': '',
    },
    'fcdlx1za': {
      'ar': 'التقارير المالية',
      'en': '',
    },
    't1oijo25': {
      'ar': 'تقرير شهري',
      'en': '',
    },
    'g83d5sof': {
      'ar': 'يناير ٢٠٢٤',
      'en': '',
    },
    '1tiy1u80': {
      'ar': 'تحميل',
      'en': '',
    },
    '5w5l18hq': {
      'ar': 'تقرير ربع سنوي',
      'en': '',
    },
    'ang21ayo': {
      'ar': 'الربع الأول ٢٠٢٤',
      'en': '',
    },
    'hp9jdbhj': {
      'ar': 'تحميل',
      'en': '',
    },
    'mtmlxvt4': {
      'ar': 'إنشاء تقرير مخصص',
      'en': '',
    },
    'oq7k2aer': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': '',
    },
  },
  // ReportsandAnalytics
  {
    'pgksdy4s': {
      'ar': 'التقارير والتحليلات',
      'en': '',
    },
    'tm0lvi8n': {
      'ar': 'إدارة وتحليل بيانات المكتب',
      'en': '',
    },
    '71uu3l5k': {
      'ar': 'إنشاء تقرير مخصص',
      'en': '',
    },
    'yo6jjpqh': {
      'ar': 'نوع التقرير',
      'en': '',
    },
    'qbkhkub8': {
      'ar': 'اختر نوع التقرير',
      'en': '',
    },
    'ik81q200': {
      'ar': 'الفترة الزمنية',
      'en': '',
    },
    '7ur0t9xi': {
      'ar': 'حدد الفترة',
      'en': '',
    },
    '3kto2h91': {
      'ar': 'إنشاء التقرير',
      'en': '',
    },
    '30slmzfb': {
      'ar': 'نظرة عامة على النشاط',
      'en': '',
    },
    'eq6p9umq': {
      'ar': 'القضايا النشطة',
      'en': '',
    },
    '1z9pwm9g': {
      'ar': '78',
      'en': '',
    },
    'u3rgjmhr': {
      'ar': 'المحامون النشطون',
      'en': '',
    },
    '8vwiwont': {
      'ar': '12',
      'en': '',
    },
    'tl1lx6lg': {
      'ar': 'العملاء الجدد',
      'en': '',
    },
    'xd5k7cdb': {
      'ar': '23',
      'en': '',
    },
    '7mkh53jh': {
      'ar': 'تحليل الإشعارات والتفاعل',
      'en': '',
    },
    'vfdxz7mz': {
      'ar': 'معدل فتح الإشعارات',
      'en': '',
    },
    'a7v57gln': {
      'ar': '68%',
      'en': '',
    },
    '626euwvp': {
      'ar': 'معدل الاستجابة',
      'en': '',
    },
    'ghbfu1oj': {
      'ar': '92%',
      'en': '',
    },
    'ds7bjsbz': {
      'ar': 'رسم بياني لتفاعل المستخدمين',
      'en': '',
    },
    'msdrpr7n': {
      'ar': 'التقدم المالي',
      'en': '',
    },
    'idkaste2': {
      'ar': 'رسم بياني للإيرادات والمصروفات',
      'en': '',
    },
    'nxwr2oo4': {
      'ar': 'إجمالي الإيرادات',
      'en': '',
    },
    '9qief6y7': {
      'ar': '1,250,000 ر.س',
      'en': '',
    },
    'ffm1iy7r': {
      'ar': 'إجمالي المصروفات',
      'en': '',
    },
    'qqlb6o2z': {
      'ar': '850,000 ر.س',
      'en': '',
    },
    'p165tf5p': {
      'ar': 'أداء المحامين',
      'en': '',
    },
    '522lqr9x': {
      'ar': 'رسم بياني لعبء العمل وإنجاز القضايا',
      'en': '',
    },
    'ejpxejce': {
      'ar': 'عرض التفاصيل',
      'en': '',
    },
    'ki580q93': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': '',
    },
  },
  // SystemSettings
  {
    'usnn8a3b': {
      'ar': 'إعدادات النظام',
      'en': '',
    },
    'tjidncwr': {
      'ar': 'إدارة الأدوار والصلاحيات',
      'en': '',
    },
    'qkihd3d0': {
      'ar': 'تكوين الأدوار',
      'en': '',
    },
    'kiact0id': {
      'ar': 'تعيين مستويات الوصول',
      'en': '',
    },
    '3knv4mzb': {
      'ar': 'إضافة دور جديد',
      'en': '',
    },
    'l933tg3u': {
      'ar': 'إدارة القوالب القانونية',
      'en': '',
    },
    'zycfjf7k': {
      'ar': 'قوالب العقود',
      'en': '',
    },
    'dicusckh': {
      'ar': 'قوالب الدعاوى',
      'en': '',
    },
    'klsn6y52': {
      'ar': 'قوالب الاستشارات',
      'en': '',
    },
    '6luk0o00': {
      'ar': 'إضافة قالب جديد',
      'en': '',
    },
    'tqq7qo6s': {
      'ar': 'سياسات البيانات والخصوصية',
      'en': '',
    },
    '23dcjpdl': {
      'ar': 'سياسة الخصوصية',
      'en': '',
    },
    'qhp5a7ip': {
      'ar': 'شروط الاستخدام',
      'en': '',
    },
    'atxoycn7': {
      'ar': 'سياسة الاحتفاظ بالبيانات',
      'en': '',
    },
    'gnc52bs6': {
      'ar': 'تحديث السياسات',
      'en': '',
    },
    'n3unx4rh': {
      'ar': 'النسخ الاحتياطي والتصدير',
      'en': '',
    },
    'm3om4t00': {
      'ar': 'إنشاء نسخة احتياطية',
      'en': '',
    },
    'sc5fbg93': {
      'ar': 'استعادة من نسخة احتياطية',
      'en': '',
    },
    'j7raphzo': {
      'ar': 'تصدير البيانات',
      'en': '',
    },
    'rxu85xzg': {
      'ar': 'جدولة النسخ الاحتياطي التلقائي',
      'en': '',
    },
    's8gmhv8b': {
      'ar': 'جميع الحقوق محفوظة © 2024 مكتب يموت للمحاماة',
      'en': '',
    },
  },
  // FeedbackandSupport
  {
    'jkvozdl8': {
      'ar': 'لوحة التحكم',
      'en': '',
    },
    'jw67lj95': {
      'ar': 'ملاحظات العملاء والمحامين',
      'en': '',
    },
    'o7vfsdaf': {
      'ar': 'أحمد محمد',
      'en': '',
    },
    'gxpsd9u0': {
      'ar': 'خدمة ممتازة وسريعة',
      'en': '',
    },
    'h3709m8x': {
      'ar': 'عميل',
      'en': '',
    },
    '7z7qsfog': {
      'ar': 'سارة أحمد',
      'en': '',
    },
    'w74gon3c': {
      'ar': 'تجربة إيجابية مع المكتب',
      'en': '',
    },
    'iu9px7o4': {
      'ar': 'محامي',
      'en': '',
    },
    'ek4hg54d': {
      'ar': 'تذاكر الدعم',
      'en': '',
    },
    'rcvqpfrn': {
      'ar': 'مشكلة في تسجيل الدخول',
      'en': '',
    },
    'ooorrffb': {
      'ar': 'لم أتمكن من تسجيل الدخول...',
      'en': '',
    },
    'xm7zznzs': {
      'ar': 'الرد',
      'en': '',
    },
    'mr9hfa6i': {
      'ar': 'استفسار عن الخدمات',
      'en': '',
    },
    'xfxk8rgc': {
      'ar': 'هل يمكنكم توضيح الخدمات...',
      'en': '',
    },
    'v11munvz': {
      'ar': 'الرد',
      'en': '',
    },
    'cfwj2qb1': {
      'ar': 'الأسئلة الشائعة والأدلة',
      'en': '',
    },
    'jpzrwdkh': {
      'ar': 'الأسئلة الشائعة',
      'en': '',
    },
    'kffim7ri': {
      'ar': 'دليل المستخدم',
      'en': '',
    },
    'lyt7o89b': {
      'ar': 'إضافة محتوى جديد',
      'en': '',
    },
  },
  // Miscellaneous
  {
    'k1leozod': {
      'ar':
          'The app needs access to your photo library to allow you to upload important documents or images related to your cases. Your privacy and data security are our top priorities.',
      'en': '',
    },
    'cirb7ekk': {
      'ar':
          'We would like to send you notifications about important updates, reminders, and alerts related to your cases. This ensures you stay informed in real-time.',
      'en': '',
    },
    '2lmi231r': {
      'ar':
          'We request access to your location to provide you with relevant legal services and updates based on your current whereabouts. This feature will enhance your experience with location-specific information.',
      'en': '',
    },
    's19rv7ct': {
      'ar':
          'The app requires access to your camera to allow you to take photos of documents and evidence directly from your device for case submissions. Your privacy is important to us.',
      'en': '',
    },
    'qj743fsf': {
      'ar':
          'We would like to use your biometric data (fingerprint/face recognition) to securely log you into the app. This allows for a faster and safer user experience.',
      'en': '',
    },
    '4vadcpg7': {
      'ar':
          'We request access to your calendar to schedule important events, court dates, and reminders related to your cases. This will help you keep track of key dates easily.',
      'en': '',
    },
    'qvowow4c': {
      'ar':
          'We request access to your microphone to facilitate online calls and communication with your lawyer. This feature will enhance your ability to discuss your case in real-time and ensure a smoother experience.',
      'en': '',
    },
    'xzuhzagf': {
      'ar':
          'We would like to access your contacts to enable easy sharing of important information with your legal team and facilitate communication. This will help you stay connected and ensure that we can reach you when necessary.',
      'en': '',
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
