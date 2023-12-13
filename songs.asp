<%
If Session("username") = "" Then
    Response.Redirect("login.asp")
End If

' Establecer conexión a la base de datos
Dim conn, rs
Set conn = Server.CreateObject("ADODB.Connection")
conn.Open "Provider=SQLOLEDB;Data Source=localhost;Initial Catalog=BDD_PoliMusic;User ID=usr_polimusic;Password=usr_polimusic;"

' Consulta para obtener todas las canciones
Dim sql
sql = "SELECT * FROM TBL_SONG"
Set rs = conn.Execute(sql)

%>
<!DOCTYPE html>
<html>
<head>
    <title>Song List</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        audio {
            width: 100%;
        }
    </style>
</head>
<body>
    <h1>Welcome <%=Session("username")%></h1>
    <a href='logout.asp'>Logout</a>
    <h2>Song List</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Song Name</th>
            <th>Play</th>
            <th>Reproductions</th>
        </tr>
        <% 
        ' Mostrar las canciones obtenidas de la base de datos
        Do While Not rs.EOF
        %>
            <tr>
                <td><%= rs("ID_SONG") %></td>
                <td><%= rs("SONG_NAME") %></td>
                <td>
                    <audio controls>
                        <source src="<%= rs("SONG_PATH") %>" type="audio/mp3">
                        Tu navegador no soporta el elemento de audio.
                    </audio>
                </td>
                <td><%= rs("PLAYS") %></td>
            </tr>
        <%
            rs.MoveNext
        Loop
        %>
    </table>

    <% 
    ' Cerrar la conexión y liberar recursos
    rs.Close
    Set rs = Nothing
    conn.Close
    Set conn = Nothing
    %>
</body>
</html>
