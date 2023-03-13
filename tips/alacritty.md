# alacritty tips

## Dynamic tmux
```yaml
shell:
  program: /usr/bin/bash
  args:
    - -l
    - -c
    - eval "tmux $(tmux ls 2>/dev/null | grep -vq attached && echo 'attach -d')"
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
With zellij

```yaml
shell:
  program: /opt/local/bin/zellij
```
