<?php
include "../connection.php";
$isbn = $_POST['isbn'];
$title = $_POST['title'];
$author = $_POST['author'];
$category = $_POST['category'];
$publisher = $_POST['publisher'];
$year_published = $_POST['year_published'];
$copies = $_POST['copies'];

$cek_isbn = mysqli_query($db, "SELECT isbn FROM book where isbn = $isbn");
if (mysqli_num_rows($cek_isbn) > 0) {
    header("location:index.php?alert=duplikat");
} else {
    $sql = "call createBook('$isbn', '$title', '$author', '$category', '$publisher', '$year_published', '$copies')";
    $query = $db->query($sql);
    header("location:index.php?alert=add");
}
