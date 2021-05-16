return {
    {
        Label = "Normal",
        StatMultiplier = 1,
        ChanceMultiplier = 1,
        Image = "Image1",
        Caption = "Caption1",
        Invert = true,
        InvertImage = nil,
        RequiresMythic = false,
        StatsHeader = "Base Stats"
    },
    {
        Label = "Shiny",
        StatMultiplier = 2,
        ChanceMultiplier = 100,
        Image = "Image2",
        Caption = "Caption2",
        Invert = true,
        InvertImage = "Image1",
        RequiresMythic = false,
        StatsHeader = "Shiny Base Stats"
    },
    {
        Label = "Mythic",
        StatMultiplier = 1.5,
        ChanceMultiplier = 200,
        Image = "Image3",
        Caption = "Caption3",
        Invert = false,
        InvertImage = nil,
        RequiresMythic = true,
        StatsHeader = "Mythic Base Stats"
    },
    {
        Label = "Shiny Mythic",
        StatMultiplier = 3,
        ChanceMultiplier = 20000,
        Image = "Image4",
        Caption = "Caption4",
        Invert = true,
        InvertImage = "Image3",
        RequiresMythic = true,
        StatsHeader = "Shiny Mythic Base Stats"
    }
}