macroScript NQS_Util
category:"#NQS"
tooltip:"[_] NQS Rollout"
buttonText:"NQS"
(
    rollout NQS_Rollout "NQS" (

        group "NQS - Propiedades de objeto" (
            button btn1 "Renombrar por Capas (Selección)" tooltip:"Renombra y numera los objetos seleccionados como 'NombreDeCapa_001'"
            button btn2 "Asignar Colores Aleatorios (Selección)" tooltip:"Asigna a los objetos seleccionados distintos colores aleatorios."
            button btn3 "Asignar el Mismo Color Aleatorio (Selección)" tooltip:"Asigna a los objetos seleccionados un mismo color aleatorio."
            button btn9 "Asignar el Mismo HUE (Selección)" tooltip:"Asigna a los objetos seleccionados el mismo HUE, pero distinta saturación/brillo."
        )
        group "NQS - Geometría" (
            button btn10 "Extrude Vertex (Spline)" tooltip:"Duplica el segmento seleccionado/primer vértice/último vértice para hacer una extrusión."
            button btn11 "Clean Edit Poly SG (Selección)" tooltip:" Limpia todos los Smoothing Groups de los Edit Poly que estén seleccionados, tanto en baseObjects como en modifiers."

        )
        group "NQS - RailClone" (
            button btn4 "Centrar Pivot (Selección)" tooltip:"Centra el Pivot al primer objeto que haya sido seleccionado."
            button btn5 "Seleccionar Base-Line (RailClone)" tooltip:"Selecciona la Base-Line del objeto (clase RailClone) seleccionado."
        )
        group "NQS - QuickAttach" (
            button btn7 "Colapsar selección a un objeto" tooltip:"Quick Attach a todos los objetos de la selección."
            button btn8 "Colapsar todo a un objeto" tooltip:"Quick Attach a todos los objetos de la escena."
        )
        group "NQS - Render Elements" (
            button btn6 "G-BufferID Override Checker" tooltip:"Selección por material que tengan un G-BufferID Override específico."

        )

        on btn1 pressed do macros.run "#NQS" "NQS_RenameByLayer"
        on btn2 pressed do macros.run "#NQS" "NQS_RandomColor"
        on btn3 pressed do macros.run "#NQS" "NQS_SameColor"
        on btn4 pressed do macros.run "#NQS" "NQS_CentrarPivot"
        on btn5 pressed do macros.run "#NQS" "NQS_SelectBaseLine"
        on btn6 pressed do macros.run "#NQS" "NQS_GBufferIDChecker"
        on btn7 pressed do macros.run "#NQS" "NQS_QuickAttachSel"
        on btn8 pressed do macros.run "#NQS" "NQS_QuickAttachAll"
        on btn9 pressed do macros.run "#NQS" "NQS_SameHUE"
        on btn10 pressed do macros.run "#NQS" "NQS_ExtrudeVertexSegment"
        on btn11 pressed do macros.run "#NQS" "NQS_CleanSG"

    )    
    CreateDialog NQS_Rollout width:300

)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
macroScript NQS_RenameByLayer
category:"#NQS"
buttonText:"RenameByLayer"
tooltip:"[Selección] Renombrar por capa"
(
    undo on (
        for i = 0 to (LayerManager.count - 1) where (LayerManager.getlayer i).name != "0" do
        (
            l = (LayerManager.getlayer i)
            num = 0
            for o in selection where o.layer == l do (
                a = filterString o.layer.name "-"
                if a[a.count][1] == " " then a[a.count][1] = ""
                newname = a[a.count]+"_"+(formattedprint (num) format:"03d")
                print (o.name + " => " + newname)
                o.name = newname
                num += 1
            )
        )
    )   
)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
macroScript NQS_CentrarPivot
category:"#NQS"
buttonText:"CentrarPivot"
tooltip:"[Selección] Centrar pivots"
(
    undo on (
        for o in selection do try (o.pivot = selection[1].pivot) catch ()
    )
)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
macroScript NQS_GBufferIDChecker
category:"#NQS"
buttonText:"GBufferIDChecker"
tooltip:"[Rendering] Seleccionar objetos con G-Buffer Override"
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

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
macroScript NQS_QuickAttachSel
category:"#NQS"
buttonText:"QuickAttachSelection"
tooltip:"[QuickAttach] Colapsar seleccion a un objeto"
(
        --This script created by Morozov Anton
    seq = 300 -- how many objectts add to one part
    arr = (selection as array)
    clearSelection()
    count = 0
    meshes=#()
    with undo off with redraw off
    (
    b = Editable_Mesh()
    b.name = arr[1].name
    append meshes b
        for i = 1 to arr.count do
        (
            count += 1
            if count >= seq do (
                count = 1
                b = Editable_Mesh()
                b.name = arr[i].name
                append meshes b
                precents = 0 as float
                precents = 1000/(arr.count*10 / i)
                format "[%:%:%] %\%\n" (floor (timestamp() / 3600000)) (mod (floor (timestamp() / 60000)) 60) (mod (floor (timestamp() / 1000)) 60) (precents as string)
            )
            if SuperClassOf (arr[i]) == GeometryClass do
                meshop.attach b arr[i] attachMat:#IDToMat condenseMat:true deleteSourceNode:true
        )
        if meshes.count > 1 do (
            b = meshes[1]
            for i = 2 to meshes.count do
                (
                    meshop.attach b meshes[i] attachMat:#IDToMat condenseMat:true deleteSourceNode:true
                )
        )
        select b
        mymax = b.max
        mymin = b.min
        b.pivot = [(mymax.x+mymin.x)/2, (mymax.y+mymin.y)/2, (mymax.z+mymin.z)/2]
    )
)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
macroScript NQS_QuickAttachAll
category:"#NQS"
buttonText:"QuickAttachAll"
tooltip:"[QuickAttach] Colapsar escena completa a un objeto"
(
        --This script created by Morozov Anton
    seq = 300 -- how many objectts add to one part
    arr = (objects as array)
    clearSelection()
    count = 0
    meshes=#()
    with undo off with redraw off
    (
    b = Editable_Mesh()
    b.name = arr[1].name
    append meshes b
        for i = 1 to arr.count do
        (
            count += 1
            if count >= seq do (
                count = 1
                b = Editable_Mesh()
                b.name = arr[i].name
                append meshes b
                precents = 0 as float
                precents = 1000/(arr.count*10 / i)
                format "[%:%:%] %\%\n" (floor (timestamp() / 3600000)) (mod (floor (timestamp() / 60000)) 60) (mod (floor (timestamp() / 1000)) 60) (precents as string)
            )
            if SuperClassOf (arr[i]) == GeometryClass do
                meshop.attach b arr[i] attachMat:#IDToMat condenseMat:true deleteSourceNode:true
        )
        if meshes.count > 1 do (
            b = meshes[1]
            for i = 2 to meshes.count do
                (
                    meshop.attach b meshes[i] attachMat:#IDToMat condenseMat:true deleteSourceNode:true
                )
        )
        select b
        mymax = b.max
        mymin = b.min
        b.pivot = [(mymax.x+mymin.x)/2, (mymax.y+mymin.y)/2, (mymax.z+mymin.z)/2]
    )
)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
macroScript NQS_ExtrudeVertexSegment
category:"#NQS"
buttonText:"ExtrudeVertexSegment"
tooltip:"[Spline] Extrude Vertex/Segment"
(
    undo on (

        if(subObjectLevel == 2) do (
            shape = selection[1]

            for spline=1 to (numSplines shape) do (

                selSegs = (getSegSelection shape spline)

                for s = selSegs.count to 1 by -1 do (

                    format "spline: %, seg: %\n" spline selSegs[s]

                    refineSegment shape spline selSegs[s] 1
                    refineSegment shape spline selSegs[s] 0
                )
                
                newSel = for s=1 to selSegs.count collect (selSegs[s] + s*2-1)
                setSegSelection shape spline newSel

            )
            updateshape shape
        )
        if(subObjectLevel == 1) do (
            shape = selection[1]
            for spline=1 to (numSplines shape) do (

                _v = getKnotSelection shape spline
                if not _v.count == 1 do exit
                vert = _v[1]

                if (vert == (numKnots shape spline)) do (
                    addKnot shape spline #corner #line (getKnotPoint shape spline vert) (numKnots shape spline)
                    updateshape shape
                    setKnotSelection shape spline #(vert+1)
                )
                if (vert == 1) do (
                    addKnot shape spline #corner #line (getKnotPoint shape spline vert) 1
                    updateshape shape
                    setKnotSelection shape spline #(1)
                )

            )

        )

    )
)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
