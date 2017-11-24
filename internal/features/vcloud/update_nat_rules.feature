@vcloud @update_nat_rules
Feature: Environment apply

  Scenario: Updating router nat rules
    Given I setup ernest with target "https://ernest.local"
    And I setup a new environment name
    When I'm logged in as "usr" / "secret123"
    And I apply the definition "vcloud5.yml"
    And I start recording
    And I apply the definition "vcloud6.yml"
    And I stop recording
    Then an event "router.update.vcloud-fake" should be called exactly "1" times
    And all "router.update.vcloud-fake" messages should contain a field "_provider" with "vcloud-fake"
    And all "router.update.vcloud-fake" messages should contain a field "name" with "vse2"
    And all "router.update.vcloud-fake" messages should contain a credentials field "vcloud_vdc_name" with "fakevcloud"
    And all "router.update.vcloud-fake" messages should contain a credentials field "vcloud_url" with "https://vcloud.net"
    And all "router.update.vcloud-fake" messages should contain a credentials field "vcloud_username" with "fakeuser@test"
    And all "router.update.vcloud-fake" messages should contain an encrypted credentials field "vcloud_password" with "test123"
    And message "router.update.vcloud-fake" number "0" should contain "DNAT" as json field "nat_rules.0.type"
    And message "router.update.vcloud-fake" number "0" should contain "172.16.186.44" as json field "nat_rules.0.origin_ip"
    And message "router.update.vcloud-fake" number "0" should contain "22" as json field "nat_rules.0.origin_port"
    And message "router.update.vcloud-fake" number "0" should contain "10.1.0.11" as json field "nat_rules.0.translation_ip"
    And message "router.update.vcloud-fake" number "0" should contain "22" as json field "nat_rules.0.translation_port"
    And message "router.update.vcloud-fake" number "0" should contain "tcp" as json field "nat_rules.0.protocol"
    And message "router.update.vcloud-fake" number "0" should contain "DNAT" as json field "nat_rules.1.type"
    And message "router.update.vcloud-fake" number "0" should contain "11.11.11.11" as json field "nat_rules.1.origin_ip"
    And message "router.update.vcloud-fake" number "0" should contain "22" as json field "nat_rules.1.origin_port"
    And message "router.update.vcloud-fake" number "0" should contain "10.1.0.11" as json field "nat_rules.1.translation_ip"
    And message "router.update.vcloud-fake" number "0" should contain "22" as json field "nat_rules.1.translation_port"
    And message "router.update.vcloud-fake" number "0" should contain "tcp" as json field "nat_rules.1.protocol"
