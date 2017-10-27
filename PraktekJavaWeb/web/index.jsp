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
    </head>
    <body>
        <h1>Form Pertama</h1>
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
        %>
        <form name="myForm" action="index.jsp" method="POST"><table border="0">
                <tbody>
                    <tr>
                        <td>Nama Depan</td>
                        <td>:</td>
                        <td><input type="text" name="tnamadepan" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td>Nama Belakang</td>
                        <td>:</td>
                        <td><input type="text" name="tnamabelakang" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td>Email</td>
                        <td>:</td>
                        <td><input type="text" name="temail" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td>Jenis Kelamin</td>
                        <td>:</td>
                        <td><select name="jk">
                                <option>Laki-laki</option>
                                <option>Perempuan</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td>Tanggal Lahir</td>
                        <td>:</td>
                        <td><input type="date" name="ttanggallahir" value="" size="50" /></td>
                    </tr>
                </tbody>
            </table>
            <input type="reset" value="Clear" name="clear" />
            <input type="submit" value="Simpan" name="simpan" />
        </form>
        <script language="JavaScript">
            function tampilPesan(){
                if(document.myForm.hidden.value == 1){
                    alert("Data berhasil disimpan");
                }
            }
        </script>
    </body>
</html>
