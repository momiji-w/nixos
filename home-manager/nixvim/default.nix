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

        keymapsSilent = true;

        keymaps = {
          addFile = "<leader>a";
          toggleQuickMenu = "<C-e>";
          navFile = {
            "1" = "<C-h>";
            "2" = "<C-t>";
            "3" = "<C-n>";
            "4" = "<C-s>";
          };
        };
      };
    };

    plugins.lsp-format.enable = true;
    plugins.lsp = {
      enable = true;
      keymaps = {
        silent = true;
        diagnostic = {
          # Navigate in diagnostics
          "[d" = "goto_next";
          "]d" = "goto_prev";
        };

        lspBuf = {
          "<leader>gd" = "definition";
          "<leader>rr" = "references";
          "<leader>rn" = "rename";
          "<leader>gt" = "type_definition";
          "<leader>gi" = "implementation";
          K = "hover";
        };
      };
      servers = {
        nil-ls.enable = true;
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

      # lazygit
      {
        mode = "n";
        key ="<leader>gg";
        action = ":LazyGit<CR>";
      }
    ];
  };
}
