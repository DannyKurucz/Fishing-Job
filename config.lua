cfg = {
    
    esxLegacy = true,

    job = {
        ['job'] = "fish"
    },

    blip = {
        ['blip'] = vector3(-1690.3127, -1076.2634, 13.1522),
        ['blipfishing'] = vector3(-3830.4604, 892.7607, 0.6006),
        ['boatrent'] = vector3(-3426.8962, 966.0803, 8.3467),
        ['sell'] = vector3(-1319.8011, -1321.5725, 4.7664),

    },

    translation = {
        ['jobblip'] = "Fishing Shop",
        ['blipfishing'] = "Fishing zone",
        ['buy'] = "[E] Shop",
        ['rodname'] = "Rod - 100$",
        ['limit'] = "You have no place in inventory",
        ['fishingboat'] = "you have to be on the boat you rented",
        ['instruction'] = "Press ~INPUT_ATTACK~ to cast line, ~INPUT_FRONTEND_RRIGHT~ to cancel.",
        ['rodbroke'] = "You pulled to hard and your fishing rod snapped!",
        ['startedfish'] = "Fishing started",
        ['cannotfish'] = "You can not fish from a vehicle",
        ['awayfromshore'] = "You need to go further away from the shore",
        ['rentboat'] = "[E] Rent Boat",
        ['boat'] = "Rent Boat",
        ['return'] = "[E] Return Boat",
        ['sell'] = "Sell Fish",
        ['sellfish'] = "[E] Sell Fish",
        ['nofish'] = "You don't have fish"
    },

    marker = {
        ['buy'] = vector3(-1690.4761, -1076.6194, 13.1522),
        ['rentboat'] = vector3(-3427.3367, 966.9029, 8.3467),
        ['boatspawn']  = vector3(-3434.2373, 962.1888, -0.3905),
        ['sell'] = vector3(-1320.4606, -1321.9481, 4.7596),

    },

    shop = {
        ['price'] = 100
    },

    breakchance = {
        ['break'] = 50
    },

    items = {
        ['rod'] = "rod",
        ['fish'] = "fish",
        ['fish1'] = "fish1",
        ['fish2'] = "fish2",
    },

    breakrodchange = {
        ['chance'] = 10
    }
}


Notify = function(msg)
    ESX.ShowNotification(msg)
end
