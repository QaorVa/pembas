<?php include 'header.php'; ?>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">SISTEM INFORMASI PERPUSTAKAAN</h1>
                </div><!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item active">Daftar Buku</li>
                    </ol>
                </div><!-- /.col -->
            </div><!-- /.row -->
        </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Daftar Buku</h3>
                    </div>
                    <!-- /.card-header -->
                    <div class="card-body">
                        <?php
                        if (isset($_GET['alert'])) {
                            if ($_GET['alert'] == "update") {
                                echo "<div class='alert alert-success'>Daftar buku berhasil di update.</div>";
                            } else if ($_GET['alert'] == "delete") {
                                echo "<div class='alert alert-success'>Daftar buku berhasil di hapus.</div>";
                            }
                        }
                        ?>
                        <div class="row">
                            <section class="col-lg-12 col-lg-offset-1">
                                <div class="box box-info">

                                    <div class="box-header pb-3">
                                        <a href="buku_tambah.php" class="btn btn-info btn-sm"><i class="fa fa-plus"></i> &nbsp Tambah Buku</a>
                                    </div>
                                    <div class="box-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-striped" id="table-datatable">
                                                <thead>
                                                    <tr>
                                                        <th>ISBN</th>
                                                        <th>TITLE</th>
                                                        <th>AUTHOR</th>
                                                        <th>CATEGORY</th>
                                                        <th>PUBLISHER</th>
                                                        <th>YEAR_PUBLISHER</th>
                                                        <th>COPIES</th>
                                                        <th width="10%">OPSI</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <?php
                                                    include '../connection.php';
                                                    $data = mysqli_query($db, "SELECT * FROM book");
                                                    while ($d = mysqli_fetch_array($data)) {
                                                    ?>
                                                        <tr>
                                                            <td><?php echo $d['isbn']; ?></td>
                                                            <td><?php echo $d['title']; ?></td>
                                                            <td><?php echo $d['author']; ?></td>
                                                            <td><?php echo $d['category']; ?></td>
                                                            <td><?php echo $d['publisher']; ?></td>
                                                            <td><?php echo $d['year_published']; ?></td>
                                                            <td><?php echo $d['copies']; ?></td>
                                                            <td>
                                                                <a class="btn btn-warning btn-sm" href="bookEdit.php?id=<?php echo $d['isbn'] ?>"><i class="fa fa-cog"></i></a>
                                                                <a class="btn btn-danger btn-sm" href="bookDelete.php?id=<?php echo $d['isbn'] ?>" onClick="return confirm('Apakah Anda yakin untuk menghapus data ini?')"><i class="fa fa-trash"></i></a>
                                                            </td>
                                                        </tr>
                                                    <?php
                                                    }
                                                    ?>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                </div>
                            </section>
                            <!-- /.col -->
                        </div>
                        <!-- /.row -->
                    </div>

                </div>
                <!-- /.card -->
            </div>
            <!-- /.col -->
        </div>
    </section>

</div>

<?php include 'footer.php'; ?>