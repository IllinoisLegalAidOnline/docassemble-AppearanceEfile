@interviews_start
Feature: The interviews run without erroring

This file:
[x] Test that each interview starts without an error.
[x] Contains some additional example Steps. They use fake values and are commented out with a "#" so they won't run.

These tests are made to work with the ALKiln testing framework, an automated testing framework made under the Document Assembly Line Project.

Want to disable the tests? Want to learn more? See ALKiln's docs: https://suffolklitlab.github.io/docassemble-AssemblyLine-documentation/docs/automated_integrated_testing

@appearance @start @fast
Scenario: appearance.yml runs
  Given I start the interview at "appearance.yml"

@appearance @efile
Scenario: appearance runs to end with e-filing
  Given I start the interview at "appearance.yml"
  And the maximum seconds for each Step in this Scenario is 60
  And I get to the question id "eFile Login" with this data:
    | var | value | trigger |
    | trial_court_index | 0 | |
    | user_wants_efile | True | |
  And I set the variable "my_username" to secret "TYLER_EMAIL"
  And I set the variable "my_password" to secret "TYLER_PASSWORD"
  And I get to the question id "party name" with this data:
    | var | value | trigger |
    | accept["I accept the terms of use."] | True | |
    | x.do_what_choice | party_search | case_search.do_what_choice |
  And I set the variable "case_search.somebody.person_type" to "ALIndividual"
  And I set the variable "case_search.somebody.name.first" to "John"
  And I set the variable "case_search.somebody.name.last" to "Brown"
  And I tap to continue
  And I wait 50 seconds
  And I set the variable "x.case_choice" to "case_search.found_cases[0]"
  And I tap to continue
  And I get to the question id "get-docs-screen" with this data:
    | var | value | trigger |
    | user_ask_role | defendant | |
    | self_in_case | True | |
    | users.target_number | 1 | |
    | other_parties.target_number | 1 | |
    | is_trial_by_jury | False | |
    | x.is_represented | False | other_parties[0].is_represented |
    | x.address.address | 123 Fake St | other_parties[0].address.address |
    | x.address.city | Boston | other_parties[0].address.address |
    | x.address.state | IL | other_parties[0].address.address | 
    | x.address.zip | 02122 | other_parties[0].address.address |
    | x.knows_delivery_method | False | other_parties[0].knows_delivery_method |
    | users[0].address.address | 234 Fake St | users[0].address.address |
    | users[0].address.city | RADOM | users[0].address.address |
    | users[0].address.state | IL | users[0].address.address |
    | users[0].address.zip | 02122 | users[0].address.address |
    | users[0].phone_number | 4094567890 | |
    | users[0].email | example@example.com | |
    | user_benefits['TA'] | True | |
    | users[0].birth_year | 2000 | |
    | x.document_type | 5766 | illinois_appearance_bundle.document_type |
    | x.document_type | 5766 | IL_fee_waiver_package.document_type |
  And I tap the "#efile" element
  And I tap to continue
  Then I should see the phrase "form was submitted"

@appearance @no-efile
Scenario: appearance.yml runs to end without e-filing
  Given I start the interview at "appearance.yml"
  And the maximum seconds for each Step in this Scenario is 50
  And I get to the question id "downloads" with this data:
    | var | value | trigger |
    | trial_court_index | 0 | |
    | user_wants_efile | False | |
    | accept["I accept the terms of use."] | True | |
    | user_ask_role | defendant | |
    | users.target_number | 1 | |
    | users[0].name.first | Bob | |
    | users[0].name.last | Ma | |
    | other_parties.target_number | 1 | |
    | is_trial_by_jury | False | |
    | users[0].phone_number | 4094567890 | |
    | users[0].email | example@example.com | |
    | other_parties[0].person_type | ALIndividual | |
    | other_parties[0].name.first | Tame | |
    | other_parties[0].name.last | Impala | |
    | x.is_represented | False | other_parties[0].is_represented |
    | case_number | 2022AC123 | |
    | x.is_represented | False | other_parties[0].is_represented |
    | x.address.address | 123 Fake St | other_parties[0].address.address |
    | x.address.city | Boston | other_parties[0].address.address |
    | x.address.state | IL | other_parties[0].address.address | 
    | x.address.zip | 02122 | other_parties[0].address.address |
    | x.knows_delivery_method | False | other_parties[0].knows_delivery_method |
    | users[0].address.address | 234 Fake St | users[0].address.address |
    | users[0].address.city | RADOM | users[0].address.address |
    | users[0].address.state | IL | users[0].address.address |
    | users[0].address.zip | 02122 | users[0].address.address |
    | users[0].phone_number | 4094567890 | |
    | users[0].email | example@example.com | |
    | user_benefits['TA'] | True | |
    | users[0].birth_year | 2000 | |
    | users[0].email_notice | True | |
