<?php include 'header.php'; ?>
<!-- Sidebar Menu -->
<nav class="mt-2">
    <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
        <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
        <li class="nav-item menu-open">
            <a href="#" class="nav-link active">
                <i class="nav-icon fas fa-tachometer-alt"></i>
                <p>
                    Dashboard
                    <i class="right fas fa-angle-left"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
                <li class="nav-item">
                    <a href="index.php" class="nav-link">
                        <i class="far fa-circle nav-icon"></i>
                        <p>Daftar Buku</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="overDueBook.php" class="nav-link active">
                        <i class="far fa-circle nav-icon"></i>
                        <p>Over Due Book</p>
                    </a>
                </li>
                <!-- <li class="nav-item">
                  <a href="./index3.html" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Dashboard v3</p>
                  </a>
                </li> -->
            </ul>
        </li>
        <!-- /.sidebar-menu -->
        </div>
        <!-- /.sidebar -->
        </aside>

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
                                <li class="breadcrumb-item active">Over Due Book</li>
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
                                <h3 class="card-title">Buku yang belum dikembalikan</h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body">
                                <div class="row">
                                    <section class="col-lg-12 col-lg-offset-1">
                                        <div class="box box-info">
                                            <div class="box-body">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered table-striped" id="table-datatable">
                                                        <thead>
                                                            <tr>
                                                                <th>ISBN</th>
                                                                <th>RETURN DATE</th>
                                                                <th>READER NAME</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <?php
                                                            include '../connection.php';
                                                            $sql = "call overdueBook()";
                                                            $query = $db->query($sql);
                                                            while ($d = mysqli_fetch_array($query)) {
                                                            ?>
                                                                <tr>
                                                                    <td><?php echo $d['isbn']; ?></td>
                                                                    <td><?php echo $d['return_date']; ?></td>
                                                                    <td><?php echo $d['reader_name']; ?></td>
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

            <?php include 'footer.php'; ?>