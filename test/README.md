# test(s)

## docs

not very thorough. review & then dive into [#examples](#examples) without hesitation

- [https://github.com/bats-core/bats-core](https://github.com/bats-core/bats-core)

- [https://bats-core.readthedocs.io/en/latest/writing-tests.html](https://bats-core.readthedocs.io/en/latest/writing-tests.html)


## examples

- [https://github.com/bats-core/bats-core/wiki/Projects-Using-Bats](https://github.com/bats-core/bats-core/wiki/Projects-Using-Bats)

- [https://github.com/pyenv/pyenv/tree/master/test](https://github.com/pyenv/pyenv/tree/master/test)
	- [https://github.com/pyenv/pyenv/blob/master/test/test_helper.bash](https://github.com/pyenv/pyenv/blob/master/test/test_helper.bash) 

## workflow

run make from dir of any depth

```sh
git config --global alias.exec "\!exec "

git exec make test
```

(neo)vim keybind to run tests with `<leader>s` (`,s`)

```vim
noremap <leader>s :!git exec make test<CR>
```

