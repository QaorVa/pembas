<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <style>
        table,
        th,
        td {
            border: 1px solid black;
        }
    </style>
</head>

<body>
    <?php
    session_start();
    $readerId = $_SESSION['reader_id'];
    $isbn = $_POST['isbn'];
    $days = 7;
    include "connection.php";
    $sql = "call loanBook($isbn, $readerId, $days)";
    $query = $db->query($sql);
    $sql2 = "call loanHistory($readerId)";
    $query2 = $db->query($sql2);
    header("location:viewLoanHistoryProcess.php");
    ?>
    <script src="js/bootstrap.js"></script>
</body>

</html>