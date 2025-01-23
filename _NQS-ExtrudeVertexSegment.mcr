macroScript ExtrudeVertexSegment

category:"#NQS"
tooltip:"Extrude Vertex/Segment"
buttonText:"Extrude Vertex/Segment"

(

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