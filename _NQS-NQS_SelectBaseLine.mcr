macroScript NQS_SelectBaseLine
category:"#NQS"
buttonText:"SelectBaseLine"
tooltip:"[RailClone] Seleccionar Base-Line"
(
    sel = #()
    for o in selection where (isProperty o #banode) do (
        for b in o.banode where superclassof b == shape do append sel b
    )

    for o in selection where (superclassof o == shape) do (
        for rc in objects where (classof rc == RailClone_Pro and findItem rc.banode o) do (append sel rc)
    )

    
    if sel.count > 0 then (clearSelection();select sel)
)
