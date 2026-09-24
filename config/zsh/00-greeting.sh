# 00: Random greeting

GREETINGS=(
  # Generic
  "Hello, world!"
  "Howdy, partner 🤠"
  "Good to see you again"
  "Let's build something great today 🚀"
  "Welcome back, commander"
  "Ready when you are"
  "What are we breaking today?"

  # The Matrix (1999)
  "Wake up, Neo..."
  "The Matrix has you..."
  "There is no spoon."

  # Tron (1982)
  "Greetings, program"
  "End of line."
  "I fight for the users!"

  # TRON: Legacy (2010)
  "The Grid. A digital frontier."
  "You're messing with my zen thing."
  "Flynn lives!"

  # TRON: Ares (2025)
  "Ready? 'Cause there's no going back."
  "I am fearless, and therefore powerful."
  "Intelligent life does exist. Only it's not out there. It's in here."

  # WarGames (1983)
  "Shall we play a game?"
  "A strange game. How about a nice game of chess?"

  # Fallout 3 (2008)
  "War. War never changes."
  "Hellooooo, Capital Wasteland! This is Three Dog, OWWWW!"

  # Fallout: New Vegas (2010)
  "Patrolling the Mojave almost makes you wish for a nuclear winter."
  "You're nobody 'til somebody loves you."

  # Fallout 4 (2015)
  "Another settlement needs your help. I'll mark it on your map."
  "Vault-Tec calling!"

  # The Martian (2015)
  "I'm gonna have to science the shit out of this."
  "You solve one problem, and you solve the next one. And if you solve enough problems, you get to come home."
  "At some point, everything's gonna go south on you. You can either accept that, or you can get to work."
)

echo "❯ ${GREETINGS[$(( RANDOM % ${#GREETINGS[@]} + 1 ))]}"
unset GREETINGS
