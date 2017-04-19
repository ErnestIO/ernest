@preferences @logger @logger_management
Feature: Ernest preferences management

  Scenario: Non logged logger creation
    Given I setup ernest with target "https://ernest.local"
    And I logout
    When I run ernest with "preferences logger add basic"
    Then The output should contain "You're not allowed to perform this action, please log in"

  Scenario: Logged as plain user logger creation
    Given I setup ernest with target "https://ernest.local"
    And I'm logged in as "usr" / "secret123"
    When I run ernest with "preferences logger add basic --logfile /tmp/ernest.log"
    Then The output should contain "You're not allowed to perform this action, please log in"

  Scenario: Logged as admin user basic logger creation
    Given I setup ernest with target "https://ernest.local"
    And I'm logged in as "ci_admin" / "secret123"
    And File "/tmp/ernest.log" exists
    When I run ernest with "preferences logger add basic --logfile /var/logs/ernest.log"
    Then The output should contain "Logger successfully set up"

  Scenario: Logged as admin user basic logger creation with incorrect parameters
    Given I setup ernest with target "https://ernest.local"
    And I'm logged in as "ci_admin" / "secret123"
    When I run ernest with "preferences logger add basic"
    Then The output should contain "You should specify a logfile with --logfile flag"

  Scenario: Logged as admin user basic logger creation with non-existent logfile
    Given I setup ernest with target "https://ernest.local"
    And I'm logged in as "ci_admin" / "secret123"
    And File "/tmp/unexisting.log" does not exist
    When I run ernest with "preferences logger add basic --logfile /tmp/unexisting.log"
    Then The output should contain "Specified file '/tmp/unexisting.log' does not exist"

  Scenario: Logged as admin user basic logger deletion
    Given I setup ernest with target "https://ernest.local"
    And I'm logged in as "ci_admin" / "secret123"
    And I run ernest with "preferences logger add basic --logfile /var/logs/ernest.log"
    When I run ernest with "preferences logger delete basic"
    Then The output should contain "Specified logger does not exist"

  Scenario: Logged as admin user listing all loggers
    Given I setup ernest with target "https://ernest.local"
    And I'm logged in as "ci_admin" / "secret123"
    And I run ernest with "preferences logger add basic --logfile /var/logs/ernest.log"
    When I run ernest with "preferences logger list"
    Then The output should contain "Your basic logfile is configured on : /var/logs/ernest.log"

  Scenario: Logged as admin user listing all loggers when there are none
    Given I setup ernest with target "https://ernest.local"
    And I'm logged in as "ci_admin" / "secret123"
    And I run ernest with "preferences logger delete basic"
    When I run ernest with "preferences logger list"
    Then The output should contain "Your basic logfile is configured on : /var/logs/ernest.log"

  Scenario: Logged as admin user logstash logger creation
    Given I setup ernest with target "https://ernest.local"
    And I'm logged in as "ci_admin" / "secret123"
    And File "/tmp/ernest.log" exists
    When I run ernest with "preferences logger add logstash"
    Then The output should contain "You should specify a logstash hostname  with --hostname flag"
    When I run ernest with "preferences logger add logstash --hostname http://ernest.local/"
    Then The output should contain "You should specify a logstash port with --port flag"
    When I run ernest with "preferences logger add logstash --hostname http://ernest.local/ --port 210"
    Then The output should contain "You should specify a logstash timeout with --timeout flag"
    When I run ernest with "preferences logger add logstash --hostname http://ernest.local/ --port 210 --timeout 10"
    Then The output should contain "Logger successfully set up"
    When I run ernest with "preferences logger list"
    Then The output should contain "Logstash based loggers"
    And The output should contain "http://ernest.local/"
    And The output should contain "210"
    And The output should contain "10"
    When I run ernest with "preferences logger delete logstash"
    Then The output should contain "Logger successfully deleted"
    When I run ernest with "preferences logger list"
    Then The output should not contain "Logstash based loggers"
