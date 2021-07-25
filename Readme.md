# Simp.vim

My personal colorscheme for Vim forked from [Revolution](https://github.com/EdenEast/Revolution.vim).

What changes is that I removed the airline theme and the `guibg` and `guifg` highlightings, because the `cterm` ones fit better with my system overall.

Edit: well now I have to make the `gui` highlightings be explicitly the same as the `ctermbg` settings. :/

## Installation

Use whatever plugin manager, like [Vim-Plug][], [dein][] or even [Packer][].
Put the following in your `vimrc`/`init.vim`.

[Vim-plug]: https://github.com/junegunn/vim-plug
[dein]: https://github.com/Shougo/dein.vim
[Packer]: https://github.com/wbthomason/packer.nvim

### Vim-Plug

```vim
Plug 'Speykious/simp.vim'
```

### dein

```vim
call dein#add('Speykious/simp.vim')
```

### Packer

```lua
use 'Speykious/simp.vim'
```

## License

Simp is licensed under the [MIT](http://opensource.org/licenses/MIT) license.
