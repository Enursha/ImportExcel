function DoChart {
    param(
        $targetData,
        $title,
        [OfficeOpenXml.Drawing.Chart.eChartType]$ChartType,
        [Switch]$NoLegend,
        [Switch]$ShowCategory,
        [Switch]$ShowPercent,
        [Switch]$ShowValue
     )

     if($targetData[0] -is [System.ValueType]) {
         $chart = New-ExcelChart -YRange "A1:A$($targetData.count)" -Title $title -ChartType $ChartType
     } else {
         $xyRange = Get-XYRange $targetData

         $X = $xyRange.XRange.ExcelColumn
         $XRange = "{0}2:{0}{1}" -f $X,($targetData.count+1)

         $Y = $xyRange.YRange.ExcelColumn
         $YRange = "{0}2:{0}{1}" -f $Y,($targetData.count+1)

         $chart = New-ExcelChart -XRange $xRange -YRange $yRange -Title $title -ChartType $ChartType `
            -NoLegend:$NoLegend -ShowCategory:$ShowCategory -ShowPercent:$ShowPercent -ShowValue:$ShowValue
     }

     $xlFile = [System.IO.Path]::GetTempFileName() -replace "tmp","xlsx"
     $targetData | Export-Excel $xlFile -ExcelChartDefinition $chart -Show -AutoSize
}

function BarChart {
    param(
        [Parameter(ValueFromPipeline=$true)]
        $targetData,
        $title,
        [OfficeOpenXml.Drawing.Chart.eChartType]$ChartType="BarStacked",
        [Switch]$NoLegend,
        [Switch]$ShowCategory,
        [Switch]$ShowPercent,
        [Switch]$ShowValue        
    )

    Begin   { $data = @() }
    Process { $data += $targetData}

    End {
        DoChart $data $title -ChartType $ChartType `
            -NoLegend:$NoLegend -ShowCategory:$ShowCategory -ShowPercent:$ShowPercent -ShowValue:$ShowValue

    }
}

function PieChart {
    param(
        [Parameter(ValueFromPipeline=$true)]
        $targetData,
        $title,
        [OfficeOpenXml.Drawing.Chart.eChartType]$ChartType="PieExploded3D",
        [Switch]$NoLegend,
        [Switch]$ShowCategory,
        [Switch]$ShowPercent,
        [Switch]$ShowValue
    )

    Begin   { $data = @() }
    Process { $data += $targetData}

    End {
        DoChart $data $title -ChartType $ChartType `
            -NoLegend:$NoLegend -ShowCategory:$ShowCategory -ShowPercent:$ShowPercent -ShowValue:$ShowValue
    }
 }

function LineChart {
    param(
        [Parameter(ValueFromPipeline=$true)]
        $targetData,
        $title,
        [OfficeOpenXml.Drawing.Chart.eChartType]$ChartType="Line",
        [Switch]$NoLegend,
        [Switch]$ShowCategory,
        [Switch]$ShowPercent,
        [Switch]$ShowValue
    )

    Begin   { $data = @() }
    Process { $data += $targetData}

    End {
        DoChart $data $title -ChartType $ChartType `
            -NoLegend:$NoLegend -ShowCategory:$ShowCategory -ShowPercent:$ShowPercent -ShowValue:$ShowValue
    }
}

function ColumnChart {
    param(
        [Parameter(ValueFromPipeline=$true)]
        $targetData,
        $title,
        [OfficeOpenXml.Drawing.Chart.eChartType]$ChartType="ColumnStacked",
        [Switch]$NoLegend,
        [Switch]$ShowCategory,
        [Switch]$ShowPercent,
        [Switch]$ShowValue
    )

    Begin   { $data = @() }
    Process { $data += $targetData}

    End {
        DoChart $data $title -ChartType $ChartType `
            -NoLegend:$NoLegend -ShowCategory:$ShowCategory -ShowPercent:$ShowPercent -ShowValue:$ShowValue
    }
}