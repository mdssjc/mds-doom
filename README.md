# mds-doom

Módulo privado para o _Emacs Doom_.

## Instalação

Clone o repositório no local de configuração do _Doom_, por exemplo,
`~/.config/doom/modules/private`, com o comando:

`git clone https://github.com/mdssjc/mds-doom.git`

No arquivo `init.el`, adicione as configurações em `:private`.

`:private
 mdssjc
 mdssjc/lang/racket`

Para o _Racket_, existe a _feature_ `+input` para ativar a entrada de caracteres
_unicode_.

`(mdssjc/lang/racket +input)`

## Racket

O módulo _Racket_, em breve, será recomendado para o projeto principal do _Doom_.

### Todos

- [ ] melhorias nos atalhos do _local leader_;
- [ ] configuração com as macros do _Doom_.
