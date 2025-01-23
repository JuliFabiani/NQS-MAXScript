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
