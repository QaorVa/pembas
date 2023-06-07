<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <style>
        table, th, td {
            border:1px solid black;
        }
    </style>
</head>
<body>
    <?php
        $readerId = $_POST['readerId'];
        $isbn = $_POST['isbn'];
        $loanId = $_POST['loanId'];
        echo '<table class="table table-striped">', 
                "<tr>",
                    "<th>Loan ID</th>",
                    "<th>Book</th>",
                    "<th>Borrowed Date</th>",
                    "<th>Returned Date</th>",
                "</tr>";
        include "connection.php";
        $sql = "call loanBook($isbn, $readerId, $loanId)";
        $query = $db->query($sql);
        $sql2 = "call loanHistory($readerId)";
        $query2 = $db->query($sql2);
        foreach($query2 as $row) {
                echo "<tr>",
                    "<td>", $row['Loan_ID'], "</td>",
                    "<td>", $row['Book'], "</td>",
                    "<td>", $row['Borrowed'], "</td>",
                    "<td>", $row['Returned'], "</td>";
        }
        echo "</tr>", "</table>";
    ?>
    <script src="js/bootstrap.js"></script>
</body>
</html>