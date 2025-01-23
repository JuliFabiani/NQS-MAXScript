macroScript NQS_SameColor
category:"#NQS"
buttonText:"SameColor"
tooltip:"[Selección] Asignar mismo color aleatorio"
(
    undo on (
        rcolor = color (random 70 255) (random 70 255) (random 70 255) 
        for o in selection do try (
            o.wirecolor = rcolor
            o.colorByLayer = off
        ) catch ()
    )
    redrawViews()
)
