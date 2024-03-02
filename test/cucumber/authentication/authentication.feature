Feature: Authentication

  Scenario: User signs up with valid credentials
    Given the user is on the sign-up screen
    When they enter valid credentials and submit the form
    Then they should be successfully registered and logged in
  
  Scenario: User signs in with valid credentials
    Given the user is on the sign-in screen
    When they enter valid credentials and submit the form
    Then they should be successfully logged in

  Scenario: User requests password recovery
    Given the user is on the password recovery screen
    When they enter their email and submit the form
    Then they should receive an email with instructions to reset their password

