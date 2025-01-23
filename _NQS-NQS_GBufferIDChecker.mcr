macroScript NQS_GBufferIDChecker
category:"#NQS"
tooltip:"[Rendering] Seleccionar objetos con G-Buffer Override"
buttonText:"GBufferIDChecker"
(
    --#####  VARIABLES
    global NQS_OverrideIDCheckerRollout
    listMats = #()
    overrideIDs = #()
    re = maxOps.GetCurRenderElementMgr()
    maskPrefix = "CMasking_GBufID_"

    --#####  STRUCTS 
    struct matG (
        mat,
        submat,
        overrideID
    )

    --#####  FUNCIONES


    --#####  ROLLOUT
    rollout NQS_OverrideIDCheckerRollout "OverrideID Checker" height:500 width:500
    (
        --###################################################
        button b_refresh "Refresh" align:#left

        group "Material G-Buffer ID Override" (
            button b_mat_make "Crear Render Elements" align:#left
            button b_mat_del "Clean Up" align:#right offset:[0,-25]
        
            subrollout srmat "srmat" height:(NQS_OverrideIDCheckerRollout.height-90)
        )
--      group "Object G-Buffer ID Override" (
--          subrollout srobj "srobj" height:(NQS_OverrideIDCheckerRollout.height-10)
--      )

        --###################################################
        fn compareOverrideID obj1 obj2 =
        (
            if obj1.overrideID < obj2.overrideID then -1
            else if obj1.overrideID > obj2.overrideID then 1
            else 0
        )
        fn matSel m = (
            select (for o in objects where o.material == listMats[m].mat collect o)
        )

        fn refresh = (
            destroyDialog NQS_OverrideIDCheckerRollout
            createDialog NQS_OverrideIDCheckerRollout
        )

        fn clearRE = (
            for n=re.numrenderelements()-1 to 0 by -1 do (
                mre = (re.GetRenderElement n)
                if mre.mode == 1 do (
                    if mre.materialROn and (findItem overrideIDs mre.materialR) do ( mre.materialROn = false ; mre.materialR = 0)
                    if mre.materialGOn and (findItem overrideIDs mre.materialG) do ( mre.materialGOn = false ; mre.materialG = 0)
                    if mre.materialBOn and (findItem overrideIDs mre.materialB) do ( mre.materialBOn = false ; mre.materialB = 0)
                ) 

                if not (mre.materialROn and mre.materialGOn and mre.materialBOn) do re.RemoveRenderElement mre
            )
            refresh()
        )

        fn makeRE = (
            
            for id in overrideIDs do (
                local elem = CMasking_Mask()
                local channel = mod (id-1) 3
                local index = (id-1)/3+1

                local nf = true
                for n=0 to re.numrenderelements()-1 while nf do (
                    if ((re.GetRenderElement n).elementname == (maskPrefix+(formattedprint (index) format:"03d"))) do (nf = false ; elem = (re.GetRenderElement n))
                )

                elem.mode = 1
                if channel == 0 then          (elem.materialROn = true ; elem.materialR = id)
                else if channel == 1 then     (elem.materialGOn = true ; elem.materialG = id)
                else if channel == 2 then     (elem.materialBOn = true ; elem.materialB = id)
        
                local rename = maskPrefix+(formattedprint (index) format:"03d")
                elem.elementname = rename
            
                if nf do re.addrenderelement (copy elem)

            )
            refresh()
        )

        --###################################################
        on b_refresh pressed do refresh()
        on b_mat_make pressed do makeRE()
        on b_mat_del pressed do clearRE()

        on NQS_OverrideIDCheckerRollout open do (

            --Definir variables
            listMats = #()
            overrideIDs = #()

            --Iterar por los materiales de la escena y guardarlos
            for m in scenematerials do 
            ( 
                if isProperty m #gBufferOverride and m.gBufferOverride > -1 then (

                    local mat = matG mat:m overrideID:m.gBufferOverride
                    append listMats mat
                    appendIfUnique overrideIDs m.gBufferOverride
                )
                if classof m == Multimaterial then (

                    for sm in m do 
                    ( 
                        if isProperty sm #gBufferOverride and sm.gBufferOverride > -1 then (

                            local mat = matG mat:m overrideID:sm.gBufferOverride submat:sm
                            append listMats mat
                            appendIfUnique overrideIDs sm.gBufferOverride
                        )
                    ) 
                )
            )

            --Ordenar las listas
            qsort listMats compareOverrideID
            sort overrideIDs

            --Crear los rollouts (uno por G-Buffer ID)
            subrollouts = #()
            for i in overrideIDs do (

                rci = rolloutCreator (("rollout_"+i as string)) (("Material GBuf ID: "+i as string))
                rci.begin()

                --Iterar por los materiales con Override y crear botones (uno por Material)
                for j=1 to listMats.count where listMats[j].overrideID == i do (
                    local buttonName = "btn_" + i as string + "_" + j as string
                    local mmname = ""
                    if not listMats[j].submat == undefined then try ( mmname = " (Sub-Obj Material: " + (listMats[j].submat.name) + ")") catch ()
                    rci.addControl #button buttonName (listMats[j].mat.name + mmname)
                    rci.addLocal "m" init:j
                    rci.addHandler buttonName #pressed codeStr:"NQS_OverrideIDCheckerRollout.matSel m"


                )

                --Agregar label de Render Element
                for n=0 to re.numrenderelements()-1 do (
                    mre = (re.GetRenderElement n)
                    if classof mre == CMasking_Mask then (
                        if mre.mode == 0 and mre.materialMonoOn and mre.materialMono == i then rci.addControl #label ("lblb_"+n as string) ("Render Element: '"+mre.name+"' (Mono)") paramStr:"align:#left"
                        else if mre.mode == 1 and mre.materialROn and mre.materialR == i then rci.addControl #label ("lblr_"+n as string) ("Render Element: '"+mre.name+"' (Red)") paramStr:"align:#left"
                        else if mre.mode == 1 and mre.materialGOn and mre.materialG == i then rci.addControl #label ("lblg_"+n as string) ("Render Element: '"+mre.name+"' (Green)") paramStr:"align:#left"
                        else if mre.mode == 1 and mre.materialBOn and mre.materialB == i then rci.addControl #label ("lblb_"+n as string) ("Render Element: '"+mre.name+"' (Blue)") paramStr:"align:#left"
                    )
                )

                --Meter el subrollout dinámico (rci) dentro del subrollout-mail (srmat)
                AddSubRollout NQS_OverrideIDCheckerRollout.srmat (rci.end())
            )

        )
    )
    createDialog NQS_OverrideIDCheckerRollout
)
