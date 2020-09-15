# dotfiles

The great and glorious `dotfiles`. 

> Never has more time been invested into fewer character bytes, by so many.

## Installing 

In a unix-ish environment you should be able to run: 

```
wget https://github.com/tamoore/dotfiles/archive/master.zip -O <destFile>
unzip <destFile> -d <destFolder>
```

## Containers

These files are setup to work specifically with the [vscode remote containers
plugin.](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

Once you have the remote containers extension setup (along with any further
setup required with vscode via the [containers
documentation](https://code.visualstudio.com/docs/remote/containers-tutorial)),
then you should be able to set startup script to `containers/setup.bash`.

This will ensure that the Docker containers have all the appropirate programs
on build.