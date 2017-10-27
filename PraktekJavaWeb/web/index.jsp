<%-- 
    Document   : index
    Created on : Oct 22, 2017, 3:32:24 PM
    Author     : fahmi
--%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Praktikum Java Web</title>
        <link href="css/bootstrap.min.css" rel="stylesheet"/>
    </head>
    <body onload="tampilPesan()">
            <nav class="navbar navbar-default">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="#">PraktikumJavaWeb</a>
                    </div>
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="#">Home</a></li>
                        <li><a href="#">about</a></li>
                    </ul>
                </div>
            </nav>
        <%!
            public class Anggota{
                String URL = "jdbc:mysql://localhost:3306/db_javaweb";
                String USERNAME = "root";
                String PASSWORD = "";
                String insertSQL = "insert into t_anggota (nama_depan, "
                            + "nama_belakang, email, jenis_kelamin, "
                            + "tanggal_lahir,last_update) VALUES "
                            + "(?,?,?,?,?,?)";
                String selectSQL = "select nama_depan, nama_belakang, email, "
                            + "jenis_kelamin, tanggal_lahir FROM t_anggota";
                Connection connection = null;
                PreparedStatement insertAnggota = null;
                PreparedStatement selectAnggota = null;
                ResultSet resultSet = null;

                public Anggota(){
                    try{
                        connection = DriverManager.getConnection(URL,
                                                    USERNAME,
                                                    PASSWORD);
                        insertAnggota = connection.prepareStatement(insertSQL);
                        selectAnggota = connection.prepareStatement(selectSQL);
                    }catch(SQLException e) {
                        e.printStackTrace();
                    }
                }

                public ResultSet getAnggota(){
                    try{
                        resultSet = selectAnggota.executeQuery();
                    }catch (SQLException e){
                        System.out.print(e);
                    }
                    return resultSet;
                }
                
                public int setAnggota(String namaDepan, String namaBelakang,
                                      String email, String jenisKelamin,
                                      String tanggalLahir, Timestamp ts){
                    int result = 0;
                    try{
                        insertAnggota.setString(1, namaDepan);
                        insertAnggota.setString(2, namaBelakang);
                        insertAnggota.setString(3, email);
                        insertAnggota.setString(4, jenisKelamin);
                        insertAnggota.setString(5, tanggalLahir);
                        insertAnggota.setTimestamp(6, ts);
                        result = insertAnggota.executeUpdate();
                    }catch(SQLException e){
                        System.out.print(e);
                    }
                    return result;
                }
            }
        %>
        <%
            int result = 0;
            String namaDepan = new String();
            String namaBelakang = new String();
            String email = new String();
            String jenisKelamin = new String();
            String tanggalLahir = new String();
            
            Date date = new Date();
            Timestamp ts = new Timestamp(date.getTime());
            
            if(request.getParameter("simpan")!=null){
                namaDepan = request.getParameter("tnamadepan");
                namaBelakang = request.getParameter("tnamabelakang");
                email = request.getParameter("temail");
                jenisKelamin = request.getParameter("jk");
                tanggalLahir = request.getParameter("ttanggallahir");
                
                Anggota anggota = new Anggota();
                result = anggota.setAnggota(namaDepan, namaBelakang, email, 
                        jenisKelamin, tanggalLahir, ts);
            }
            Anggota anggota = new Anggota();
            ResultSet anggotas = anggota.getAnggota();
        %>
        <div class="container">
            <div class="row">
                <div class="col-md-10 col-md-offset-1">
                    <h1>Form Pertama </h1>
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <form name="myForm" action="index.jsp" method="POST"><table border="0">
                                    <div class="form-group">
                                        <label for="">Nama Depan </label>
                                        <input type="text" class="form-control" name="tnamadepan" placeholder="nama depan">
                                    </div>
                                    <div class="form-group">
                                        <label for="">Nama Belakang</label>
                                        <input type="text" class="form-control" name="tnamabelakang" placeholder="nama belakang">
                                    </div>
                                    <div class="form-group">
                                        <label for="">Email</label>
                                        <input type="text" class="form-control" name="temail" placeholder="Email">
                                    </div>
                                    <div class="form-group">
                                        <label for="">Jenis Kelamin</label>
                                        <select name="jk" class="form-control">
                                            <option>Laki-laki</option>
                                            <option>Perempuan</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="">Tanggal Lahir</label>
                                        <input type="date" class="form-control" name="ttanggallahir">
                                    </tbody>
                                </table>
                                <input type="reset" value="Clear" name="clear" class="btn btn-primary">
                                <input type="submit" value="Simpan" name="simpan" class="btn btn-primary">
                            </form>
                        </div>
                    </div>
                    <script language="JavaScript">
                        function tampilPesan(){
                            if(document.myForm.hidden.value == 1){
                                alert("Data berhasil disimpan");
                            }
                        }
                    </script>
                    <br>
                    <br>    
                    <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>NO</th>
                                <th>Nama Depan</th>
                                <th>Nama Belakang</th>
                                <th>Email</th>
                                <th>Jenis Kelamin</th>
                                <th>Tanggal Lahir</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% int i=1; %>
                            <% while (anggotas.next()){ %>
                            <tr>
                                <td><%= i %></td>
                                <td><%= anggotas.getString("nama_depan") %></td>
                                <td><%= anggotas.getString("nama_belakang") %></td>
                                <td><%= anggotas.getString("email") %></td>
                                <td><%= anggotas.getString("jenis_kelamin") %></td>
                                <td><%= anggotas.getString("tanggal_lahir") %></td>
                            </tr>
                            <% i++; %>
                            <% } %>
                        </tbody>
                    </table>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
