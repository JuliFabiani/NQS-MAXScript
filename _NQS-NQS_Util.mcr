macroScript NQS_Util
category:"#NQS"
tooltip:"[_] NQS Rollout"
buttonText:"NQS"
(
    rollout NQS_Rollout "NQS" (

        group "NQS - General" (
            button btn1 "Renombrar por Capas (Selección)" tooltip:"Renombra y numera los objetos seleccionados como 'NombreDeCapa_001'"
            button btn2 "Asignar Colores Aleatorios (Selección)" tooltip:"Asigna a los objetos seleccionados distintos colores aleatorios."
            button btn3 "Asignar el Mismo Color Aleatorio (Selección)" tooltip:"Asigna a los objetos seleccionados un mismo color aleatorio."
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

    )    
    CreateDialog NQS_Rollout width:300

)
