@interviews_start
Feature: The interviews run through the main e-filing scenarios

Those scenarios are:
1. Don't want to efile, yes to fee waiver
2. Don't want to efile, no to fee waiver
3. Want to efile, but can't find case and court doesn't allow non-indexed, so fallback to no-efile
4. Efile with fee waiver
5. Efile without fee waiver
6. Efile with non-indexed case (not in yet)

These tests are made to work with the ALKiln testing framework, an automated testing framework made under the Document Assembly Line Project.

See ALKiln's docs: https://suffolklitlab.github.io/docassemble-AssemblyLine-documentation/docs/automated_integrated_testing

Some good stage cases to test with:
* Dupage: JOHN SMITH -VS- MARY SMITH (October 15, 2014) Docket ID: 2014SC200000
  * should be able to select either party, don't have to answer what side of the case we're on
* Dupage: Mary Jane Smith Petition for a change of name Mary Anne Doe, 2018MR000007
  * should filter out
* Dupage: John Smith, 2020D000033
  * should say we can't file, b/c no appearance option
* Lake: 78D00000056
* DuPage: Mary Smith: 2020D000033
  * shouldn't see is_unused_party error
* Stephenson: 2018SC241 for SC, John Brown


@appearance @start @fast @a0
Scenario: appearance.yml just starts
  Given I start the interview at "appearance.yml"

@appearance @no-efile @a1 @no-waiver
Scenario: appearance.yml without e-filing
  Given I start the interview at "appearance.yml"
  And the maximum seconds for each Step in this Scenario is 40
  And I check all pages for accessibility issues
  And I get to the question id "get-docs-screen" with this data:
    | var | value | trigger |
    | accept["I accept the terms of use and privacy policy."] | True | |
    | case_is_invalid_type | False | |
    | trial_court_index | 0 | |
    | user_wants_efile | False | |
    | user_ask_role | defendant | |
    | users.target_number | 1 | |
    | users[0].name.first | Bob | |
    | users[0].name.last | Ma | |
    | other_parties.target_number | 1 | |
    | trial_with | judge_only | |
    | case_number | 2022AC123 | |
    | users[0].phone_number | 4094567890 | |
    | users[0].email | example@example.com | |
    | other_parties[0].person_type | ALIndividual | |
    | other_parties[0].name.first | Tame | |
    | other_parties[0].name.last | Impala | |
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
    | users[0].email_notice | True | |
    | user_wants_fee_waiver | False | |
    | e_signature | True | |
  Then I should not see the phrase "Fee Waiver Application"

@appearance @no-efile @a2 @fee-waiver
Scenario: appearance.yml without e-filing with fee waiver
  Given I start the interview at "appearance.yml"
  And the maximum seconds for each Step in this Scenario is 40
  And I check all pages for accessibility issues
  And I get to the question id "get-docs-screen" with this data:
    | var | value | trigger |
    | accept["I accept the terms of use and privacy policy."] | True | |
    | case_is_invalid_type | False | |
    | trial_court_index | 0 | |
    | user_wants_efile | False | |
    | user_ask_role | defendant | |
    | users.target_number | 1 | |
    | users[0].name.first | Bob | |
    | users[0].name.last | Ma | |
    | other_parties.target_number | 1 | |
    | trial_with | judge_only | |
    | case_number | 2022AC123 | |
    | users[0].phone_number | 4094567890 | |
    | users[0].email | example@example.com | |
    | other_parties[0].person_type | ALIndividual | |
    | other_parties[0].name.first | Tame | |
    | other_parties[0].name.last | Impala | |
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
    | user_wants_fee_waiver | True | |
    | user_benefits['TA'] | True | |
    | users[0].birth_year | 2000 | |
    | users[0].email_notice | True | |
    | e_signature | True | |
  Then I should see the phrase "Fee Waiver Application"


