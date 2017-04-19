@service @service_reset
Feature: Ernest service reset

  Scenario: Non logged user reset
    Given I setup ernest with target "https://ernest.local"
    And I logout
    When I run ernest with "service reset"
    Then The output should contain "You're not allowed to perform this action, please log in"

  Scenario: Logged user reset
    Given I setup ernest with target "https://ernest.local"
    And I'm logged in as "usr" / "secret123"
    And The service "destroyable" does not exist
    And I apply the definition "destroyable.yml"
    When I run ernest with "service reset destroyable"
    Then The output should contain "The service 'destroyable' cannot be reset as its status is 'done'"
    And I force "destroyable" to be on status "in_progress"
    When I run ernest with "service list"
    And The output line number "3" should contain "destroyable"
    And The output line number "3" should contain "in_progress"
    And The output line number "3" should contain "usr"
    When I run ernest with "service reset destroyable"
    Then The output should contain "You've successfully resetted the service 'destroyable'"
    When I run ernest with "service list"
    And The output line number "3" should contain "destroyable"
    And The output line number "3" should contain "errored"
    And The output line number "3" should contain "usr"
    When I run ernest with "service reset destroyable"
    Then The output should contain "The service 'destroyable' cannot be reset as its status is 'errored'"
