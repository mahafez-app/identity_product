import 'package:flutter/widgets.dart';

final class IdentityStrings {
  const IdentityStrings._(this._isArabic);

  final bool _isArabic;

  static IdentityStrings of(BuildContext context) => IdentityStrings._(
    Localizations.localeOf(context).languageCode.toLowerCase() == 'ar',
  );

  String get appName => _text('Mahafez', 'محافظ');
  String get appTagline => _text(
    'Manage your business wallets with ease',
    'تابع محافظ شغلك بسهولة ومن مكان واحد',
  );
  String get continueWithGoogle =>
      _text('Continue with Google', 'كمل باستخدام جوجل');
  String get fullName => _text('Full Name', 'الاسم الكامل');
  String get fullNamePlaceholder => _text('e.g. John Doe', 'مثلاً: أحمد محمود');
  String get fullNameValidationEmpty =>
      _text('Please enter your name', 'يرجى إدخال اسمك');
  String get confirm => _text('Confirm', 'تأكيد');
  String get whatIsYourName => _text('What is your name?', 'اسمك إيه؟');
  String get nameWillBeDisplayed => _text(
    'This name appears when payment status is updated, making transactions easier to track.',
    'الاسم ده هيظهر وقت تحديث حالة الدفع عشان متابعة العمليات تبقى أسهل.',
  );
  String get email => _text('Email', 'البريد الإلكتروني');
  String get emailPlaceholder => 'example@email.com';
  String get password => _text('Password', 'كلمة المرور');
  String get passwordPlaceholder => '••••••••';
  String get createAccount => _text('Create Account', 'إنشاء حساب');
  String get signUpSubtitle => _text(
    'Create an account and start tracking your business',
    'أنشئ حساب جديد وابدأ تتابع شغلك بسهولة',
  );
  String get signIn => _text('Sign In', 'تسجيل الدخول');
  String get dontHaveAccount =>
      _text("Don't have an account?", 'ليس لديك حساب؟');
  String get signUpNow => _text('Sign Up Now', 'أنشئ حسابك');
  String get alreadyHaveAccount =>
      _text('Already have an account?', 'لديك حساب بالفعل؟');
  String get or => _text('OR', 'أو');
  String get validationError =>
      _text('Validation failed.', 'راجع البيانات المدخلة.');
  String get invalidEmail =>
      _text('Invalid email address.', 'البريد الإلكتروني غير صحيح.');

  String _text(String english, String arabic) => _isArabic ? arabic : english;
}
