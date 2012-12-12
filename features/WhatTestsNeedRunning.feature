Feature: List urgent jobs
  In order pick some work to do
  As client PC I want to 
  get a list of pending jobs

  Scenario: No work to do
    Given there is no work to do
    When I request a list of work
    Then the list is empty

  Scenario: with work item to do
    Given the following work items exist:
    | name  | environment |
    | test1 | app1        |
    | test2 | app2        |
    When I request a list of work
    Then the list shows the work items:
    | id | name  | environment |
    | 1  | test1 | app1        |
    | 2  | test2 | app2        |

  Scenario: check the status of an item
    Given the following work items exist:
    | name  | environment |
    | test1 | app1        |
    | test2 | app2        |
    When I check the status of item '1'
    Then the item is shown:
    | id | name  | environment |
    | 1  | test1 | app1        |
