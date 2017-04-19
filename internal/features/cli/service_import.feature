@service @service_import
Feature: Service import

  Scenario: Non logged service import
    Given I setup ernest with target "https://ernest.local"
    And I logout
    When I run ernest with "service import"
    Then The output should contain "You're not allowed to perform this action, please log in"
    When I run ernest with "service import imported"
    Then The output should contain "You're not allowed to perform this action, please log in"

  Scenario: Logged service import errors
    Given I setup ernest with target "https://ernest.local"
    And I'm logged in as "usr" / "secret123"
    When I run ernest with "service import"
    Then The output should contain "You should specify an existing datacenter name"
    When I run ernest with "service import unexisting"
    Then The output should contain "You should specify a valid service name"

  Scenario: Logged service non existing import
    Given I setup ernest with target "https://ernest.local"
    And I'm logged in as "usr" / "secret123"
    And The service "imported" does not exist
    When I run ernest with "service import fakeaws imported"
    Then The output line number "3" should contain "Found VPC"
    And The output line number "4" should contain "Subnet    : 10.0.0.0/16"
    And The output line number "5" should contain "Found Internet Gateway test"
    And The output line number "6" should contain "AWS ID : igw-a99919cd"
    And The output line number "7" should contain "Found Network db"
    And The output line number "8" should contain "Subnet : 10.0.2.0/24"
    And The output line number "9" should contain "AWS ID : subnet-265a4250"
    And The output line number "10" should contain "Found Network db-standby"
    And The output line number "11" should contain "Subnet : 10.0.3.0/24"
    And The output line number "12" should contain "AWS ID : subnet-6712373f"
    And The output line number "13" should contain "Found Network web"
    And The output line number "14" should contain "Subnet : 10.0.1.0/24"
    And The output line number "15" should contain "AWS ID : subnet-245a4252"
    And The output line number "16" should contain "Found Instance web-1"
    And The output line number "17" should contain "IP        : 10.0.1.11"
    And The output line number "18" should contain "PUBLIC IP : 34.252.149.192"
    And The output line number "19" should contain "AWS ID    : i-0b405a35e51e6342c"
    And The output line number "20" should contain "Found Instance web-2"
    And The output line number "21" should contain "IP        : 10.0.1.12"
    And The output line number "22" should contain "PUBLIC IP : 34.252.113.249"
    And The output line number "23" should contain "AWS ID    : i-0bdd080a9aebfc389"
    And The output line number "24" should contain "Found Firewall db-sg-1"
    And The output line number "25" should contain "Found Firewall web-sg-1"
    And The output line number "26" should contain "Found Nat db"
    And The output line number "27" should contain "Found ELB elb-1"
    And The output line number "28" should contain "DNS    : elb-1-1783931678.eu-west-1.elb.amazonaws.com"
    And The output line number "29" should contain "Found EBS volume web-2"
    And The output line number "30" should contain "AWS ID : vol-00b5fcfa22010dc16"
    And The output line number "31" should contain "Found EBS volume web-1"
    And The output line number "32" should contain "AWS ID : vol-036831232cec8d555"
    And The output line number "33" should contain "Found RDS Instance rds-test-1"
    And The output line number "34" should contain "Engine    : aurora"
    And The output line number "35" should contain "Cluster   : rds-test"
    And The output line number "36" should contain "Endpoint  : rds-test-1.cjqsqimreknj.eu-west-1.rds.amazonaws.com"
    And The output line number "37" should contain "Found RDS Cluster rds-test"
    And The output line number "38" should contain "Engine    : aurora"
    And The output line number "39" should contain "Endpoint  : rds-test.cluster-cjqsqimreknj.eu-west-1.rds.amazonaws.com"
    And The output line number "40" should contain "SUCCESS: service successfully imported"
