{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    plugins = {
      tmux-navigator.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
      lazygit.enable = true;

      harpoon = {
        enable = true;
        enableTelescope = true;
      };
    };

    plugins.lsp = {
      enable = true;
      servers = {
        nil-ls.enable = true;
        gleam.enable = true;
      };
    };

    globalOpts = {
       number = true;
       relativenumber = true;
       
       signcolumn = "yes";

       tabstop = 4;
       softtabstop = 4;
       shiftwidth = 4;
       expandtab = true;
       
       smartindent = true;
       
       wrap = false;
       
       hlsearch = false;
       incsearch = true;
       
       guicursor = "";
       
       termguicolors = true;
       
       scrolloff = 999;
       
       cc = "80";
    };

    globals = {
      mapleader = " ";
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>pv";
        action = ":Ex <CR>";
      }
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
      }

      #Telescope
      { 
        mode = "n";
        key = "<leader>sf"; 
        action = ":Telescope find_files<CR>";
      }

      {
        mode = "n";
        key = "<C-p>";
        action = ":Telescope git_files<CR>";
      }
      {
        mode = "n";
        key = "<leader>ps";
        action = ":Telescope live_grep<CR>";
      }
      {
        mode = "n";
        key = "<leader>fs";
        action = ":Telescope grep_string<CR>";
      }
      {
        mode = "n";
        key = "<leader>vh";
        action = ":Telescope help_tags<CR>";
      }
      {
        mode = "n";
        key ="<leader>fr";
        action = ":Telescope lsp_references<CR>";
      }
      {
        mode = "n";
        key ="<leader>gg";
        action = ":LazyGit<CR>";
      }
    ];
  };
}
