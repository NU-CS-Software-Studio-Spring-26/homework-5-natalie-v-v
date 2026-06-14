#HW deliverables

## Part 1 Links 
.cursorignore
https://vscode.dev/github/NU-CS-Software-Studio-Spring-26/homework-5-natalie-v-v/blob/main/.cursorignore

## Part 2 Links 
AGENTS.md
https://vscode.dev/github/NU-CS-Software-Studio-Spring-26/homework-5-natalie-v-v/blob/hw5/AGENTS.md

.cursor/rails/convenction.mdc
https://vscode.dev/github/NU-CS-Software-Studio-Spring-26/homework-5-natalie-v-v/blob/hw5/.cursor/rules/rails-conventions.mdc


.cursor/rails/security.mdc
https://vscode.dev/github/NU-CS-Software-Studio-Spring-26/homework-5-natalie-v-v/blob/hw5/.cursor/rules/security.mdc



## Part 3 Links 


## Bad Prompt 
fix the bug in todos

## Good Prompt rewrite

1. Context
Controller: app/controllers/todos_controller.rb

Views: app/views/todos/_form.html.erb and app/views/todos/show.html.erb

JSON Serializers: app/views/todos/_todo.json.jbuilder

2. Task
Wire the due_date attribute completely through the application stack. This requires updating the controller's strong parameters to permit the attribute, adding form fields to the UI, displaying the value on the show page using Rails localization, and exposing it in the JSON API payload.

3. Expected vs. Actual
Actual Behavior: Although a due_date column exists in the database schema, it is a dead feature. The attribute is stripped out by strong parameters on submission, lacks an input field in the creation/editing form, is entirely hidden from the HTML show view, and is excluded from the Jbuilder JSON output.

Expected Behavior: Users should be able to pick a date and time when creating or updating a todo. This date must persist to the database, render properly on the individual todo page using localized formatting (falling back gracefully to "None"), and return as a field in JSON responses.

4. Constraints

Allowed Files to Modify:

app/controllers/todos_controller.rb (update todo_params)

app/views/todos/_form.html.erb (add a datetime_local_field)

app/views/todos/show.html.erb (add a localized view element)

app/views/todos/_todo.json.jbuilder (add :due_date to the extracted attributes)

Coding Patterns: Strictly follow the strict parameter structures defined in .cursorrules and .cursor/rules/rails-conventions.mdc. Use Rails' params.expect syntax for strong parameters. Do not hand-write raw vanilla JavaScript for custom date-pickers; rely entirely on the native HTML5 browser inputs and native Rails localization (l()) helpers.

5. Done When
The change is successful when the following four components are verified:

Parameters: todos_controller.rb permits the parameter correctly using:

Ruby
def todo_params
  params.expect(todo: [ :description, :due_date ])
end
2. **Form UI:** The `_form.html.erb` safely exposes a styled input layout:
   ```erb
   <div>
     <%= form.label :due_date, style: "display: block" %>
     <%= form.datetime_local_field :due_date %>
   </div>
Show View: show.html.erb displays the time localized, or falls back gracefully:

Code snippet
<p>
  <strong>Due date:</strong>
  <%= todo.due_date ? l(todo.due_date, format: :long) : "None" %>
</p>



## Turbo Streams
Turbo Streams allow a server to update specific parts of a web page asynchronously without requiring a full page reload or any custom JavaScript. When a user triggers an action, the server responds with raw HTML templates wrapped in a <turbo-stream> tag that specifies an operation—like append, replace, or remove—and a target DOM ID.

Turbo's lightweight client-side engine automatically parses this response and updates only that exact element on the fly. This retains the fluid, instantaneous feel of a modern single-page application while relying entirely on clean, server-rendered views. The Cursor AI correctly names
the nine actions, append, prepend, (insert) before, (insert) after, replace, update, remove, morph, and refresh as real time capabilites to capture live actions by the user.


## Acceptance Criteria
1. I want to push a task's deadline back by a certain amount of hours so that I can 
adapt to changing scheduling conflicts without opening an edit form or reloading my dashboard.
With the dashboard UI, I want to append a distinct "Snooze" action button directly into each task's row on the index view. Clicking the button must trigger an isolated database update that advances the task's due_date by exactly 1 day. The server must respond with a turbo-stream.html payload containing a <turbo-stream action="replace"> element to update the targeted task row with its new timestamp.


## Plan 

Merge duplicate routes.rb draw blocks; dedupe _todo.html.erb
Add Todo#snooze! (nil → now+24h, else due_date+24h)
Add patch :snooze route and TodosController#snooze with format.turbo_stream
Create snooze.turbo_stream.erb (replace) and Snooze button_to in _todo partial
Add controller integration test + fixture due_date; run test suite

## Tests
Error:
TodosControllerTest#test_should_show_todo:
ActionView::Template::Error: undefined method 'toggle_priority_todo_path' for an instance of #<Class:0x000000011e975328>
    app/views/todos/_todo.html.erb:10
    app/views/todos/show.html.erb:3
    test/controllers/todos_controller_test.rb:27:in 'block in <class:TodosControllerTest>'

Error:
TodosControllerTest#test_should_snooze_due_date_by_24_hours_via_turbo_stream:
NoMethodError: undefined method 'snooze_todo_url' for an instance of TodosControllerTest
    test/controllers/todos_controller_test.rb:53:in 'block (2 levels) in <class:TodosControllerTest>'
    test/controllers/todos_controller_test.rb:52:in 'block in <class:TodosControllerTest>'

## Things I rejected from the AI
I rejected creating an individual snooze.turbo_stream.erb view template asset fileand used inline inside the controller with a render turbo_stream: block passing the existing shared _todo partial to keep the codebase compact.