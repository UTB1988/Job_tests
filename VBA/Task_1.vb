'Написать макрос, который:
'	1. Заполняет матрицу 10*10 с ячейки "A1" на листе 1 случайными целыми цифрами от 0 до 10
'	2. Закрашивает ячейки, содержащие чётные значения
'	3. Копирует адреса закрашенных ячеек в столбце "A:A" на листе 2 (сначала идёт первый столбец матрицы, потом второй и т.д.)

Sub Task_1()

    Application.ScreenUpdating = False
    
        Dim My_object As Range
        Set My_object = Worksheets(1).Range("A1:J10")
        
        Dim Cell As Range
        
        For Each Cell In My_object
            
            Cell.Value = WorksheetFunction.RandBetween(1, 10)
            
            If Cell.Value Mod 2 = 0 Then
                Cell.Interior.Color = vbYellow
                
                
                Dim archive_rng As Range
                Dim archive_str As String: archive_str = "Строка" & " " & Cell.Row & " " & "Столбец" & " " & Cell.Column & " ; " & Cell.Address & " ; " & Cell.AddressLocal
                
                If Worksheets(2).Range("A1") = "" Then
                    Worksheets(2).Range("A1") = archive_str
                ElseIf Worksheets(2).Range("A1") <> "" And Worksheets(2).Range("A2") = "" Then
                    Worksheets(2).Range("A2") = archive_str
                Else
                    Set archive_rng = Worksheets(2).Range("A1")
                    Set archive_rng = archive_rng.End(xlDown).Offset(1, 0)
                    archive_rng.Value = archive_str
                End If
                
            End If
        
        Next Cell

    Application.ScreenUpdating = True
    
End Sub