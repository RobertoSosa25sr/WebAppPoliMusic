<%
' Establish a connection to the SQL Server database
Dim conn, rs
Set conn = Server.CreateObject("ADODB.Connection")
conn.Open "Server=tcp:polimusicserver.database.windows.net,1433;Initial Catalog=BDD_PoliMusic;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;Authentication=Active Directory Default;"

' Function to sanitize input
Function CleanInput(input)
    CleanInput = Replace(input, "'", "''")
End Function

' Check if the form has been submitted
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    ' Retrieve username and password from the form
    Dim username, password
    username = CleanInput(Request.Form("username"))
    password = CleanInput(Request.Form("password"))

    ' Query to validate the username and password
    Dim sql, isValid
    sql = "SELECT * FROM TBL_USER WHERE USERNAME = '" & username & "' AND PASSWORD = '" & password & "'"
    Set rs = conn.Execute(sql)

    ' Check if the query returned a matching user
    If Not rs.EOF Then       
        ' User authenticated, redirect to songs.asp
        Session("username") = username
        'Session("username") = rs("USERNAME")
        Response.Redirect "songs.asp"
    Else
        ' Invalid credentials, show an error message or redirect to an error page
        Response.Write "Invalid username or password."
    End If

    rs.Close
End If

' Close the database connection
conn.Close
Set conn = Nothing
%>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>

<form method="post" action="login.asp">
    <label for="username">Username:</label>
    <input type="text" id="username" name="username" required><br><br>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required><br><br>

    <input type="submit" value="Login">
</form>

</body>
</html>
