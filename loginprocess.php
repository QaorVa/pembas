<?php
// menghubungkan dengan koneksi
include "connection.php";

// menangkap data yang dikirim dari form
$email = $_POST['email'];
$password = $_POST['password'];

$masuk = mysqli_query($db, "SELECT * FROM reader WHERE email = '$email' AND password = '$password'");
$kontol = mysqli_num_rows($masuk);

if ($kontol > 0) {
    session_start();
    $data = mysqli_fetch_assoc($masuk);

    // buat session member
    $_SESSION['reader_id'] = $data['reader_id'];
    $_SESSION['member_status'] = "login";
    header("location:index2.php");
} else {
    header("location:masuk.php?alert=gagal");
}
