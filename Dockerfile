# get container from docker hub to not require building it
FROM srggrs/assign-one-project-github-action:1.2.1

# start it as before
ENTRYPOINT ["/entrypoint.sh"]
