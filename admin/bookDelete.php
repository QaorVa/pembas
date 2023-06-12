<?php
$id = $_GET['id'];
include "../connection.php";
$sql = "call deleteBook('$id')";
$query = $db->query($sql);
header("location:index.php?alert=delete");
