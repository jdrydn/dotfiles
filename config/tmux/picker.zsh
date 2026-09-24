[[ -o login && -z $TMUX && -t 0 && $- == *i* ]] || return

local sessions choice name words
sessions=("${(@f)$(tmux list-sessions -F '#S' 2>/dev/null)}")

if (( ${#sessions} )); then
  print "Sessions:"
  local i=1
  for s in $sessions; do print "  $i) $s"; ((i++)); done
  print "  n) new session"
  print "  x) plain shell"
else
  print "No sessions. [name] / n / x"
fi

read -r "choice?> "
case $choice in
  x|q) return ;;
  ''|n)
    words=~/Developer/@jdrydn/dotfiles/config/tmux/words.txt
    read -r "name?Session name (blank = random): "
    [[ -z $name ]] && name=$(sort -R "$words" | head -1)
    exec tmux new-session -s "$name" ;;
  <->)
    exec tmux attach -t "${sessions[$choice]}" ;;
  *)
    exec tmux new-session -A -s "$choice" ;;
esac

