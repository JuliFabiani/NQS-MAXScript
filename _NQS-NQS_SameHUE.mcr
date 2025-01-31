macroScript NQS_SameHUE
category:"#NQS"
buttonText:"SameHUE"
tooltip:"[Selección] Asignar mismo HUE"
(

    fn HSVtoRGB hsv = (
        local h = hsv[1]
        local s = hsv[2]
        local v = hsv[3]
        
        local c = v * s
        local x = c * (1 - abs(mod (h / 60.0) 2 - 1))
        local m = v - c
        
        local r = 0.0
        local g = 0.0
        local b = 0.0
        
        if h < 60 then (
            r = c; g = x; b = 0
        ) else if h < 120 then (
            r = x; g = c; b = 0
        ) else if h < 180 then (
            r = 0; g = c; b = x
        ) else if h < 240 then (
            r = 0; g = x; b = c
        ) else if h < 300 then (
            r = x; g = 0; b = c
        ) else (
            r = c; g = 0; b = x
        )
        
        r = (r + m) * 255
        g = (g + m) * 255
        b = (b + m) * 255
        
        return (color r g b)
    )

    undo on (
        hue = random 0.0 360.0

        for o in selection do try (

            o.wirecolor = HSVtoRGB [hue, random 0.15 1.0, random 0.3 1.0]
            o.colorByLayer = off
        ) catch ()
    )
    redrawViews()
)
