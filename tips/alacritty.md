# alacritty tips

## Dynamic tmux
```yaml
shell:
  program: /usr/bin/bash
  args:
    - -l
    - -c
    - eval "tmux $(tmux ls | grep -vq attached && echo 'attach -d')"
```

## Fixed tmux
```yaml
shell:
  program: /home/linuxbrew/.linuxbrew/bin/tmux
  args:
    - new-session
    - -A
    - -s
    - Lala
```
