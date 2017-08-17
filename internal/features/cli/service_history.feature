@environment @environment_history
Feature: Environment history

  Scenario: Non logged environment history
    Given I setup ernest with target "https://ernest.local"
    And I logout
    When I run ernest with "environment history"
    Then The output should contain "You're not allowed to perform this action, please log in"
    When I run ernest with "environment destroy destroyable"
    Then The output should contain "You're not allowed to perform this action, please log in"

  Scenario: Logged environment history unexisting
    Given I setup ernest with target "https://ernest.local"
    And I'm logged in as "usr" / "secret123"
    When I run ernest with "environment history"
    Then The output should contain "You should specify an existing environment name"
    When I run ernest with "environment history unexisting"
    Then The output should contain "There are no registered builds for this environment"

  Scenario: Logged environment history
    Given I setup ernest with target "https://ernest.local"
    And I'm logged in as "usr" / "secret123"
    And The environment "destroyable" does not exist
    And I apply the definition "destroyable.yml"
    And I wait for "5" seconds
    And I apply the definition "destroyable2.yml"
    And I wait for "5" seconds
    When I run ernest with "environment history destroyable"
    Then The output line number "3" should contain "destroyable"
    And The output line number "3" should contain "done"
    And The output line number "3" should contain "usr"
    And The output line number "5" should contain "destroyable"
    And The output line number "5" should contain "usr"
    And The output line number "5" should contain "done"
