if ($args.length -eq 3)
{
    $db1 = $args[0]
    $db2 = $args[1]
    $dbPass = $args[2]
    $dbPass2 = $args[2]
}
elseif ($args.length -eq 4)
{
    $db1 = $args[0]
    $db2 = $args[1]
    $dbPass = $args[2]
    $dbPass2 = $args[3]
}
else
{
    echo "USAGE: sqldiff_with_pass.ps1 [DB1] [DB2] [PASSWORD]"
    return
}
# Add-Type -Path "System.Data.SQLite.dll"
function change_sql_pass ($db, $from, $to)
{
    $dbFilePath = (Resolve-Path $db).Path
    $sqlCon = New-Object System.Data.SQLite.SQLiteConnection("Data Source=" + $dbFilePath + " ; password=" + $from)
    $sqlCon.Open()
    $sqlCon.ChangePassword(@($to))
    $sqlCon.Dispose()
}
$emptyPass = ''
change_sql_pass $db1 $dbPass $emptyPass
change_sql_pass $db2 $dbPass2 $emptyPass
C:\sqlite\sqldiff.exe $db1 $db2
change_sql_pass $db1 $emptyPass $dbPass
change_sql_pass $db2 $emptyPass $dbPass2
