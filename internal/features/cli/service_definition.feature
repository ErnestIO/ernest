@environment @environment_definition
Feature: Ernest environment definition

  Scenario: Non logged user definition
    Given I setup ernest with target "https://ernest.local"
    And I logout
    When I run ernest with "env definition"
    Then The output should contain "You're not allowed to perform this action, please log in"

  Scenario: Logged user definition
    Given I setup ernest with target "https://ernest.local"
    And I'm logged in as "usr" / "secret123"
    And The environment "fakeaws/destroyable" does not exist
    And I apply the definition "destroyable.yml"
    When I run ernest with "env definition"
    Then The output should contain "You should specify the project name"
    When I run ernest with "env definition fakeaws"
    Then The output should contain "You should specify the env name"
    When I run ernest with "env definition fakeaws destroyable"
    Then The output should contain "name: destroyable"
    And The output should contain "project: fakeaws"

  Scenario: Logged user definition for a specific build
    Given I setup ernest with target "https://ernest.local"
    And I'm logged in as "usr" / "secret123"
    And The environment "fakeaws/destroyable" does not exist
    And I apply the definition "destroyable.yml"
    When I run ernest with "env definition fakeaws destroyable"
    Then The output should contain "name: destroyable"
    And The output should contain "project: fakeaws"

