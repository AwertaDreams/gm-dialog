# meowyahh's dialog system for gmod
Credits are in credits.txt

## Showcase
[Link to youtube](https://www.youtube.com/watch?v=VQuzde7XhVc)

## Requirements
[gm-express](https://github.com/CFC-Servers/gm_express)

# Api - dialog
## Logging
This is just a better print.
```lua
dialog.log("")
```

## Dispatch
Dispatches a given script to the player. Pass ent if you want to use registers and do something with the entity. Scripts are the json files without the .json extension. For example: ``welcome``
```lua
dialog.dispatch(script, ply, ent)
```

Example:
```
dialog.dispatch("test", LocalPlayer())
```

## Read
Reads the script file from the DATA folder on the client.
```lua
dialog.read(script)
```

Example:
```lua
dialog.read("welcome") -- this needs to be without .json.
```

## showDialog
Shows all available dialogs.
```lua
dialog.showDialogs()
```
# Api - dialog_function

Registers a dialog function.
```lua
dialog_function.register(name, func)
```

Executes the dialog function.
```lua
dialog_function.execute(name)
```

## Bugs

#### ENT:USE 
If the user somehow use's the entities twice, the panel gets opened twice too. 
This can be fixed by checking if user used the entity.

### Reflection attack 
There's a possibility for a reflection attack on init.lua.

## Json structure
**Name**: The actor's name.  
**Actor**: The actor's icon - Those need to be vmt/vtf files.  
**Text**: The actor's text.  
**Speed**: Rate in which the actor talks.  
**Voice**: The actor's voice sound.  
**Choice**: Spawn's a new ChoicePanel, with 3 buttons from which you can pick a choice.  
**FunctionName**: Will execute the registered function.  

## Special keywords

# $SELF
1. If used in Name, this will set the actor's name to localplayer's steam name.
2. If used in Actor, this will set the actor's icon to localplayer's steam avatar.
3. If included in Text, this will include the localplayer's name in the text, at the specified position.

## Example
Examples are located under gamemode/dialog/. 
We are trying to copy them to user on initial player spawn.  

```json
{
    "1": {
      "Name": "$SELF",
      "Actor": "$SELF",
      "Text": "Welcome to dialogue! Have a nice stay, $SELF.",
      "Speed": 0.06,
      "Voice": "vendingmachine",
      "Choice": {
        "c1": "TEST 1",
        "c2": "TEST 2",
        "c3": "TEST 3"
      }
    },
     "c1": {
      "1": {
        "Name": "$SELF",
        "Actor": "$SELF",
        "Text": "I PICKED CHOICE 1.",
        "Speed": 0.1
      },
      "2": {
        "Name":"Vending Machine",
        "Actor": "dialogue/vendingmachine/002",
        "Text": "CONGRATS.",
        "Voice": "vendingmachine",
        "Speed": 0.2
      }
    },
     "c2": {
      "1": {
        "Name": "$SELF",
        "Actor": "$SELF",
        "Text": "I PICKED CHOICE 2.",
        "Speed": 0.1
      },
      "2": {
        "Name":"Vending Machine",
        "Actor": "dialogue/vendingmachine/002",
        "Text": "CONGRATS.",
        "Voice": "vendingmachine",
        "Speed": 0.2
      }
    },
    "c3": {
      "1": {
        "Name": "$SELF",
        "Actor": "$SELF",
        "Text": "I PICKED CHOICE 3.",
        "Speed": 0.1
      },
      "2": {
        "Name":"Vending Machine",
        "Actor": "dialogue/vendingmachine/002",
        "Text": "CONGRATS.",
        "Voice": "vendingmachine",
        "Speed": 0.2
      }
    }
}
```
