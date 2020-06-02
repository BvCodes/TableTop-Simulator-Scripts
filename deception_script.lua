--[[ Lua code. See documentation: http://berserk-games.com/knowledgebase/scripting/ --]]

--[[ The OnLoad function. This is called after everything in the game save finishes loading.
Most of your script code goes here. --]]

-- These varaible store the GUID number of the various decks that
-- we will be using

locationDeck_GUID = 'd7dd0c'
hintDeck_GUID = '054ca7'
weaponDeck_GUID = '9120f6'
evidenceDeck_GUID = '9d46da'
roleDeck_GUID = '01f75d'
forensicCard_GUID = '3396e1'
moonToken_GUID = '567f74'

-- These are parameters that will be used with various function
-- throughout the script

moonToken_Param = {
  click_function='setupFirst', function_owner=nil, label='Setup Script.',
  position={0,1,0}, rotation={0,0,0}, width=1000, height=1000, font_size=1000,
  font_color=red
}



local_Param = {
  position={-12,1,-8.817}
}

hint1_Param = {
  position={-7,1,-8.817}
}

hint2_Param = {
  position={-2,1,-8.817}
}

hint3_Param = {
  position={3,1,-8.817}
}

hint4_Param = {
  position={8,1,-8.817}
}

invest_Param = {
  position={11.5,0,11}, top=false
}

-- players is the table that stores the player colors
-- tableIndex is the number colors in the players table
players = {}
tableIndex = 0


function onload()
  -- Storing needed objects by GUID number in these variables.
  -- These will be how we reference pieces we need

  locationDeck = getObjectFromGUID(locationDeck_GUID)
  hintDeck = getObjectFromGUID(hintDeck_GUID)
  weaponDeck = getObjectFromGUID(weaponDeck_GUID)
  evidenceDeck = getObjectFromGUID(evidenceDeck_GUID)
  roleDeck = getObjectFromGUID(roleDeck_GUID)
  forensicCard = getObjectFromGUID(forensicCard_GUID)
  moonToken = getObjectFromGUID(moonToken_GUID)
  



  

  locationDeck.setName('Location Card Deck')
  hintDeck.setName('Hint Card Deck')
  weaponDeck.setName('Weapon Card Deck')
  evidenceDeck.setName('Evidence Card Deck')
  roleDeck.setName('Role Card Deck')
  forensicCard.setName('Forensic Scientist Role')
  moonToken.setName('Setup Script')
  

-- creates the buttont that will be pressed to run setupFirst()
  moonToken.createButton(moonToken_Param)



end

-- the main setup function that holds all of the other functions
-- that are needed to setup the board

function setupFirst()
  
  shuffleAll()
  playerSeated()
  chooseForensic()
  dealHints()
  dealWeapons()
  printPlayers()
  dealRoles()
  print("Game is set and ready to play!")

end

-- chooseForensic() is the function that chooses the forensic Scientist
-- and then removes them from the players table

function chooseForensic()
  numToPickForensic = math.random(1, tableIndex)
  forensicColor = players[numToPickForensic]
  forensicCard.deal(1, forensicColor)
  table.remove(players, numToPickForensic)
  tableIndex = tableIndex - 1

end

-- print players is a debugging function that I was using often
-- to understand how the varous functions were affecting the
-- players table

function printPlayers()
  for i, v in pairs(players) do
    print(players[i])
  end
end

-- dealHints() deals the hint and location cards to the correct
-- location on the board

function dealHints()
  locationDeck.takeObject(local_Param)
  hintDeck.takeObject(hint1_Param)
  hintDeck.takeObject(hint2_Param)
  hintDeck.takeObject(hint3_Param)
  hintDeck.takeObject(hint4_Param)
end

-- dealWeapons() deals the weapon and evidence cards to 
-- the zone infront of each player

function dealWeapons()
  for i, v in pairs(players) do
    weaponDeck.dealToColorWithOffset({-5,0,15}, false, players[i])
    weaponDeck.dealToColorWithOffset({-2,0,15}, false, players[i])
    weaponDeck.dealToColorWithOffset({1,0,15}, false, players[i])
    weaponDeck.dealToColorWithOffset({4,0,15}, false, players[i])
    evidenceDeck.dealToColorWithOffset({-5,0,11}, false, players[i])
    evidenceDeck.dealToColorWithOffset({-2,0,11}, false, players[i])
    evidenceDeck.dealToColorWithOffset({1,0,11}, false, players[i])
    evidenceDeck.dealToColorWithOffset({4,0,11}, false, players[i])
  end
end

-- dealRoles() function deals out the roles to the remaining players

function dealRoles()
  startingRole = 9
  roleDiff = 0
  if tableIndex < 9 then
    roleDiff = startingRole - tableIndex
    for i=1, roleDiff do
      roleDeck.takeObject(invest_Param)
    end
    roleDeck.shuffle()
    for i, v in pairs(players) do
      roleDeck.deal(1, players[i])
    end
  end
end

-- playerSeated() is used to load the player colors into the 
-- players table. It also increase the tableIndex count
-- each time a player is added

function playerSeated()
  if Player.White.seated == true then
    players = table.insert(players, "White")
    tableIndex = tableIndex + 1
  end
  if Player.Brown.seated == true then
    players = table.insert(players, "Brown")
    tableIndex = tableIndex + 1
  end
  if Player.Red.seated == true then
    players = table.insert(players, "Red")
    tableIndex = tableIndex + 1
  end
  if Player.Orange.seated == true then
    players = table.insert(players, "Orange")
    tableIndex = tableIndex + 1
  end
  if Player.Yellow.seated == true then
    players = table.insert(players, "Yellow")
    tableIndex = tableIndex + 1
  end
  if Player.Green.seated == true then
    players = table.insert(players, "Green")
    tableIndex = tableIndex + 1
  end
  if Player.Teal.seated == true then
    players = table.insert(players, "Teal")
    tableIndex = tableIndex + 1
  end
  if Player.Blue.seated == true then
    players = table.insert(players, "Blue")
    tableIndex = tableIndex + 1
  end
  if Player.Purple.seated == true then
    players = table.insert(players, "Purple")
    tableIndex = tableIndex + 1
  end
  if Player.Pink.seated == true then
    players = table.insert(players, "Pink")
    tableIndex = tableIndex + 1
  end
end

-- shuffles all decks but the role deck (role deck is shuffled after
-- the correct number of investigator cards are pulled out)

function shuffleAll()
  locationDeck.shuffle()
  hintDeck.shuffle()
  weaponDeck.shuffle()
  evidenceDeck.shuffle()
end