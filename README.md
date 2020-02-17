# README

There's a lot of extra structure here based on some implementation and
architecture ideas I had while treating this project as if it would be used at
scale, and keeping reusability in mind.

However, after checking back in on the project requirements later, it was made
clear to me that the goal was just to get the basic functionality up. With that
in mind, I cut off the process where it was, cleaned up a few things, and pushed
it out.

I left the extra structure in place to hopefully give some idea of how I would
move ahead with the project were I to invest more time into it. I broke the
feature specs towards the end since I moved away from caching via the
database, but otherwise employed TDD throughout the process.

I'd be happy to share my thoughts around any of my decisions, or to implement
anything you'd like to see me develop more. Some of the features I had in mind
for the process include:

* Prettier styling. Better spacing.
* Taking advantage of the 'if-modified-since' feature of the API.
* Caching api responses via a gem. (Initially I was planning to use the database
  for this, but that seemed to lead to violating the rule that GET requests
  shouldn't modify data. Also, it felt like overkill.)
* Using cron to schedule API calls.
* Using an API token (with figaro to keep it out of the repo)
* Using AJAX to refresh data without reloading the page.
* A healthy dose of refactoring.

Thank you very much for your consideration!