@appearance @no-efile @a3
Scenario: appearance.yml attempting but failing e-filing
  Given I start the interview at "appearance.yml"
  And the maximum seconds for each Step in this Scenario is 50
  And I get to the question id "eFile Login" with this data:
    | var | value | trigger |
    | accept["I accept the terms of use and privacy policy."] | True | |
    | case_is_invalid_type | False | |
    | trial_court_index | 81 | |
    | user_wants_efile | True | |
  And I set the variable "my_username" to secret "TYLER_EMAIL"
  And I set the variable "my_password" to secret "TYLER_PASSWORD"
  And I tap to continue
  And I tap to continue
  And I set the variable "x.docket_number_from_user" to "BBBBBBB"
  And I tap to continue
  And I wait 30 seconds
  And I tap to continue
  And I get to the question id "get-docs-screen" with this data:
    | var | value | trigger |
    | user_ask_role | defendant | |
    | users.target_number | 1 | |
    | users[0].name.first | Bob | |
    | users[0].name.last | Ma | |
    | other_parties.target_number | 1 | |
    | trial_with | judge_only | |
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
    | user_benefits['TA'] | True | |
    | user_wants_fee_waiver | True | |
    | users[0].birth_year | 2000 | |
    | users[0].email_notice | True | |
    | e_signature | True | |
  Then I should see the phrase "Fee Waiver"

@appearance @efile @a4 @fee-waiver
Scenario: appearance.yml with party name e-filing
  Given I start the interview at "appearance.yml"
  And the maximum seconds for each Step in this Scenario is 60
  And I check all pages for accessibility issues
  And I get to the question id "eFile Login" with this data:
    | var | value | trigger |
    | accept["I accept the terms of use and privacy policy."] | True | |
    | case_is_invalid_type | False | |
    | trial_court_index | 0 | |
    | user_wants_efile | True | |
  And I set the variable "my_username" to secret "TYLER_EMAIL"
  And I set the variable "my_password" to secret "TYLER_PASSWORD"
  And I tap to continue
  And I tap to continue
  And I set the variable "x.docket_number_from_user" to "2018SC241"
  And I tap to continue
  And I wait 50 seconds
  And I tap to continue
  And I get to the question id "get-docs-screen" with this data:
    | var | value | trigger |
    | user_ask_role | defendant | |
    | x.self_in_case | is_filing | |
    | users.target_number | 1 | |
    | other_parties.target_number | 1 | |
    | trial_with | judge_only | |
    | x.is_represented | False | other_parties[0].is_represented |
    | x.address.address | 123 Fake St | other_parties[0].address.address |
    | x.address.city | Boston | other_parties[0].address.address |
    | x.address.state | IL | other_parties[0].address.address | 
    | x.address.zip | 02122 | other_parties[0].address.address |
    | other_parties[i].mail_delivery | True | other_parties[0].mail_delivery |
    | x.delivery_date | today + 10 | other_parties[0].delivery_date |
    | x.delivery_time | 12:34 PM | other_parties[0].delivery_date |
    | users[0].address.address | 234 Fake St | users[0].address.address |
    | users[0].address.city | RADOM | users[0].address.address |
    | users[0].address.state | IL | users[0].address.address |
    | users[0].address.zip | 02122 | users[0].address.address |
    | users[0].phone_number | 4094567890 | |
    | users[0].email | example@example.com | |
    | user_wants_fee_waiver | True | |
    | user_benefits['TA'] | True | |
    | users[0].birth_year | 2000 | |
    | x.document_type | 5766 | illinois_appearance_bundle.document_type |
  And I tap to continue
  # TODO: see something?
  #Then I should see the phrase "form was submitted"

