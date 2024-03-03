import 'package:bdd_widget_test/feature_file.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_test/flutter_test.dart' hide find;

void main() {
  FlutterDriver driver;
  FlutterWorld world;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
    world = FlutterWorld(driver);
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  final loginScreenKey = find.byValueKey('login_screen');
  final emailFieldKey = find.byValueKey('email_field');
  final passwordFieldKey = find.byValueKey('password_field');
  final signInButtonKey = find.byValueKey('sign_in_button');

  final resetPasswordScreenKey = find.byValueKey('reset_password_screen');
  final emailResetFieldKey = find.byValueKey('email_reset_field');
  final sendResetButtonKey = find.byValueKey('send_reset_button');

  final signUpScreenKey = find.byValueKey('sign_up_screen');
  final signUpEmailFieldKey = find.byValueKey('sign_up_email_field');
  final signUpPasswordFieldKey = find.byValueKey('sign_up_password_field');
  final signUpConfirmPasswordFieldKey = find.byValueKey('sign_up_confirm_password_field');
  final signUpButtonKey = find.byValueKey('sign_up_button');

  final feature = FeatureFile(
    'authentication.feature',
    features: [
      Feature(
        'Authentication',
        scenarios: [
          Scenario(
            'User signs up with valid credentials',
            steps: [
              Given(
                'the user is on the sign-up screen',
                (context) async {
                  await context.world.driver.waitFor(signUpScreenKey);
                },
              ),
              When(
                'they enter valid credentials and submit the form',
                (context) async {
                  await context.world.driver.tap(signUpEmailFieldKey);
                  await context.world.driver.enterText('test@example.com');
                  await context.world.driver.tap(signUpPasswordFieldKey);
                  await context.world.driver.enterText('password123');
                  await context.world.driver.tap(signUpConfirmPasswordFieldKey);
                  await context.world.driver.enterText('password123');
                  await context.world.driver.tap(signUpButtonKey);
                },
              ),
              Then(
                'they should be successfully registered and logged in',
                (context) async {
                  // Add assertion for successful registration and login
                },
              ),
            ],
          ),
          Scenario(
            'User signs in with valid credentials',
            steps: [
              Given(
                'the user is on the sign-in screen',
                (context) async {
                  await context.world.driver.waitFor(loginScreenKey);
                },
              ),
              When(
                'they enter valid credentials and submit the form',
                (context) async {
                  await context.world.driver.tap(emailFieldKey);
                  await context.world.driver.enterText('test@example.com');
                  await context.world.driver.tap(passwordFieldKey);
                  await context.world.driver.enterText('password123');
                  await context.world.driver.tap(signInButtonKey);
                },
              ),
              Then(
                'they should be successfully logged in',
                (context) async {
                  // Add assertion for successful login
                },
              ),
            ],
          ),
          Scenario(
            'User requests password recovery',
            steps: [
              Given(
                'the user is on the password recovery screen',
                (context) async {
                  await context.world.driver.tap(find.text('Mot de passe oubliée ?'));
                  await context.world.driver.waitFor(resetPasswordScreenKey);
                },
              ),
              When(
                'they enter their email and submit the form',
                (context) async {
                  await context.world.driver.tap(emailResetFieldKey);
                  await context.world.driver.enterText('test@example.com');
                  await context.world.driver.tap(sendResetButtonKey);
                },
              ),
              Then(
                'they should receive an email with instructions to reset their password',
                (context) async {
                  // Add assertion for password reset email
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );

  executeFlutterTest(feature);
}
