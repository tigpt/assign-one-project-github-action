# Faster GitHub Action for Assign to One Project

This project is based on https://github.com/srggrs/assign-one-project-github-action but instead of build and install curl and jq everytime the action runs, it pulls srggrs/assign-one-project-github-action image from hub.docker.com saving some extra seconds.

Every issue you open consumes less gitaction time reducing the speed and billable time.

# From 9~12 seconds to arround 6 seconds per run.

You just need to replace 
```yaml
uses: srggrs/assign-one-project-github-action@1.2.1
```

with:
```yaml
uses: tigpt/assign-one-project-github-action@1.2.1.1
```

Example:
```yaml
name: Auto Assign to Project(s)

on:
  issues:
    types: [opened, labeled]
  pull_request:
    types: [opened, labeled]
env:
  GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

jobs:
  assign_one_project:
    runs-on: ubuntu-latest
    name: Assign to One Project
    steps:
    - name: Assign NEW issues and NEW pull requests to project 2
      uses: tigpt/assign-one-project-github-action@1.2.1.1
      if: github.event.action == 'opened'
      with:
        project: 'https://github.com/srggrs/assign-one-project-github-action/projects/2'

    - name: Assign issues and pull requests with `bug` label to project 3
      uses: tigpt/assign-one-project-github-action@1.2.1.1
      if: |
        contains(github.event.issue.labels.*.name, 'bug') ||
        contains(github.event.pull_request.labels.*.name, 'bug')
      with:
        project: 'https://github.com/srggrs/assign-one-project-github-action/projects/3'
        column_name: 'Labeled'
```