@appearance @efile @a5 @no-waiver
Scenario: appearance.yml with party name e-filing without fee waiver
  Given I start the interview at "appearance.yml"
  And the maximum seconds for each Step in this Scenario is 60
  And I check all pages for accessibility issues
  And I get to the question id "eFile Login" with this data:
    | var | value | trigger |
    | accept["I accept the terms of use and privacy policy."] | True | |
    | case_is_invalid_type | False | |
    | trial_court_index | 0 | |
    | user_wants_efile | True | |
  And I set the variable "my_username" to secret "TYLER_EMAIL"
  And I set the variable "my_password" to secret "TYLER_PASSWORD"
  And I get to the question id "party name" with this data:
    | var | value | trigger |
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
    | x.self_in_case | is_filing | |
    | users.target_number | 1 | |
    | other_parties.target_number | 1 | |
    | trial_with | judge_only | |
    | x.is_represented | False | other_parties[0].is_represented |
    | x.address.address | 123 Fake St | other_parties[0].address.address |
    | x.address.city | Boston | other_parties[0].address.address |
    | x.address.state | IL | other_parties[0].address.address | 
    | x.address.zip | 02122 | other_parties[0].address.address |
    | other_parties[i].mail_delivery | True | other_parties[0].mail_delivery |
    | x.delivery_date | today + 10 | other_parties[0].delivery_date |
    | x.delivery_time | 12:34 PM | other_parties[0].delivery_date |
    | users[0].address.address | 234 Fake St | users[0].address.address |
    | users[0].address.city | RADOM | users[0].address.address |
    | users[0].address.state | IL | users[0].address.address |
    | users[0].address.zip | 02122 | users[0].address.address |
    | users[0].phone_number | 4094567890 | |
    | users[0].email | example@example.com | |
    | user_wants_fee_waiver | False | |
    | x.document_type | 5766 | illinois_appearance_bundle.document_type |
  And I tap to continue
  # TODO: see something?
  #Then I should see the phrase "form was submitted"


# Non-indexed case isn't used
#@appearance @efile @a4 @non-indexed
#Scenario: appearance.yml with e-filing a non-indexed case
#  Given I start the interview at "appearance.yml"
#  And the maximum seconds for each Step in this Scenario is 60
#  # trial_court_index 81 is St. Clair
#  And I get to the question id "eFile Login" with this data:
#    | var | value | trigger |
#    | trial_court_index | 81 | |
#    | case_is_invalid_type | False | |
#    | accept["I accept the terms of use and privacy policy."] | True | |
#    | user_wants_efile | True | |
#  And I set the variable "my_username" to secret "TYLER_EMAIL"
#  And I set the variable "my_password" to secret "TYLER_PASSWORD"
#  And I get to the question id "get-docs-screen" with this data:
#    | var | value | trigger |
#    | x.do_what_choice | non_indexed_case | case_search.do_what_choice |
#    | x.non_indexed_docket_number | 22AC1233 | case_search.non_indexed_docket_number |
#    | user_ask_role | defendant | |
#    | user_chosen_case_category | 190921 | |
#    | user_chosen_case_type | 249264 | |
#    | users.target_number | 1 | |
#    | users[0].name.first | Bob | |
#    | users[0].name.last | Ma | |
#    | other_parties.target_number | 1 | |
#    | other_parties[0].person_type | ALIndividual | |
#    | other_parties[0].name.first | Tame | |
#    | other_parties[0].name.last | Impala | |
#    | trial_with | judge_only | |
#    | x.is_represented | False | other_parties[0].is_represented |
#    | x.address.address | 123 Fake St | other_parties[0].address.address |
#    | x.address.city | Boston | other_parties[0].address.address |
#    | x.address.state | IL | other_parties[0].address.address | 
#    | x.address.zip | 02122 | other_parties[0].address.address |
#    | x.knows_delivery_method | False | other_parties[0].knows_delivery_method |
#    | users[0].address.address | 234 Fake St | users[0].address.address |
#    | users[0].address.city | RADOM | users[0].address.address |
#    | users[0].address.state | IL | users[0].address.address |
#    | users[0].address.zip | 02122 | users[0].address.address |
#    | users[0].phone_number | 4094567890 | |
#    | users[0].email | example@example.com | |
#    | user_benefits['TA'] | True | |
#    | users[0].birth_year | 2000 | |
#    | x.document_type | 5766 | illinois_appearance_bundle.document_type |
#    | x.document_type | 5766 | IL_fee_waiver_full_for_court.document_type |
#    | x.document_type | 5766 | IL_fee_waiver_attachment.document_type |
#  And I tap the "#efile" element
#  #And I tap to continue
#  #Then I should see the phrase "form was submitted"
