# MY NVIM-CONFIG
    Follow these steps to get the same neovim experience as me.

    * Make sure you've got the latest neovim version.
        * type `nvim --version` in the terminal. It should be at least 0.6.0
        * if it is not get the latest version
            ```
                curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
                sudo rm -rf /opt/nvim
                sudo tar -C /opt -xzf nvim-linux64.tar.gz
                export PATH="$PATH:/opt/nvim-linux64/bin"
            ```

    * First install the package manager. I am using [Packer.nvim](https://github.com/wbthomason/packer.nvim)
        ```git clone --depth 1 https://github.com/wbthomason/packer.nvim\
            ~/.local/share/nvim/site/pack/packer/start/packer.nvim```

    * Clone this repository inside .config directory
        ```https://github.com/therealsunx/nvim-config ~/.config/nvim```

    * Open nvim (Don't worry if you see some errors. We have to install packages first)

    * Then, sync the packages specified in config file by using command `:PackerSync`
        (this will install the packages if not installed, else it will sync them to latest release)

## What's included ?
    * [nvim-telescope](https://github.com/nvim-telescope/telescope.nvim) : For awesome file-tree navigation
    * [harpoon](https://github.com/ThePrimeagen/harpoon) : For quick access between frequently used files
    * [mbbill/undotree](https://github.com/mbbill/undotree) : For access to undotree for convenience
    * [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive) : For git-related works
    * [VonHeikemen/lsp-zero.vim](https://github.com/VonHeikemen/lsp-zero.vim) : For managing language server protocols for syntax highlighting, autocompletion, etc
    * [ellisonleao/gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) : Gruvbox theme for awesome nvim environment
    * [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) : For smooth navigation between neovim and tmux if you use one

