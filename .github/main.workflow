workflow "Deploy on Now" {
  on = "push"
  resolves = ["alias"]
}

# Makes a new deploy
action "deploy" {
  uses = "actions/zeit-now@master"
  secrets = ["ZEIT_TOKEN"]
}

# Filter for master branch
action "filter-master" {
  needs = "deploy"
  uses = "actions/bin/filter@master"
  args = "branch master"
}

# Point alias
action "alias" {
  needs = "filter-master"
  uses = "actions/zeit-now@master"
  args = "alias"
  secrets = ["ZEIT_TOKEN"]
}
