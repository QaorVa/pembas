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
        echo '<table class="table table-striped">', 
                "<tr>",
                    "<th>ISBN</th>",
                    "<th>title</th>",
                    "<th>Author</th>",
                    "<th>Category</th>",
                    "<th>Publisher</th>",
                    "<th>Year Published</th>",
                    "<th>Copies available</th>",
                "</tr>";
        include "connection.php";
        $sql = "call bookAvail()";
        $query = $db->query($sql);
        foreach($query as $row) {
            echo "<tr>",
                    "<td>", $row['isbn'], "</td>",
                    "<td>", $row['title'], "</td>",
                    "<td>", $row['author'], "</td>",
                    "<td>", $row['category'], "</td>",
                    "<td>", $row['publisher'], "</td>",
                    "<td>", $row['year_published'], "</td>",
                    "<td>", $row['copies'], "</td>";
        }
        echo "</tr>", "</table>";
    ?>
    <script src="js/bootstrap.js"></script>
</body>
</html>