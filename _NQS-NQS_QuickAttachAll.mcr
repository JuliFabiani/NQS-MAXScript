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