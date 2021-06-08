{config, pkgs, ...}:
{
	programs.git = {
		enable = true;
		userEmail = "alex.scorza03@gmail.com";
		userName = "Alex Scorza";
	};

	programs.neovim = {
		enable = true;
		vimAlias = true;
		extraConfig = builtins.readFile ./vim-config/init.vim;
		plugins = with pkgs.vimPlugins; [
			gruvbox
			vim-colors-paramount
			vim-code-dark
			haskell-vim
			vim-fish
			vim-nix
			lf-vim
			suda-vim
			nerdfont-vim
			vim-smoothie
			vim-floaterm
			vim-maximizer
			vim-sneak
			lightline.vim
			vim-gitbranch
			auto-pairs
			nerdtree
			nerdcommenter
			vim-airline
			vim-airline-themes
			ultisnips
			vim-signify
			vim-fugitive
			vim-rhubarb
			gv-vim
			fzf-vim
			vimsence
		];
	};
}
