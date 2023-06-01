Option Explicit

Sub DeleteDuplicateEmails()
    Dim objNamespace As NameSpace
    Dim objArchiveFolder As Folder
    Dim objItems As Items
    Dim objMail As MailItem
    Dim objDictionary As Object
    Dim lngMailCount As Long
    Dim intIndex As Integer

    Set objNamespace = GetNamespace("MAPI")
    Set objArchiveFolder = GetFolderPath("tonami-yuhto@ust.jmuc.co.jp\アーカイブ")
    Set objItems = objArchiveFolder.Items
    Set objDictionary = CreateObject("Scripting.Dictionary")

    lngMailCount = objItems.Count

    For intIndex = lngMailCount To 1 Step -1
        If objItems.Item(intIndex).Class = olMail Then
            Set objMail = objItems.Item(intIndex)
            If objDictionary.Exists(GenerateMailIdentifier(objMail)) Then
                objMail.Delete
            Else
                objDictionary.Add GenerateMailIdentifier(objMail), True
            End If
        End If
    Next intIndex


    MsgBox "重複メールを削除しました。"

    Set objDictionary = Nothing
    Set objMail = Nothing
    Set objItems = Nothing
    Set objArchiveFolder = Nothing
    Set objNamespace = Nothing
End Sub

Function GenerateMailIdentifier(objMail As MailItem) As String
    Dim mailBody As String
    Dim first10Lines As String
    Dim i As Long
    Dim lineCount As Integer
    
    mailBody = objMail.Body
    first10Lines = ""
    lineCount = 0
    
    For i = 1 To Len(mailBody)
        If Mid(mailBody, i, 1) = vbCrLf Then
            lineCount = lineCount + 1
            If lineCount >= 10 Then Exit For
        End If
        first10Lines = first10Lines & Mid(mailBody, i, 1)
    Next i
    
    GenerateMailIdentifier = objMail.Subject & _
                              objMail.SenderEmailAddress & _
                              Format(objMail.ReceivedTime, "yyyy-mm-dd hh:nn:ss") & _
                              first10Lines
End Function

Function GetFolderPath(ByVal strFolderPath As String) As Folder
    Dim objApp As Outlook.Application
    Dim objNS As Outlook.NameSpace
    Dim colFolders As Outlook.Folders
    Dim objFolder As Outlook.Folder
    Dim arrFolders() As String
    Dim i As Long

    On Error Resume Next

    strFolderPath = Replace(strFolderPath, "/", "\")
    arrFolders() = Split(strFolderPath, "\")
    Set objApp = Application
    Set objNS = objApp.GetNamespace("MAPI")
    Set objFolder = objNS.Folders.Item(arrFolders(0))
    If Not objFolder Is Nothing Then
        For i = 1 To UBound(arrFolders)
            Set colFolders = objFolder.Folders
            Set objFolder = colFolders.Item(arrFolders(i))
            If objFolder Is Nothing Then
                Exit For
            End If
        Next
    End If

    Set GetFolderPath = objFolder
    Set colFolders = Nothing
    Set objFolder = Nothing
    Set objNS = Nothing
    Set objApp = Nothing
End Function


