## Troubleshooting

If remote development containers are not responding to a `gpg` `--clearsign`:

    echo "test" | gpg --clearsign

Then you may need to update the `STARTUPTTY` on the WSL host:

    echo UPDATESTARTUPTTY | gpg-connect-agent
