--[[
    Format: {
        {
            Name: string, -- Label name, unused
            CSSClass: string, -- CSS class name
            Icon: string, -- Icon text
            Aliases: string[], -- Text for alias arguments in Infoboxes
            Prefix: string, -- Prefix to add before the number
            AffectedBy: string[] -- List of potions the stat can be affected by (should be Pets Infobox only)
        }
    }
    Old Format: {
        {
            string, -- Label name
            string, -- CSS class
            string, -- Icon text, appended by .png
            string -- Prefix to add before number
        }
    }
]]
return {
    -- Non-event
    {
        Name = "Bubbles",
        CSSClass = "Bubble",
        Icon = "Bubble.png",
        Aliases = {"bubble"},
        Prefix = "+",
        AffectedBy = {"PotionOfBubbles"}
    },
    {
        Name = "Coins",
        CSSClass = "Coin",
        Icon = "Coin.png",
        Aliases = {"coin"},
        Prefix = "x",
        AffectedBy = {"PotionOfMoney"}
    },
    {
        Name = "Gems",
        CSSClass = "Jewel",
        Icon = "Jewel.png",
        Aliases = {"jewel", "gem"},
        Prefix = "x",
        AffectedBy = {"PotionOfMoney"}
    },
    {
        Name = "Candy",
        CSSClass = "Candy-1",
        Icon = "Candy.png",
        Aliases = {"Candy-1"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    {
        Name = "Blocks",
        CSSClass = "Block",
        Icon = "Block.png",
        Aliases = {"Block"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    {
        Name = "Shells",
        CSSClass = "Shell",
        Icon = "Shell.png",
        Aliases = {"Shell"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    {
        Name = "Pearls",
        CSSClass = "Pearl",
        Icon = "Pearl.png",
        Aliases = {"Pearl"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    {
        Name = "Stars",
        CSSClass = "Star",
        Icon = "Star.png",
        Aliases = {"Star"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    {
        Name = "Magma",
        CSSClass = "Magma",
        Icon = "Magma.png",
        Aliases = {"Magma"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    {
        Name = "Candy Corn",
        CSSClass = "CandyC",
        Icon = "CandyC.png",
        Aliases = {"CandyC", "CandyCorn"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    {
        Name = "Crystals",
        CSSClass = "Crystal",
        Icon = "Crystal Icon.png",
        Aliases = {"Crystal"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    -- Events
    {
        Name = "Candy Canes",
        CSSClass = "Candy",
        Icon = "Candy Cane.png",
        Aliases = {"Candy", "CandyCane"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    {
        Name = "Gifts",
        CSSClass = "Gift",
        Icon = "Gift.png",
        Aliases = {"Gift"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    {
        Name = "Tickets",
        CSSClass = "Ticket",
        Icon = "Ticket.png",
        Aliases = {"Ticket"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    {
        Name = "Rainbows",
        CSSClass = "Rainbows",
        Icon = "Rainbows.png",
        Aliases = {"Rainbows"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    {
        Name = "Flowers",
        CSSClass = "Flower",
        Icon = "Flower.png",
        Aliases = {"Flower"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    {
        Name = "Tokens",
        CSSClass = "Token",
        Icon = "Token.png",
        Aliases = {"Token"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    {
        Name = "Treats",
        CSSClass = "Treat",
        Icon = "Treat.png",
        Aliases = {"Treat"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    {
        Name = "Silver",
        CSSClass = "Silver",
        Icon = "Silver.png",
        Aliases = {"Silver"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    {
        Name = "Lollipops",
        CSSClass = "Lollipop",
        Icon = "Lollipop.png",
        Aliases = {"Lollipop"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    -- Other
    {
        Name = "All",
        CSSClass = "All",
        Icon = "All.png",
        Aliases = {"All"},
        Prefix = "x",
        AffectedBy = {"PotionOfWorlds"}
    },
    {
        Name = "Robux",
        CSSClass = "Robux",
        Icon = "Icon-Robux.png",
        Aliases = {"robux"},
        Prefix = "",
        AffectedBy = {}
    }
}