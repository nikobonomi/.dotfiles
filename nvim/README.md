## Requirements
- Install Java, preferibly using sdkman. (tested with java 17)
- Install node with nvm
- Install ripgrep for the telescope live grep ```sudo apt-get install ripgrep```
- Install a [clipboard provider](https://neovim.io/doc/user/provider.html#provider-clipboard)

## Setup
- Pull the repo in your ```~/.config``` folder and rename the ```nvim-config``` folder to just nvim.   
- Start nvim, and wait for the magic to happen. Some errors will come appear, that's normal. When finished close nvim
- Start nvim again, then launch the command ```:PackerSync```. When finished close nvim again
- Start nvim, run this command ```:Mason``` and pick ```java-debug-adapter``` and ```java-test```

That should be it
