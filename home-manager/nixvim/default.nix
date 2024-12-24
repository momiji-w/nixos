{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.ripgrep
    ];

    extraConfigLua = ''
      vim.cmd.colorscheme "hatsunemiku"
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      '';

    autoCmd = [
    {
      command = "lua vim.lsp.buf.format()";
      event = [
        "BufWritePre"
      ];
    }
    ];
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "vim-colors-hatsunemiku";
        src = pkgs.fetchFromGitHub {
          owner = "momiji-w";
          repo = "vim-colors-hatsunemiku";
          rev = "1a90f30d8094123bda149ea86b0b81e2c2a515e9";
          hash = "sha256-kIjoRFslD/wEKUk0OKum8109z/Iq4qpRuERdFMGlSCw=";
        };
      })
    ];

    plugins = {
      telescope.enable = true;
      telescope.extensions.fzf-native.enable = true;
      treesitter.enable = true;
      web-devicons.enable = true;

      clipboard-image = {
        enable = true;
        clipboardPackage = pkgs.wl-clipboard;
      };

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
          "[d" = "goto_next";
          "]d" = "goto_prev";
        };

        lspBuf = {
          "<leader>gd" = "definition";
          "<leader>rr" = "references";
          "<leader>rn" = "rename";
          "<leader>gt" = "type_definition";
          "<leader>gi" = "implementation";
          "<leader>ca" = "code_action";
          K = "hover";
        };
      };
      servers = {
        nil_ls.enable = true;
        gopls.enable = true;
      };
    };

    opts = {
      number = true;
      relativenumber = true;

      signcolumn = "yes";

      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;

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

      { 
        mode = "n";
        key = "<leader>ff"; 
        action = ":Telescope find_files<CR>";
      }

      {
        mode = "n";
        key = "<C-p>";
        action = ":Telescope git_files<CR>";
      }
      {
        mode = "n";
        key = "<leader>fs";
        action = ":Telescope live_grep<CR>";
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
    ];
  };
}
