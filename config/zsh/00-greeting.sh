# 00: Random greeting

GREETINGS=(
  # Generic
  "Hello, world!"
  "Howdy, partner 🤠"
  "Welcome back, commander"

  # Marvel's Spider-Man (2018)
  "With great power, comes great responsibility."
  "Writing's not my thing. I'm more of a... 'punching things until they stop being bad' kind of guy."
  "Nice entrance. Solid 8 out of 10."

  # Marvel's Spider-Man 2 (2023)
  "Be greater. Together."
  "Ok, before we get down to business, there's something I have to tell you... I'm fresh out of honey!"
  "I'm the hero here, not you."

  # The Legend of Zelda (1986)
  "It's dangerous to go alone! Take this."

  # The Legend of Zelda: Breath of the Wild (2017)
  "Open your eyes..."
  "Wake up, Link."

  # The Legend of Zelda: Tears of the Kingdom (2023)
  "Link... you are our light."
  "You must... Link! Protect them all!"
  "Do not look away. You witness a king's revival, and the birth of his new world."
  "This world should be shrouded in darkness. Not bathed in insufferable light."

  # The Legend of Zelda: The Wind Waker (2002)
  "The wind... it is... blowing."
  "I want you to live for the future."

  # Dishonored (2012)
  "Revenge solves everything."
  "I will be watching with great interest."
  "Intrigue and mystery, butchery and betrayal."

  # Dishonored 2 (2016)
  "Take back what's yours."

  # Fallout 3 (2008)
  "War. War never changes."
  "Hellooooo, Capital Wasteland! This is Three Dog, OWWWW!"

  # Fallout: New Vegas (2010)
  "Patrolling the Mojave almost makes you wish for a nuclear winter."
  "You're nobody 'til somebody loves you."

  # Fallout 4 (2015)
  "Another settlement needs your help. I'll mark it on your map."
  "Vault-Tec calling!"
)

echo "❯ ${GREETINGS[$(( RANDOM % ${#GREETINGS[@]} + 1 ))]}"
unset GREETINGS
