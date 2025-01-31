macroScript NQS_CleanSG
category:"#NQS"
buttonText:"CleanSG"
tooltip:"[Edit Poly] Clean Smoothing Groups"
(
    undo on (

        for o in selection do (

            if (classof o.baseObject == Editable_Poly) do (
                format "OBJETO '%' (%) >>> cleaning sg\n" o.name (classof o.baseObject)
                numFaces = polyop.getNumfaces o.baseObject
                polyop.setFaceSmoothGroup o.baseObject #{1..numFaces} 0
            )

            for m in o.modifiers do (
                if (classof m == Edit_Poly) do (

                    format "OBJETO '%' (%) / MODIFICADOR '%' (%) >>> cleaning sg\n" o.name (classof o.baseObject) m.name (classof m)

                        m.SetSelection #Face #{1..(editPolyMod.GetNumFaces m)}
                        
                        m.SetOperation #SetSmooth
                        m.smoothingGroupsToSet = 0
                        m.smoothingGroupsToClear = -1
                )
            )
        )

    )
)