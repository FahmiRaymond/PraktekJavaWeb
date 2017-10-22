<%-- 
    Document   : display
    Created on : Oct 22, 2017, 4:14:38 PM
    Author     : fahmi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Praktikum Java Web</title>
    </head>
    <body>
        <h1>Display</h1>
        <% 
            String namaDepan =request.getParameter("tnamadepan");
            String namaBelakang =request.getParameter("tnamabelakang");
            String email =request.getParameter("temail");
            String jk =request.getParameter("jk");
            String tanggalLahir =request.getParameter("ttanggallahir");
            %>
    </body>
</html>
