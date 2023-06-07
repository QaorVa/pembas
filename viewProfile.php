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
        echo '<table class="table table-striped">', 
                "<tr>",
                    "<th>ID</th>",
                    "<th>Name</th>",
                    "<th>Age</th>",
                    "<th>Address</th>",
                    "<th>Phone Number</th>",
                    "<th>Email</th>",
                    "<th>Password</th>",
                "</tr>";
        include "connection.php";
        $sql = "call selectProfile($readerId)";
        $query = $db->query($sql);
        foreach($query as $row) {
            echo "<tr>",
                    "<td>", $row['reader_id'], "</td>",
                    "<td>", $row['name'], "</td>",
                    "<td>", $row['age'], "</td>",
                    "<td>", $row['address'], "</td>",
                    "<td>", $row['phone_no'], "</td>",
                    "<td>", $row['email'], "</td>",
                    "<td>", $row['password'], "</td>";
        }
        echo "</tr>", "</table>";
    ?>
    <script src="js/bootstrap.js"></script>
</body>
</html>