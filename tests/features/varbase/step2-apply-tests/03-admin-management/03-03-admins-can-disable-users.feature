Feature: User Management - Standard User Management - Admins can disable users
As a site admin user
I want to be able Block user accounts
So that they will be disabled and not be able to use the site.

  @javascript @local @development @staging @production
  Scenario: Check if the test_authenticated user is not blocked and can login
    Given I am on "/user/login"
      And I wait
     When I fill in "test_authenticated" for "Username"
      And I fill in "dD.123123ddd" for "Password"
      And I press "Log in"
      And I wait
     Then I should see "test_authenticated"

  @javascript @local @development @staging @production
  Scenario: Check if the site admin can Administer users and disable a User account test_authenticated from accessing the site
    Given I am a logged in user with the "test_site_admin" user
     When I go to "/admin/people"
      And I wait
     Then I should see "People"
     When I fill in "test_authenticated" for "Name or email contains"
      And I press "Filter"
      And I wait
     Then I should see "test_authenticated"
     When I click "Edit" in the "test_authenticated" row
      And I wait
     Then I should see "test_authenticated"
     When I select the radio button "Blocked"
      And I press the "Save" button
      And I wait
     Then I should see "The changes have been saved."

  @javascript @local @development @staging @production
  Scenario: Check if the blocked user with user id of Test Blocked User ID can or can not login
    Given I am on "/user/login"
      And I wait
     When I fill in "test_authenticated" for "Username"
      And I fill in "dD.123123ddd" for "Password"
      And I press "Log in"
      And I wait
     Then I should see "The username test_authenticated has not been activated or is blocked."

  @javascript @local @development @staging @production
  Scenario: Check flood control default settings
    Given I am a logged in user with the "webmaster" user
     When I go to "/admin/config/people/flood-control"
      And I wait
     Then I should see "Flood control"
      And I should see "50" in the "#edit-ip-limit" element
      And I should see "1 hour" in the "#edit-ip-window" element
      And I should see "5" in the "#edit-user-limit" element
      And I should see "6 hours" in the "#edit-user-window" element

  @javascript @local @development @staging @production
  Scenario: Check that the Site Admin have access to the flood unblock page
    Given I am a logged in user with the "test_site_admin" user
     When I go to "/admin/people/flood-unblock"
      And I wait
     Then I should see "Flood Unblock"