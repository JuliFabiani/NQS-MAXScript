macroScript NQS_CentrarPivot
category:"#NQS"
buttonText:"CentrarPivot"
tooltip:"[Selecci�n] Centrar pivots"
(
    undo on (
        for o in selection do try (o.pivot = selection[1].pivot) catch ()
    )
)
