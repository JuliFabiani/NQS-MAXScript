macroScript NQS_RandomColor
category:"#NQS"
buttonText:"RandomColor"
tooltip:"[Selección] Asignar color aleatorio"
(
    undo on (
        for o in selection do try (
            o.wirecolor = color (random 70 255) (random 70 255) (random 70 255) 
            o.colorByLayer = off
        ) catch ()
    )
    redrawViews()
)
