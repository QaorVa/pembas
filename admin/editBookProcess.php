<?php
$isbn = $_POST['isbn'];
$title = $_POST['title'];
$author = $_POST['author'];
$category = $_POST['category'];
$publisher = $_POST['publisher'];
$year_published = $_POST['year_published'];
$copies = $_POST['copies'];
include "../connection.php";
$sql = "call editBook('$isbn', '$title', '$author', '$category', '$publisher', '$year_published', '$copies')";
$query = $db->query($sql);
header("location:index.php?alert=update");
